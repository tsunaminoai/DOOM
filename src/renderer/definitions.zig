///      Refresh/rendering module, shared data struct definitions.
const std = @import("std");
const Data = @import("../data.zig");
const Defs = @import("../definitions.zig");
const Fixed = @import("../fixed.zig");
const Think = @import("../think.zig");
const Mobj = @import("../mobj.zig");
usingnamespace @import("renderer.zig");

/// Silhouette, needed for clipping Segs (mainly)
/// and sprites representing things.
pub const SIL_NONE = 0;
pub const SIL_BOTTOM = 1;
pub const SIL_TOP = 2;
pub const SIL_BOTH = 3;
pub const MAXDRAWSEGS = 256;

/// INTERNAL MAP TYPES
///  used by play and refresh
/// Your plain vanilla vertex.
// Note: transformed values not buffered locally,
//  like some DOOM-alikes ("wt", "WebView") did.
pub const Vertex = struct {
    x: Fixed.Fixed,
    y: Fixed.Fixed,
};

// Forward of LineDefs, for Sectors.
// struct line_s;
pub const Line = struct {
    // Vertices, from v1 to v2.

    v1: Vertex,
    v2: Vertex,

    // Precalculated v2 - v1 for side checking.
    dx: Fixed.Fixed,
    dy: Fixed.Fixed,

    // Animation related.
    flags: i8,
    special: i8,
    tag: i8,

    // Visual appearance: SideDefs.
    //  sidenum[1] will be -1 if one sided
    sideNumber: [2]i8,

    // Neat. Another bounding box, for the extent
    //  of the LineDef.
    boundingBox: [4]Fixed.Fixed,

    // To aid move clipping.
    slopType: SlopeType,

    // Front and back sector.
    // Note: redundant? Can be retrieved from SideDefs.
    frontSector: ?*Sector,
    backSector: ?*Sector,

    // if == validcount, already checked
    validCount: i16,

    // thinker_t for reversable actions
    specialData: ?*Think.Thinker,
};

/// Each sector has a degenmobj_t in its center
///  for sound origin purposes.
/// I suppose this does not handle sound from
///  moving objects (doppler), because
///  position is prolly just buffered, not
///  updated.
pub const DegenMobj = struct {
    thinker: Think.Thinker, // not used for anything
    x: Fixed.Fixed,
    y: Fixed.Fixed,
    z: Fixed.Fixed,
};

// The SECTORS record, at runtime.
// Stores things/mobjs.
pub const Sector = struct {
    floorHeight: Fixed.Fixed,
    ceilingHeight: Fixed.Fixed,
    floorPic: i8,
    ceilingPic: i8,
    leightLevel: i8,
    special: i8,
    tag: i8,

    // 0 = untraversed, 1,2 = sndlines -1
    soundTraversed: i16,

    // thing that made a sound (or null)
    soundTarget: *Mobj.Mobj,

    // mapblock bounding box for height changes
    blockBox: [4]i16,

    // origin for any sounds played by the sector
    soundOrigin: ?*DegenMobj,

    // if == validcount, already checked
    validCount: i16,

    // list of mobjs in sector
    thingList: *Mobj.Mobj,

    // thinker_t for reversable actions
    specialData: *Think.Thinker,

    lineCount: i16,
    lines: ?**Line, // [linecount] size
};

/// The SideDef.
pub const Side = struct {
    // add this to the calculated texture column
    textureOffset: Fixed.Fixed,

    // add this to the calculated texture top
    rowOffset: Fixed.Fixed,

    // Texture indices.
    // We do not maintain names here.
    topTexture: i8,
    bottomTexture: i8,
    midTexture: i8,

    // Sector the SideDef is facing.
    sector: ?*Sector,
};

/// Move clipping aid for LineDefs.
pub const SlopeType = enum(u4) {
    HORIZONTAL,
    VERTICAL,
    POSITIVE,
    NEGATIVE,
};

/// A SubSector.
/// References a Sector.
/// Basically, this is a list of LineSegs,
///  indicating the visible walls that define
///  (all or some) sides of a convex BSP leaf.
pub const SubSector = struct {
    sector: *Sector,
    numLines: i8,
    firstLine: i8,
};

/// The LineSeg.
pub const Segment = struct {
    v1: *Vertex,
    v2: *Vertex,

    offSet: Fixed.Fixed,

    angle: Fixed.Angle,

    side: ?*Side,
    line: ?*Line,
    // Sector references.
    // Could be retrieved from linedef, too.
    // backsector is NULL for one sided lines
    frontSector: ?*Sector,
    backSector: ?*Sector,
};

