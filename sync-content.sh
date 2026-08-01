#!/bin/bash
# Re-sync notes from your Obsidian vault into the site, then publish.
# Usage: ./sync-content.sh [path-to-vault]
set -e
cd "$(dirname "$0")"
VAULT="${1:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian}"
[ -d "$VAULT/20_Concepts" ] || { echo "Vault not found at: $VAULT"; echo "Pass the path: ./sync-content.sh /path/to/vault"; exit 1; }
rm -rf content/10_Units content/20_Concepts content/90_Attachments
cp -R "$VAULT/10_Units" "$VAULT/20_Concepts" "$VAULT/90_Attachments" content/

# Normalize display-math fences for Quartz's stricter parser:
# Obsidian accepts "$$\begin{aligned}" and "\end{aligned}$$" on shared lines;
# Quartz (micromark) needs each $$ fence of a MULTI-LINE block on its own line.
# Single-line "$$x = 1$$" equations are valid and left untouched.
find content -name '*.md' -print0 | xargs -0 perl -pi -e '
  s/^(\$\$)(?=\S)/$1\n/ unless /^\$\$.*\$\$\s*$/;
  s/^(?!\$\$)(.*\S)(\$\$)\s*$/$1\n$2/ unless /\$\$.*\$\$/;
'

# Lint for stray literal "#" in body prose.
# Obsidian ignores "#word" in a sentence, but Quartz/OFM turns any "#word"
# preceded by a space or line start into a TAG -- injecting it into the note's
# frontmatter and spawning a junk tag page on the site. Fix by writing the
# counting-# as maths: $\#\text{leaves}$ / $\#$cols  (never **#leaves**).
# Code spans, fenced blocks, indented blocks and $...$ maths are safe.
STRAY=$(find content -name '*.md' -print0 | xargs -0 perl -ne '
  BEGIN { $fm = 0; $fence = 0; $last = "" }
  if ($. == 1) { $fm = 0; $fence = 0 }
  if ($. == 1 && /^---\s*$/) { $fm = 1; next }
  if ($fm) { $fm = 0 if /^---\s*$/; next }
  if (/^\s*(>\s*)*```/) { $fence = !$fence; next }
  next if $fence;
  next if /^(>\s*)*(    |\t)/;      # indented code block
  next if /^#{1,6} /;               # ATX heading
  $l = $_;
  $l =~ s/`[^`]*`/ /g;              # inline code
  $l =~ s/\$[^\$\n]*\$/ /g;         # inline maths
  while ($l =~ /(?<![\w\\])#([-_\w]+(?:\/[-_\w]+)*)/g) {
    next if $1 =~ m{^[\d/]+$};      # pure numbers are ignored by Quartz
    print "$ARGV:$.: #$1\n";
  }
  close ARGV if eof;
')
if [ -n "$STRAY" ]; then
  echo "⚠️  Stray '#' in body prose — Quartz will publish these as junk tags:"
  echo "$STRAY"
  echo "   Fix in the VAULT (wrap as maths, e.g. \$\\#\\text{leaves}\$), then re-run."
fi

echo "✅ Synced + math fences normalized."
echo "To publish:  git add -A && git commit -m 'update notes' && git push"