#!/usr/bin/env bash
# Log a live session: bash scripts/new-session.sh YYYY-MM-DD "https://recording-link"
set -euo pipefail
cd "$(dirname "$0")/.."
DATE="${1:?usage: new-session.sh YYYY-MM-DD RECORDING_URL}"
URL="${2:-TBD}"
FILE="sessions/${DATE}.md"
[ -e "$FILE" ] && { echo "$FILE already exists"; exit 1; }
sed -e "s|{DATE}|${DATE}|g" -e "s|{RECORDING}|${URL}|g" sessions/_TEMPLATE.md > "$FILE"
ROW="| ${DATE} | [Watch](${URL}) | [Notes](${FILE}) |"
python3 - "$ROW" <<'PY'
import sys
row = sys.argv[1]
s = open("README.md").read()
marker = "<!-- sessions:end -->"
s = s.replace("| _First session coming soon_ | | |\n", "")
s = s.replace(marker, row + "\n" + marker)
open("README.md", "w").write(s)
PY
echo "Created $FILE and added it to README.md"
echo "Next: git add -A && git commit -m \"Session ${DATE}\" && git push"
