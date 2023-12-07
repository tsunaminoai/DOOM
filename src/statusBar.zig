///	Status bar code.
///	Does the face/direction indicator animatin.
///	Does palette indicators as well (red pain/berserk, bright pickup)
const std = @import("std");
const DOOM = @import("libdoom.zig");

/// Size of statusbar.
/// Now sensitive for scaling.
pub const STATUSBAR_HEIGHT = 32 * DOOM.SCREEN_MUL;
pub const STATUSBAR_WIDTH = DOOM.SCREENWIDTH;
pub const STATUSBAR_Y = DOOM.SCREENHEIGHT - STATUSBAR_HEIGHT;

/// STATUS BAR
/// Called by main loop.
pub fn responder(event: *DOOM.Event) bool {
    _ = event;
}

/// Called by main loop.
pub fn ticker() void {}

/// Called by main loop.
pub fn drawer(fullscreen: bool, refresh: bool) void {
    _ = refresh;
    _ = fullscreen;
}

/// Called when the console player is spawned on each level.
pub fn start() void {}

/// Called by startup code.
pub fn init() void {}

/// States for status bar code.
pub const StatusBarState = enum {
    Automap,
    FirstPerson,
};

/// States for the chat code.
pub const ChatState = enum {
    startChat,
    waitDest,
    getState,
};
