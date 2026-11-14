#!/bin/sh
# package.sh TARGET: builds The Clans (make, serially: its link-time
# optimisation races under -j) with the current CC, CFLAGS and LDFLAGS,
# stages the av archive (asciiverse/stage.sh) and writes
# dist/the-clans-TARGET.tar.gz.
set -eu
target=$1
root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"
make ${CFLAGS:+CFLAGS="$CFLAGS"} ${LDFLAGS:+LDFLAGS="$LDFLAGS"}
rm -rf stage-av && sh asciiverse/stage.sh "$root/stage-av"
mkdir -p dist
tar -czf "dist/the-clans-$target.tar.gz" -C stage-av .
ls -l dist
