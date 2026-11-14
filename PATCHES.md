# Changes from upstream

This is the Asciiverse packaging of **The Clans** 0.97b2, Allen Ussher's
BBS door game (1997 to 2002, source released by him in 2002), as kept and
modernised in the Synchronet tree by Rob Swindell, Deuce, Stephen Hurd and
others. GPL-2.0 (`LICENSE`); its OpenDoors library (Brian Pirie, with Rob
Swindell's changes) is LGPL-2.1 (`odoors/LICENSE`).

## Where it comes from

- `a02ebac`: Synchronet's `src/doors/clans-src` at sbbs commit
  `55526e5885fa` (2026-07-25), from https://gitlab.synchro.net/main/sbbs
  (the `upstream` remote; the whole BBS tree, not fetched here). Tagged
  `synchronet-55526e5`. Imported as one commit: the subtree's own history
  lives in the much larger sbbs repository.
- `68640cb`: OpenDoors from the same commit's `src/odoors`, placed where
  clans-src's `odoors` symlink (`../../odoors`) pointed, so this repository
  builds on its own.

## Ours

- **`reset --local`** (`src/reset.c`): makes a fresh local game with the
  reset program's own default settings and no menu, so a launcher can found
  a village. The default values moved into `InitDefaults()`, used by the
  menu as before. Written to go upstream.
- **`CLANS_LOCAL_TIMELIMIT`** (`src/door.c`): the minutes a local session
  may last (1 to 1440); unset, it stays 30 as before. Written to go
  upstream.

## Packaging

- `asciiverse/the-clans`: the launcher. It keeps the village in the
  player's state folder (`$XDG_STATE_HOME/the-clans`, or
  `~/Library/Application Support/the-clans` on macOS), copies the shipped
  data there on every start, writes a `clans.cfg` for a local game with the
  game's own activity log on (`clans*.log` in that folder), founds the
  village with `reset --local` the first time, and starts `clans /L` with
  480 minutes a session. `--reset` starts afresh. Several players share
  the village by logging in with different names.
- `asciiverse/stage.sh`: the av archive (launcher, `lib/clans`,
  `lib/reset`, `game/` with the data files from `make install`, without
  the sysop tools, the Windows batch file and the LLM quest guide).
- `asciiverse/nfpm.yaml`: .deb, .rpm, .apk and Arch packages (the game in
  `/usr/lib/the-clans`, `/usr/bin/the-clans` linked to its launcher).
- `.github/workflows/asciiverse-release.yml`: static Linux (musl, x86-64
  and ARM64) and macOS (x86-64 and ARM64) on a tag. `make` runs serially:
  its link-time optimisation races under `-j`.
- `asciiverse/record-preview.sh` and `asciiverse/the-clans.cast`: the
  catalog preview.
