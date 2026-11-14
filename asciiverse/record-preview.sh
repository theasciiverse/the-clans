#!/bin/sh
# Records asciiverse/the-clans.cast, the catalog preview (100x30,
# hub/RECORDING.md): a fresh village, a clan of four made, the village,
# then the mines and a fight. Needs a staged build (asciiverse/stage.sh
# stage-av), tmux and asciinema 3.
#
# Not hub/tools/castrec.py: The Clans measures the screen by asking the
# terminal where its cursor is, and castrec always answers "1;1", so the
# game sees a one-cell screen. Here asciinema records inside a real tmux
# terminal of 100x30, and the keys go in through tmux.
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
out="$root/asciiverse/the-clans.cast"
state=$(mktemp -d)
sock="clans-rec-$$"
trap 'tmux -L "$sock" kill-server 2>/dev/null || true; rm -rf "$state"' EXIT
rm -f "$out"
tmux -L "$sock" new-session -d -x 100 -y 30 \
	"env -i HOME=$state PATH=/usr/bin:/bin TERM=xterm-256color COLORTERM=truecolor LANG=C.UTF-8 USER=player LOGNAME=player XDG_STATE_HOME=$state \
	 asciinema rec -q --overwrite --cols 100 --rows 30 -c '$root/stage-av/the-clans' '$out'"
k() { tmux -L "$sock" send-keys "$@"; }
w() { sleep "$1"; }
member() { # race class name
	k "$1"; w 0.6; k y; w 0.6; k "$2"; w 0.6; k y; w 0.9; k y; w 0.6
	k "$3"; w 0.4; k Enter; w 1.0; k Enter; w 0.6
}
w 4; k Enter; w 2.5; k Enter; w 2.5; k Enter; w 2.5; k e; w 2.5; k Enter; w 1.2; k y; w 1.0
k Ravens; w 0.4; k Enter; w 0.8; k y; w 2.0; k Enter; w 1.0
member a b Corvin; member b g Brakka; member c f Elowen; member e e Pip
w 2.5; k Enter; w 3.5; k q; w 4; k e; w 2; k Enter; w 2.5; k l; w 2.5; k Enter; w 1.5; k l; w 2
for i in 1 2 3 4 5 6 7 8; do k a; w 1.2; done
w 2
# the recording ends mid-fight: closing tmux ends asciinema (trap above)
