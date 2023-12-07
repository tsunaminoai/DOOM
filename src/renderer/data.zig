///  Refresh module, data I/O, caching, retrieval of graphics
///  by name.
const std = @import("std");
const Defs = @import("definitions.zig");
const State = @import("state.zig");

/// Retrieve column data for span blitting.
pub fn getColumn(tex: i16, col: i16) *u8 {
    _ = col;
    _ = tex;
}

/// I/O, setting up the stuff.
pub fn initData() void {}
pub fn preCacheLevel() void {}

/// Retrieval.
/// Floor/ceiling opaque texture tiles,
/// lookup by name. For animation?
pub fn flatNumForName(name: []const u8) i16 {
    _ = name;
}

// Called by P_Ticker for switches and animations,
// returns the texture number for the texture name.
pub fn textureNumForName(name: []const u8) i16 {
    _ = name;
}
pub fn checkTextureForName(name: []const u8) i16 {
    _ = name;
}
