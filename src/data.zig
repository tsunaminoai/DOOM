const std = @import("std");
const defs = @import("definitions.zig");

pub const Lumps = enum(u8) {
    label,
    things,
    lineDefs,
    sideDefs,
    vertexts,
    segments,
    subSectors,
    nodes,
    sectors,
    reject,
    blockmap,
};

pub const MapVertex = struct {
    x: i16,
    y: i16,
};

pub const MapSideDef = struct {
    textureOffset: i16,
    rowOffset: i16,
    topTexture: [8]u8,
    bottomTexture: [8]u8,
    midTextture: [8]u8,
    sector: i16,
};

pub const MapLineDef = struct {
    v1: i16,
    v2: i16,
    flags: i16,
    special: i16,
    tag: i16,
    sideNumber: [2]i16,
};

pub const Blocking = 1;
pub const BlockMonsters = 2;
pub const TwoSided = 4;
pub const DontPegTop = 8;
pub const DontPegBottom = 16;
pub const Secret = 32;
pub const SoundBlock = 64;
pub const DontDraw = 128;
pub const Mapped = 256;

pub const MapSector = struct {
    floorHeight: i16,
    ceilingHeight: i16,
    floorPic: [8]u8,
    ceilingPic: [8]u8,
    lightLevel: i16,
    special: i16,
    tag: i16,
};
pub const MapSubSector = struct {
    numSegments: i16,
    firstSegment: i16,
};

pub const MapSegment = struct {
    v1: i16,
    v2: i16,
    angle: i16,
    lineDef: i16,
    side: i16,
    offset: i16,
};

pub const SubSector = 0x8000;

pub const MapNode = struct {
    x: i16,
    y: i16,
    dx: i16,
    dy: i16,

    boundingBox: [2][4]i16,
    children: [2]u16,
};

pub const MapThing = struct {
    x: i16,
    y: i16,
    angle: i16,
    tType: i16,
    options: i16,
};
