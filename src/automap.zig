///  AutoMap module.
const std = @import("std");
const DOOM = @import("libdoom");


/// Used by ST StatusBar stuff.
pub const MSGHEADER = (('a' << 24) + ('m' << 16));
pub const MSGENTERED = (MSGHEADER | ('e' << 8));
pub const MSGEXITED = (MSGHEADER | ('x' << 8));

/// Called by main loop.
pub fn responder(event: *DOOM.Event) bool {
    _ = event;
}

/// Called by main loop.
pub fn ticker() void {}

/// Called by main loop,
/// called instead of view drawer if automap active.
pub fn drawer() void {}

/// Called to force the automap to quit
/// if the level is completed while it is up.
pub fn stop() void {}
