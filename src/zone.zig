/// Zone Memory Allocation, perhaps NeXT ObjectiveC inspired.
///	Remark: this was the only stuff that, according
///	to John Carmack, might have been useful for
///	Quake.
///
const std = @import("std");

/// ZONE MEMORY
/// PU - purge tags.
/// Tags < 100 are not overwritten until freed.
pub const STATIC = 1; // static entire execution time
pub const SOUND = 2; // static while playing
pub const MUSIC = 3; // static while playing
pub const DAVE = 4; // anything else Dave wants static
pub const LEVEL = 50; // static until level exited
pub const LEVELSPEC = 51; // a special thinker in a level

/// Tags >= 100 are purgable whenever needed.
pub const PU_PURGELEVEL = 100;
pub const PU_CACHE = 101;

pub fn init() void {}
pub fn malloc() void {}
pub fn free() void {}
pub fn freeTags() void {}
pub fn dumpHeap() void {}
pub fn fileDumpHeap() void {}
pub fn checkHeap() void {}
pub fn changeTag2() void {}
pub fn freeMemory() void {}

pub const MemoryBlock = struct {
    size: i16, // including the header and possibly tiny fragments
    user: ?*void, // NULL if a free block
    tag: i16, // purgelevel
    id: i16, // should be ZONEID
    next: ?*MemoryBlock,
    prev: ?*MemoryBlock,
};

/// This is used to get the local FILE:LINE info from CPP
/// prior to really call the function in question.
pub fn changeTag(p: anytype, t: anytype) void {
    _ = t;
    _ = p;
    //      if (( (memblock_t *)( (byte *)(p) - sizeof(memblock_t)))->id!=0x1d4a11) \
    //   I_Error("Z_CT at "__FILE__":%i",__LINE__); \
    //   Z_ChangeTag2(p,t); \
}
