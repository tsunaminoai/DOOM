///	Refresh (R_*) module, global header.
///	All the rendering/drawing stuff is here.
const std = @import("std");
const Fixed = @import("fixed.zig");
const Data = @import("data.zig");
const Player = @import("player.zig");
const Renderer = @import("renderer/renderer.zig");

//todo: #include "r_segs.h"
//todo: #include "r_plane.h"
//todo: #include "r_data.h"
//todo: #include "r_things.h"
//todo: #include "r_draw.h"

viewCos: Fixed.Fixed,
viewSin: Fixed.Fixed,
viewWidth: i16,
viewHeight: i16,
viewWindowX: i16,
viewWindowY: i16,

centerX: i16,
centerY: i16,

centerXFrac: Fixed.Fixed,
centerYFrac: Fixed.Fixed,
projection: Fixed.Fixed,

validCount: i16,
lineCount: i16,
loopCount: i16,

scaleLight: [LightLevels][MaxLightScale]*Renderer.LightTable,
scaleLightFixed: [MaxLightScale]*Renderer.LightTable,
zLight: [LightLevels][MaxLightZ]*Renderer.LightTable,

extraLight: i16,
fixedColorMap: *Renderer.LightTable,

/// Blocky/low detail mode.
///B remove this?
///  0 = high, 1 = low
detailShift: i16,

/// Function pointers to switch refresh/drawing functions.
/// Used to select shadow mode etc.
colorFunc: *fn () void,
baseColFunc: *fn () void,
fuzzColFunc: *fn () void,
spanFun: *fn () void,

/// Lighting LUT.
/// Used for z-depth cuing per column/row,
///  and other lighting effects (sector ambient, flash).
pub const LightLevels = 16;
pub const LightSegShift = 4;
pub const MaxLightScale = 48;
pub const MaxScaleShift = 12;
pub const MaxLightZ = 128;
pub const LightZShift = 20;

/// Number of diminishing brightness levels.
/// There a 0-31, i.e. 32 LUT in the COLORMAP lump.
pub const NumColorMaps = 32;

/// Utility Functions
pub fn pointOnSide(
    x: Fixed.Fixed,
    y: Fixed.Fixed,
    node: *Data.MapNode,
) i16 {
    _ = node;
    _ = y;
    _ = x;
}

pub fn pointOnSegSide(
    x: Fixed.Fixed,
    y: Fixed.Fixed,
    line: *Data.MapSegment,
) i16 {
    _ = line;
    _ = y;
    _ = x;
}

pub fn pointToAngle(
    x: Fixed.Fixed,
    y: Fixed.Fixed,
) Fixed.Fixed {
    _ = y;
    _ = x;
}

pub fn pointToAngle2(
    x1: Fixed.Fixed,
    y1: Fixed.Fixed,
    x2: Fixed.Fixed,
    y2: Fixed.Fixed,
) Fixed.Fixed {
    _ = y2;
    _ = x2;
    _ = y1;
    _ = x1;
}

pub fn pointToDist(
    x: Fixed.Fixed,
    y: Fixed.Fixed,
) Fixed.Fixed {
    _ = y;
    _ = x;
}

pub fn scaleFromGlobalAngle(
    visAngle: Fixed.Angle,
) Fixed.Fixed {
    _ = visAngle;
}

pub fn pointInSubsector(
    x: Fixed.Fixed,
    y: Fixed.Fixed,
) *Fixed.SubSector {
    _ = y;
    _ = x;
}

pub fn addPointToBox(
    x: Fixed.Fixed,
    y: Fixed.Fixed,
    box: *Fixed.Fixed,
) Fixed.Fixed {
    _ = box;
    _ = y;
    _ = x;
}

/// REFRESH - the actual rendering functions.
/// Called by G_Drawer.
pub fn renderPlayerView(player: *Player.Player) void {
    _ = player;
}

/// Called by startup code.
pub fn init() void {}

/// Called by M_Responder.
pub fn setViewSize(blocks: i16, detail: i16) void {
    _ = detail;
    _ = blocks;
}
