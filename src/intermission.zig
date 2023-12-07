///  Intermission.
const std = @import("std");
const DOOM = @import("libdoom.zig");

/// States for the intermission
pub const IntermissionState = enum(i16) {
    NoState = -1,
    StatCount,
    ShowNextLoc,
};

/// Called by main loop, animate the intermission.
pub fn ticker() void {}

/// Called by main loop,
/// draws the intermission directly into the screen buffer.
pub fn drawer() void {}

/// Setup for an intermission screen.
pub fn start(wbstart: *DOOM.WebStart) void {
    _ = wbstart;
}
