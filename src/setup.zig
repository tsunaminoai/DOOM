///   Setup a game, startup stuff.
const std = @import("std");
const Defs = @import("definitions.zig");

/// NOT called by W_Ticker. Fixme.
pub fn setupLevel(episode: i16, map: i16, playermask: i16, skill: Defs.Skill) void {
    _ = skill;
    _ = playermask;
    _ = map;
    _ = episode;
}

/// Called by startup code.
pub fn init() void {}
