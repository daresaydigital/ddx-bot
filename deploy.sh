#!/usr/bin/env bash
# Deploy desk: put a team's robot face live at
#   https://daresaydigital.github.io/ddx-bot/team-N/
#
#   ./deploy.sh 3 ~/Downloads/robot.html   # publish a team's HTML file
#   ./deploy.sh 3 https://xyz.lovable.app   # redirect to an already-hosted prototype
#   ./deploy.sh 3 --reset                  # back to Plain Bot
#   ./deploy.sh all --reset                # reset all 12 teams
#
# Claude artifact code often has no <html>/<head> (claude.ai adds those when
# it shows the page). This script adds them, including the phone viewport tag,
# so the page doesn't render tiny on the phone.
set -euo pipefail
cd "$(dirname "$0")"

TEAMS=12
URL="https://daresaydigital.github.io/ddx-bot"

usage() { sed -n '4,8p' "$0" | sed 's/^# *//'; exit 1; }
[ $# -eq 2 ] || usage

plain_bot() { # $1 = team number
  sed "s|<div id=\"hint\">tap to wake|<div id=\"hint\">team $1 · tap to wake|" index.html
}

publish() { # $1 = team number, $2 = source file or --reset
  local n=$1 src=$2 dest="team-$1/index.html"
  [[ "$n" =~ ^[0-9]+$ ]] && [ "$n" -ge 1 ] && [ "$n" -le $TEAMS ] || { echo "Team must be 1-$TEAMS"; exit 1; }
  mkdir -p "team-$n"
  if [ "$src" = "--reset" ]; then
    plain_bot "$n" > "$dest"
  elif [[ "$src" =~ ^https?:// ]]; then
    python3 - "$src" "$dest" "$n" <<'EOF'
import html, json, sys
url, dest, n = sys.argv[1:]
open(dest, "w", encoding="utf-8").write(f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="refresh" content="0; url={html.escape(url)}">
<title>Team {n}</title>
<script>location.replace({json.dumps(url)})</script>
<style>body{{margin:0;background:#000;color:#888;font:14px ui-monospace,monospace;display:grid;place-items:center;height:100vh}}a{{color:#ccc}}</style>
</head><body><a href="{html.escape(url)}">Team {n} →</a></body></html>
""")
EOF
  else
    [ -f "$src" ] || { echo "No such file: $src"; exit 1; }
    python3 - "$src" "$dest" <<'EOF'
import re, sys
src, dest = sys.argv[1], sys.argv[2]
s = open(src, encoding="utf-8").read()
viewport = '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">'
if not re.search(r"<html[\s>]", s, re.I):
    # Mirror the small reset claude.ai puts around artifacts
    reset = "<style>body{margin:0}img{max-width:100%}[hidden]{display:none!important}</style>"
    s = ('<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n' + viewport +
         '\n' + reset + '\n</head>\n<body>\n' + s + '\n</body>\n</html>\n')
elif not re.search(r'name=["\']viewport', s, re.I):
    s = re.sub(r"<head[^>]*>", lambda m: m.group(0) + "\n" + viewport, s, count=1, flags=re.I)
open(dest, "w", encoding="utf-8").write(s)
EOF
  fi
  git add "$dest"
}

if [ "$1" = "all" ]; then
  [ "$2" = "--reset" ] || usage
  for i in $(seq 1 $TEAMS); do publish "$i" --reset; done
  msg="Reset all teams to Plain Bot"
else
  publish "$1" "$2"
  [ "$2" = "--reset" ] && msg="Reset team $1 to Plain Bot" || msg="Deploy team $1"
fi

if git diff --cached --quiet; then
  echo "Nothing changed."
else
  git commit -q -m "$msg"
  git push -q
  echo "Pushed. Live in about a minute:"
fi
[ "$1" = "all" ] && echo "  $URL/teams/" || echo "  $URL/team-$1/"
