///	Refresh module, BSP traversal and handling.
const std = @import("std");
const DOOM = @import("../libdoom.zig");

curline: *DOOM.MapSegment,
sideDef: *DOOM.MapSideDef,
lineDef: *DOOM.MapLineDef,
frontSector: *DOOM.MapSector,
backSector: *DOOM.MapSector,

rw_x: i16,
rw_stopx: i16,

segmentTextured: bool,

/// false if the back side is the same plane
markFloor: bool,
markCeiling: bool,
skyMap: bool,

drawSegments: [DOOM.MAXDRAWSEGS]DOOM.DrawSegment,
ds_p: *DOOM.DrawSegment,

hscaleLight: **DOOM.LightTable,
vscaleLight: **DOOM.LightTable,
dscaleLight: **DOOM.LightTable,

// typedef void (*drawfunc_t) (int start, int stop);
drawFunction: *fn (start: i16, stop: i16) void,

pub fn clearClipSegments() void {}
pub fn clearDrawSegments() void {}

pub fn renderBSPNode(bspnum: i16) void {
    _ = bspnum;
}
