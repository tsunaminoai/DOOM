//	Refresh, visplane stuff (floor, ceilings).
const std = @import("std");
const Data = @import("data.zig");
const Defs = @import("definitions.zig");

const planeFunction = fn (top: i16, bottom: i16) void;

// Visplane related.
lastOpening: *i8,

floorFunc: *planeFunction,
ceilingFunc: *planeFunction,

floorClip: [Data.SCREENWIDTH]i8,
ceilingClip: [Data.SCREENWIDTH]i8,

ySlope: [Data.SCREENWIDTH]Defs.Fixed,
distScale: [Data.SCREENWIDTH]Defs.Fixed,

pub fn initPlanes() void {}
pub fn clearPlanes() void {}

pub fn mapPlane(
    y: i16,
    x1: i16,
    x2: i16,
) void {
    _ = y;
    _ = x1;
    _ = x2;
}
pub fn makeSpans(
    x: i16,
    t1: i16,
    b1: i16,
    t2: i16,
    b2: i16,
) void {
    _ = x;
    _ = t1;
    _ = b1;
    _ = t2;
    _ = b2;
}

pub fn drawPlanes() void {}

pub fn findPlane(
    height: Defs.Fixed,
    picNum: i16,
    lightLevel: i16,
) *Defs.VisPlane {
    _ = height;
    _ = picNum;
    _ = lightLevel;
}

pub fn checkPlane(
    pl: *Defs.VisPlane,
    start: i16,
    stop: i16,
) *Defs.VisPlane {
    _ = pl;
    _ = start;
    _ = stop;
}
