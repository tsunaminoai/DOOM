///  Sprite animation.
const std = @import("std");
const Fixed = @import("fixed.zig");
const Tables = @import("tables.zig");
const Info = @import("info.zig");


/// Frame flags:
/// handles maximum brightness (torches, muzzle flare, light sources)
pub const FullBright = 0x8000;
pub const FrameMask = 0x7fff;

/// Overlay psprites are scaled shapes
/// drawn directly on the view screen,
/// coordinates are given for a 320*200 view screen.
pub const SpriteNum = enum {
    weapon,
    flash,
    NumSprites,
};

pub const SpriteDef = struct {
    state: ?*Info.State, // a NULL state means not active
    ticks: i32,
    sx: Fixed.Fixed,
    sy: Fixed.Fixed,
};
