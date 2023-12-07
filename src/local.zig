///	Refresh (R_*) module, global header.
///	All the rendering/drawing stuff is here.
const std = @import("std");
const DOOM = @import("libdoom.zig");

pub usingnamespace @import("renderer/bsp.zig");
pub usingnamespace @import("renderer/data.zig");
pub usingnamespace @import("renderer/draw.zig");
pub usingnamespace @import("renderer/plane.zig");
pub usingnamespace @import("renderer/segments.zig");
pub usingnamespace @import("renderer/things.zig");

//todo: #include "r_bsp.h"
//todo: #include "r_segs.h"
//todo: #include "r_plane.h"
//todo: #include "r_data.h"
//todo: #include "r_things.h"
//todo: #include "r_draw.h"

viewCos: DOOM.Fixed,
viewSin: DOOM.Fixed,
viewWidth: i16,
viewHeight: i16,
viewWindowX: i16,
viewWindowY: i16,

centerX: i16,
centerY: i16,

centerXFrac: DOOM.Fixed,
centerYFrac: DOOM.Fixed,
projection: DOOM.Fixed,

validCount: i16,
lineCount: i16,
loopCount: i16,

scaleLight: [LightLevels][MaxLightScale]*DOOM.LightTable,
scaleLightFixed: [MaxLightScale]*DOOM.LightTable,
zLight: [LightLevels][MaxLightZ]*DOOM.LightTable,

extraLight: i16,
fixedColorMap: *DOOM.LightTable,

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
    x: DOOM.Fixed,
    y: DOOM.Fixed,
    node: *DOOM.MapNode,
) i16 {
    _ = node;
    _ = y;
    _ = x;
}

pub fn pointOnSegSide(
    x: DOOM.Fixed,
    y: DOOM.Fixed,
    line: *DOOM.MapSegment,
) i16 {
    _ = line;
    _ = y;
    _ = x;
}

pub fn pointToAngle(
    x: DOOM.Fixed,
    y: DOOM.Fixed,
) DOOM.Fixed {
    _ = y;
    _ = x;
}

pub fn pointToAngle2(
    x1: DOOM.Fixed,
    y1: DOOM.Fixed,
    x2: DOOM.Fixed,
    y2: DOOM.Fixed,
) DOOM.Fixed {
    _ = y2;
    _ = x2;
    _ = y1;
    _ = x1;
}

pub fn pointToDist(
    x: DOOM.Fixed,
    y: DOOM.Fixed,
) DOOM.Fixed {
    _ = y;
    _ = x;
}

pub fn scaleFromGlobalAngle(
    visAngle: DOOM.Angle,
) DOOM.Fixed {
    _ = visAngle;
}

pub fn pointInSubsector(
    x: DOOM.Fixed,
    y: DOOM.Fixed,
) *DOOM.SubSector {
    _ = y;
    _ = x;
}

pub fn addPointToBox(
    x: DOOM.Fixed,
    y: DOOM.Fixed,
    box: *DOOM.Fixed,
) DOOM.Fixed {
    _ = box;
    _ = y;
    _ = x;
}

/// REFRESH - the actual rendering functions.
/// Called by G_Drawer.
pub fn renderPlayerView(player: *DOOM.Player) void {
    _ = player;
}

/// Called by startup code.
pub fn init() void {}

/// Called by M_Responder.
pub fn setViewSize(blocks: i16, detail: i16) void {
    _ = detail;
    _ = blocks;
}
