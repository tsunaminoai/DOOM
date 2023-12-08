///  Refresh module, data I/O, caching, retrieval of graphics
///  by name.
///  Graphics.
// DOOM graphics for walls and sprites
// is stored in vertical runs of opaque pixels (posts).
// A column is composed of zero or more posts,
// a patch or sprite is composed of zero or more columns.
const std = @import("std");
const Defs = @import("definitions.zig");
const State = @import("state.zig");
const System = @import("../system.zig");
const WAD = @import("../wad.zig");
const Zone = @import("../zone.zig");
const Sky = @import("sky.zig");
const Renderer = @import("renderer.zig");
const Stat = @import("../stat.zig");
const Data = @import("data.zig");

const Self = @This();

/// Texture definition.
/// Each texture is composed of one or more patches,
/// with patches being lumps stored in the WAD.
/// The lumps are referenced by number, and patched
/// into the rectangular texture space using origin
/// and possibly other attributes.
pub const MapPatch = struct {
    originX: i8,
    originY: i8,
    patch: i8,
    stepDir: i8,
    colorMap: i8,
};

/// Texture definition.
/// A DOOM wall texture is a list of patches
/// which are to be combined in a predefined order.
pub const MapTexture = struct {
    name: []const u8,
    masked: bool,
    width: i8,
    height: i8,
    columnDirectory: **void, // OBSOLETE
    patchCount: i8,
    patches: [1]MapPatch,
};

/// A single patch from a texture definition,
///  basically a rectangular area within
///  the texture rectangle.
pub const TexturePatch = struct {
    // Block origin (allways UL),
    // which has allready accounted
    // for the internal origin of the patch.
    originX: i16,
    originY: i16,
    patch: i16,
};

// A maptexturedef_t describes a rectangular texture,
//  which is composed of one or more mappatch_t structures
//  that arrange graphic patches.
pub const Texture = struct {
    // Keep name for switch changing, etc.
    name: [8]u8,
    width: i8,
    height: i8,

    // All the patches[patchcount]
    //  are drawn back to front into the cached texture.
    patchcount: i8,
    patches: [1]TexturePatch,
};

alloc: std.mem.Allocator,

firstFlat: i16,
lastFlat: i16,
numFlats: i16,

firstPatch: i16,
lastPatch: i16,
numPatches: i16,

firstSpriteLump: i16,
lastSpriteLump: i16,
numSpriteLumps: i16,

numTextures: i16,
textures: **Texture,

textureWidthMask: *i16,
// needed for texture pegging
textureHeight: *Defs.Fixed.Fixed,
textureCompositeSize: *i16,
textureColumnLump: **i8,
textureColumnOffset: **u8,
textureComposite: **u8,

// for global animation
flatTranslation: *i16,
textureTranslation: *i16,

// needed for pre rendering
spriteWidth: *Defs.Fixed.Fixed,
spriteOffset: *Defs.Fixed.Fixed,
spriteTopOffset: *Defs.Fixed.Fixed,

colorMaps: *Defs.LightTable,

/// MAPTEXTURE_T CACHING
/// When a texture is first needed,
///  it counts the number of composite columns
///  required in the texture and allocates space
///  for a column directory and any new columns.
/// The directory will simply point inside other patches
///  if there is only one patch in a given column,
///  but any columns with multiple patches
///  will have new column_ts generated.
/// R_DrawColumnInCache
/// Clip and draw a column
///  from a patch into a cached post.
pub fn drawColumnInCache(
    patch: *Defs.Column,
    cache: *u8,
    originY: i16,
    cacheHeight: i16,
) void {
    var count: i16 = 0;
    var position: i16 = 0;
    var source: *u8 = undefined;
    var dest: *u8 = undefined;

    dest = &cache + 3;
    while (patch.topdelta != 0xFF) {
        source = &patch + 3;
        count = patch.length;
        position = originY + patch.topdelta;

        if (position < 0) {
            count += position;
            position = 0;
        }

        if (position + count > cacheHeight)
            count = cacheHeight - position;
        if (count > 0)
            @memcpy(&cache + position, source);
        patch = @as(*Defs.Column, @ptrCast(cache)) + patch.length + 4;
    }
}

/// R_GenerateComposite
/// Using the texture definition,
///  the composite texture is created from the patches,
///  and each column is cached.
pub fn generateComposite(self: *Self, textureNum: i16) !void {
    var block: *u8 = undefined;
    var texture: *Texture = undefined;
    var patch: *TexturePatch = undefined;
    var realPatch: *Defs.Patch = undefined;
    var x: i16 = 0;
    var x1: i16 = 0;
    var x2: i16 = 0;

    var patchColumn: *Defs.Column = undefined;
    var columnLump: *i8 = undefined;
    var columnOffset: *u8 = undefined;

    texture = Data.textures[textureNum];
    block = try self.alloc.alloc(u8, self.textureCompositeSize[textureNum]);
    self.textureComposite[textureNum] = block;

    columnLump = self.textureColumnOffset[textureNum];
    columnOffset = self.textureColumnOffset[textureNum];

    // Composite the columns together.
    patch = texture.patches;

    for (texture.patches) |p| {
        realPatch = WAD.cacheLumpNum(p.patch, Zone.PU_CACHE);
        x1 = p.originX;
        x2 = x1 + realPatch.width;

        x = if (x1 < 0) 0 else x1;
        x2 = if (x2 > texture.width) texture.width else x2;

        while (x < x2) : (x += 1) {
            // Column does not have multiple patches?
            if (columnLump[x] >= 0) continue;
            patchColumn = &realPatch + realPatch.columnOfs[x - x1];
            drawColumnInCache(
                patchColumn,
                &block + columnOffset[x],
                p.originY,
                texture.height,
            );
        }
    }
    // Now that the texture has been built in column cache,
    //  it is purgable from zone memory.
    //todo: implement the custom allocator I guess
    // Z_ChangeTag (block, Zone.PU_CACHE);
}

/// Retrieve column data for span blitting.
pub fn getColumn(tex: i16, col: i16) *u8 {
    _ = col;
    _ = tex;
}

/// I/O, setting up the stuff.
pub fn initData() void {}
pub fn preCacheLevel() void {}

/// Retrieval.
/// Floor/ceiling opaque texture tiles,
/// lookup by name. For animation?
pub fn flatNumForName(name: []const u8) i16 {
    _ = name;
}

// Called by P_Ticker for switches and animations,
// returns the texture number for the texture name.
pub fn textureNumForName(name: []const u8) i16 {
    _ = name;
}
pub fn checkTextureForName(name: []const u8) i16 {
    _ = name;
}
