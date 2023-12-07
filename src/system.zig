///	System specific interface stuff.
const std = @import("std");
const Ticks = @import("ticks.zig");

/// Called by DoomMain.
pub fn init() void {}

/// Called by startup code
/// to get the ammount of memory to malloc
/// for the zone management.
pub fn zoneBase(size: *i16) *u8 {
    _ = size;
    return 0;
}

/// Called by D_DoomLoop,
/// returns current time in tics.
pub fn getTime() void {}

/// Called by D_DoomLoop,
/// called before processing any tics in a frame
/// (just after displaying a frame).
/// Time consuming syncronous operations
/// are performed here (joystick reading).
/// Can call D_PostEvent.
pub fn startFrame() void {}

/// Called by D_DoomLoop,
/// called before processing each tic in a frame.
/// Quick syncronous operations are performed here.
/// Can call D_PostEvent.
pub fn startTick() void {}

/// Asynchronous interrupt functions should maintain private queues
/// that are read by the synchronous functions
/// to be converted into events.
/// Either returns a null ticcmd,
/// or calls a loadable driver to build it.
/// This ticcmd will then be modified by the gameloop
/// for normal input.
pub fn baseTickCmd() *Ticks.TickCommand {}

/// Called by M_Responder when quit is selected.
/// Clean exit, displays sell blurb.
pub fn quit() void {}

/// Allocates from low memory under dos,
/// just mallocs under unix
pub fn allocLow(length: i16) *u8 {
    _ = length;
}

pub fn tactile(on: i16, off: i16, total: i16) void {
    _ = total;
    _ = off;
    _ = on;
}
