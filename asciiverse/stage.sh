#!/bin/sh
# stage.sh OUTDIR: lays out the av archive from a finished build in the
# repo root (make, run with -j1: the LTO link races under -j).
#   OUTDIR/the-clans        the launcher
#   OUTDIR/lib/clans, reset the game and its reset tool
#   OUTDIR/game/            the data files the game ships with
#   OUTDIR/README.md, LICENSE, LICENSE-OpenDoors, PATCHES.md
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
out=$1
plat=$(ls "$root"/bin/clans.*.opt | sed 's/.*clans\.//')
rm -rf "$out" && mkdir -p "$out/lib" "$out/game"
cp "$root/bin/clans.$plat" "$out/lib/clans"
cp "$root/bin/reset.$plat" "$out/lib/reset"
strip "$out/lib/clans" "$out/lib/reset" 2>/dev/null || true
make -s -C "$root" install INSTALLDIR="$out/inst" >/dev/null
for f in "$out"/inst/*; do
	# programs (the game, its tools and their wrappers) are not data
	[ -f "$f" ] && [ ! -x "$f" ] || continue
	case $(basename "$f") in
	runclans.bat|prompt.md|questgen.txt) ;;
	*) cp "$f" "$out/game/" ;;
	esac
done
rm -rf "$out/inst"
cp "$root/asciiverse/the-clans" "$out/"
cp "$root/asciiverse/README.md" "$out/README.md"
cp "$root/LICENSE" "$out/LICENSE"
cp "$root/odoors/LICENSE" "$out/LICENSE-OpenDoors"
cp "$root/PATCHES.md" "$out/"
