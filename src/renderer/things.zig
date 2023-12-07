///	Rendering of moving objects, sprites.
const std = @import("std");
const Defs = @import("definitions.zig");

pub const MAXVISSPRITES = 128;

visibleSprites: [MAXVISSPRITES]Defs.VisSprite,
visibleSpritePtr: *Defs.VisSprite,
vSprSortedHead: Defs.VisSprite,

/// Constant arrays used for psprite clipping
///  and initializing clipping.
negOneArray: [Defs.DoomDefs.SCREENWIDTH]i8,
screenHeightArray: [Defs.DoomDefs.SCREENWIDTH]i8,

/// vars for R_DrawMaskedColumn
mFloorClip: *i8,
mCeilingClip: *i8,
spriteYScale: Defs.Fixed,
spriteTopScreen: Defs.Fixed,

pSpriteScale: Defs.Fixed,
pSpriteIScale: Defs.Fixed,

pub fn drawMaskedColumn(column: *Defs.Column) void {
    _ = column;
}

pub fn sortVisSprites() void {}
pub fn addSprites(sector: *Defs.Sector) void {
    _ = sector;
}
pub fn drawSprites() void {}
pub fn initSprites(namelist: [][]const u8) void {
    _ = namelist;
}
pub fn clearSprites() void {}
pub fn drawMasked() void {}

pub fn clipVisibleSprite(
    sprite: *Defs.VisSprite,
    xl: i16,
    xh: i16,
) void {
    _ = sprite;
    _ = xl;
    _ = xh;
}
