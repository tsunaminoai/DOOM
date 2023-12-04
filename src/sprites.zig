const std = @import("std");
const fixed = @import("fixed.zig");
const tables = @import("tables.zig");
const info = @import("info.zig");

pub const FullBright = 0x8000;
pub const FrameMask = 0x7fff;

pub const SpriteNum = enum {
    weapon,
    flash,
    NumSprites,
};

pub const SpriteDef = struct {
    state: *info.State,
    ticks: i32,
    sx: fixed.Fixed,
    sy: fixed.Fixed,
};
