///	Refresh/render internal state variables (global).
const std = @import("std");
const Player = @import("../player.zig");
const Defs = @import("definitions.zig");
const Tables = @import("../tables.zig");
const Data = @import("data.zig");

/// Refresh internal data structures,
///  for rendering.
textureHeight: *Defs.Fixed.Fixed,

/// needed for pre rendering (fracs)
spriteWidth: *Defs.Fixed.Fixed,

spriteOffset: *Defs.Fixed.Fixed,
spriteTopOffset: *Defs.Fixed.Fixed,

colorMaps: *Defs.LightTable,

viewwidth: i16,
scaledviewwidth: i16,
viewheight: i16,

firstflat: i16,

/// for global animation
flatTranslation: *i16,
textureTranslation: *i16,

firstSpriteLump: i16,
lastSpriteLump: i16,
numSpriteLumps: i16,

/// Lookup tables for map data.
numSprites: i16,
sprites: *Defs.Sprite,

numVertexes: i16,
vertexes: *Defs.Vertex,

numSegments: i16,
segments: *Defs.Segment,

numSectors: i16,
sectors: *Defs.Sector,

numSubSectors: i16,
subSectors: *Defs.SubSector,

numNodes: i16,
nodes: *Defs.Node,

numLines: i16,
lines: *Defs.Line,

numSides: i16,
sides: *Defs.Side,

/// POV data.
viewX: Defs.Fixed.Fixed,
viewY: Defs.Fixed.Fixed,
viewZ: Defs.Fixed.Fixed,

viewAngle: Defs.Fixed.Angle,
viewPlayer: *Player.Player,

clipAngle: Defs.Fixed.Angle,

viewAngleToX: [Tables.FineAngles / 2]i16,
xToViewAngle: [Defs.DoomDefs.SCREENWIDTH + 1]Defs.Fixed.Angle,

rw_distance: Defs.Fixed.Fixed,
rw_normalAngle: Defs.Fixed.Angle,
//extern fixed_t		finetangent[FINEANGLES/2];

/// angle to line origin
rw_angle1: i16,
segmentsCount: i16,

floorPlane: *Defs.VisPlane,
ceilingPlane: *Defs.VisPlane,
