///	Refresh module, BSP traversal and handling.
const std = @import("std");
const Data = @import("../data.zig");
const Defs = @import("../definitions.zig");
const Renderer =  @import("renderer.zig");
usingnamespace Renderer;

curline: *Data.MapSegment,
sideDef: *Data.MapSideDef,
lineDef: *Data.MapLineDef,
frontSector: *Data.MapSector,
backSector: *Data.MapSector,

rw_x: i16,
rw_stopx: i16,

segmentTextured: bool,

/// false if the back side is the same plane
markFloor: bool,
markCeiling: bool,
skyMap: bool,

drawSegments: [Defs.MAXDRAWSEGS]Renderer.DrawSegment,
ds_p: *Renderer.DrawSegment,

hscaleLight: **Renderer.LightTable,
vscaleLight: **Renderer.LightTable,
dscaleLight: **Renderer.LightTable,

// typedef void (*drawfunc_t) (int start, int stop);
drawFunction: *fn (start: i16, stop: i16) void,

pub fn clearClipSegments() void {}
pub fn clearDrawSegments() void {}

pub fn renderBSPNode(bspnum: i16) void {
    _ = bspnum;
}
