# The Clans

Allen Ussher's BBS door game of clans, villages and empires (1997), as kept
in the Synchronet tree, packaged for Asciiverse as a game you play on your
own machine.

Run `the-clans`. The first start founds a fresh village; after that the
same village waits for you, day after day. Log in with any name: several
people can each run a clan in the same village on one computer.

- Your village lives in `~/.local/state/the-clans` (Linux) or
  `~/Library/Application Support/the-clans` (macOS).
- `the-clans --reset` starts the village afresh.
- Each in-game day brings new fights; the game runs its daily upkeep by
  itself the first time it is played on a new day.
- `CLANS_LOCAL_TIMELIMIT` sets the minutes per session (default 480).

The Clans is GPL-2.0 (LICENSE); OpenDoors is LGPL-2.1 (LICENSE-OpenDoors).
Changes for Asciiverse are listed in PATCHES.md. Source:
https://github.com/theasciiverse/the-clans