/// BSP Node
pub const Node = struct {
    // Partition line.
    x: Fixed.Fixed,
    y: Fixed.Fixed,
    dx: Fixed.Fixed,
    dy: Fixed.Fixed,

    // Bounding box for each child.
    boundingBox: [2][4]Fixed.Fixed,

    // If NF_SUBSECTOR its a subsector.
    children: [2]u8,
};

/// posts are runs of non masked source pixels
pub const Post = struct {
    topdelta: u8, // -1 is the last post in a column
    length: u8, // length data bytes follows
};

// column_t is a list of 0 or more post_t, (byte)-1 terminated
pub const Column = Post;

/// PC direct to screen pointers
///B UNUSED - keep till detailshift in r_draw.c resolved
destView: ?*u8,
destScreen: ?*u8,

/// This could be wider for >8 bit display.
/// Indeed, true color support is posibble
///  precalculating 24bpp lightmap/colormap LUT.
///  from darkening PLAYPAL to all black.
/// Could even us emore than 32 levels.
pub const LightTable = u8;

pub const DrawSegment = struct {
    curLine: *Segment,
    x1: i16,
    x2: i16,

    scale1: Fixed.Fixed,
    scale2: Fixed.Fixed,
    scaleStep: Fixed.Fixed,

    // 0=none, 1=bottom, 2=top, 3=both
    sillhouette: i16,

    // do not clip sprites above this
    bSilHeight: Fixed.Fixed,

    // do not clip sprites below this
    tSilHeight: Fixed.Fixed,

    // Pointers to lists for sprite clipping,
    //  all three adjusted so [x1] is first value.
    spriteTopClip: *u8,
    spriteBottomClip: *u8,
    maskedTextureColumn: *u8,
};

/// Patches.
/// A patch holds one or more columns.
/// Patches are used for sprites and all masked pictures,
/// and we compose textures from the TEXTURE1/2 lists
/// of patches.
pub const Patch = struct {
    width: i8, // bounding box size
    height: i8,
    leftOffset: i8, // pixels to the left of origin
    topOffset: i8, // pixels below the origin
    columnOfs: [8]i16, // only [width] used
};

// A vissprite_t is a thing
//  that will be drawn during a refresh.
// I.e. a sprite object that is partly visible.
pub const VisSprite = struct {
    // Doubly linked list.
    prev: *VisSprite,
    next: *VisSprite,

    // for line side calculation
    gx: Fixed.Fixed,
    gy: Fixed.Fixed,

    // global bottom / top for silhouette clipping
    gz: Fixed.Fixed,
    gzt: Fixed.Fixed,

    // horizontal position of x1
    startFrac: Fixed.Fixed,

    scale: Fixed.Fixed,

    // negative if flipped
    xiScale: Fixed.Fixed,

    textureMid: Fixed.Fixed,

    patch: i16,

    // for color translation and shadow draw,
    //  maxbright frames as well
    colorMap: *LightTable,

    mobjFlags: i16,
};

/// Sprites are patches with a special naming convention
///  so they can be recognized by R_InitSprites.
/// The base name is NNNNFx or NNNNFxFx, with
///  x indicating the rotation, x = 0, 1-7.
/// The sprite and frame specified by a thing_t
///  is range checked at run time.
/// A sprite is a patch_t that is assumed to represent
///  a three dimensional object and may have multiple
///  rotations pre drawn.
/// Horizontal flipping is used to save space,
///  thus NNNNF2F5 defines a mirrored patch.
/// Some sprites will only have one picture used
/// for all views: NNNNF0
pub const SpriteFrame = struct {
    // If false use 0 for any position.
    // Note: as eight entries are available,
    //  we might as well insert the same name eight times.
    rotate: bool,

    // Lump to use for view angles 0-7.
    lump: [8]u8,

    // Flip bit (1 = flip) to use for view angles 0-7.
    flip: [8]u8,
};

/// A sprite definition:
///  a number of animation frames.
pub const Sprite = struct {
    numFrames: i16,
    spriteFrames: *SpriteFrame,
};

/// Now what is a visplane, anyway?
pub const VisPlane = struct {
    height: Fixed.Fixed,
    picNum: i16,
    lightLevel: i16,
    minX: i16,
    maxX: i16,

    // leave pads for [minx-1]/[maxx+1]
    pad1: u8,

    // Here lies the rub for all
    //  dynamic resize/change of resolution.
    top: [Defs.SCREENWIDTH]u8,
    pad2: u8,
    pad3: u8,
    // See above.
    bottom: [Defs.SCREENWIDTH]u8,
    pad4: u8,
};
