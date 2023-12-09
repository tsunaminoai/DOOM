/// Zone Memory Allocation, perhaps NeXT ObjectiveC inspired.
///	Remark: this was the only stuff that, according
///	to John Carmack, might have been useful for
///	Quake.
///
//	Zone Memory Allocation. Neat.
const std = @import("std");
const System = @import("system.zig");
const Defs = @import("definitions.zig");

const int = i32;
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
pub const PURGELEVEL = 100;
pub const CACHE = 101;

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
    size: int, // including the header and possibly tiny fragments
    user: ?*void, // NULL if a free block
    tag: int, // purgelevel
    id: int, // should be ZONEID
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

/// ZONE MEMORY ALLOCATION
///
/// There is never any space between memblocks,
///  and there will never be two contiguous free memblocks.
/// The rover can be left pointing at a non-empty block.
///
/// It is of no value to free a cachable block,
///  because it will get overwritten automatically if needed.
const MemoryZone = struct {
    // total bytes malloced, including header
    size: int,

    // start / end cap for linked list
    blockList: MemoryBlock,
    rover: *MemoryBlock,

    const Self = @This();

    const ZONEID = 0x1d4a11;
    const MinFragment = 64;

    var mainZone: *MemoryZone = undefined;

    /// Z_ClearZone
    fn clearZone(self: *Self) void {
        var block: *MemoryBlock = undefined;

        // set the entire zone to one free block
        self.blockList.next = null;
        self.blockList.prev = null;
        block = @as(*MemoryBlock, @as(*u8, self + @sizeOf(MemoryZone)));

        self.blockList.user = *self;
        self.blockList.tag = STATIC;
        self.rover = block;

        block.prev = &self.blockList;
        block.next = &self.blockList;

        // NULL indicates a free block.
        block.user = null;

        block.size = self.size - @sizeOf(MemoryZone);
    }

    pub fn init() Self {
        var block: *MemoryBlock = undefined;
        var size: int = 0;

        mainZone = System.zoneBase(&size);
        mainZone.size = size;
        // set the entire zone to one free block

        mainZone.blockList.next = null;
        mainZone.blockList.prev = null;
        block = @as(*MemoryBlock, @as(*u8, mainZone + @sizeOf(MemoryZone)));

        mainZone.blockList.user = *mainZone;
        mainZone.blockList.tag = STATIC;
        mainZone.rover = block;

        block.prev = &mainZone.blockList;
        block.next = &mainZone.blockList;

        // NULL indicates a free block.
        block.user.?.* = 0;

        block.size = mainZone.size - @sizeOf(MemoryZone);
    }

    pub fn free(self: *Self, ptr: *void) void {
        _ = self;
        var block = @as(*MemoryBlock, @as(*u8, ptr) - @sizeOf(MemoryBlock));
        var other: *MemoryBlock = undefined;

        if (block.id != ZONEID)
            std.debug.print("Z_Free: freed a pointer without ZONEID\n", .{});

        if (block.user > **0x100) {
            // smaller values are not pointers
            // Note: OS-dependend?

            // clear the user's mark
            block.user = 0;
        }
        block.user = null;
        block.tag = 0;
        block.id = 0;

        other = block.prev;

        if (other.user == null) {
            // merge with previous free block
            other.size += block.size;
            other.next = block.next;
            other.next.?.prev = other;

            if (block == mainZone.rover)
                mainZone.rover = other;

            block = other;
        }

        other = block.next;
        if (other.user == null) {
            // merge the next free block onto the end
            block.size += other.size;
            block.next = other.next;
            block.next.?.prev = block;

            if (other == mainZone.rover)
                mainZone.rover = block;
        }
    }

    /// Z_Malloc
    /// You can pass a NULL user if the tag is < PU_PURGELEVEL.
    pub fn malloc(self: *Self, size: int, tag: int, user: ?*void) *void {
        var extra: int = 0;
        var start: *MemoryBlock = undefined;
        var rover: *MemoryBlock = undefined;
        var newBlock: *MemoryBlock = undefined;
        var base: *MemoryBlock = undefined;

        const newSize = (size + 3) & ~3;

        // scan through the block list,
        // looking for the first free block
        // of sufficient size,
        // throwing out any purgable blocks along the way.

        // account for size of block header
        newSize += @sizeOf(MemoryBlock);

        // if there is a free block behind the rover,
        //  back up over them
        base = mainZone.rover;

        if (base.prev.user == null)
            base = base.prev;

        rover = base;
        start = base.prev;

        // do
        //  while (base->user || base->size < size);
        blk: {
            if (rover == start)
                std.debug.print("Z_Malloc: failed on allocation of {} bytes", .{size});

            if (rover.user) {
                if (rover.tag < PURGELEVEL) {
                    // hit a block that can't be purged,
                    //  so move base past it
                    base = rover.next;
                    rover = rover.next;
                } else {
                    // free the rover block (adding the size to base)

                    // the rover can be the base block
                    base = base.prev;
                    self.free(rover.* + @sizeOf(MemoryBlock));
                }
            } else {
                rover = rover.next;
            }

            while (base.user or base.size < size) break :blk;
        }

        // found a block big enough
        extra = base.size - size;
        if (extra > MinFragment) {
            newBlock = @as(*MemoryBlock, @as(*u8, base + size));
            newBlock.* = MemoryBlock{
                .size = extra,
                .user = null,
                .tag = 0,
                .next = base.next,
            };
            newBlock.next.?.prev = newBlock;
            base.next = newBlock;
            base.size = size;
        }
        if (user) |u| {
            base.user = u;
            // *(void **)user = (void *) ((byte *)base + sizeof(memblock_t));

            user.?.* = @as(*void, @as(*u8, base + @sizeOf(MemoryBlock)));
        } else {
            if (tag >= PURGELEVEL)
                std.debug.print("Z_Malloc: an owner is required for purgable blocks\n", .{});

            // mark as in use, but unowned
            base.user = @as(*void, 2);
        }
        base.tag = tag;

        mainZone.rover = base.next;
        base.id = ZONEID;
        return @as(*void, @as(*u8, base + @sizeOf(MemoryBlock)));
    }

    pub fn freeTags(self: *Self, lowTag: int, highTag: int) void {
        var block: *MemoryBlock = undefined;
        var next: *MemoryBlock = undefined;

        block = mainZone.blockList.next;
        while (block != &mainZone.blockList) : (block = next) {
            // get link before freeing
            next = block.next;

            //free block?
            if (block.user == null)
                continue;

            if (block.tag >= lowTag and block.tag <= highTag)
                self.free(@as(*u8, block + @sizeOf(MemoryBlock)));
        }
    }

    /// Z_DumpHeap
    /// Note: TFileDumpHeap( stdout ) ?
    pub fn dumpHeap(self: *Self, lowTag: int, highTag: int) void {
        _ = self;
        var block: *MemoryBlock = undefined;
        std.debug.print("zone size: {}  location: {p}\n", .{ mainZone.size, mainZone });
        std.debug.print("tag range: {} to {}\n", .{ lowTag, highTag });

        block = mainZone.blockList.next;
        while (block.next) |b| {
            if (b.tag >= lowTag and b.tag <= highTag)
                std.debug.print(
                    "block:{p}    size:{i:7}    user:{p}    tag:{i:3}\n",
                    .{ b, b.size, b.user, b.tag },
                );
            block = b.next;
            if (block.next == &mainZone.blockList)
                break; // all blocks have been hit

        }
        if (@as(*u8, block + block.size) != @as(*u8, block.next))
            std.debug.print("ERROR: block size does not touch the next block\n", .{});

        if (block.next.?.prev != block)
            std.debug.print("ERROR: next block doesn't have proper back link\n", .{});

        if (block.user == null and block.next.?.user == null)
            std.debug.print("ERROR: two consecutive free blocks\n", .{});
    }
    // Z_FileDumpHeap
    //todo

    // Z_CheckHeap
    pub fn checkHeap(self: *Self) void {
        _ = self;
        var block = mainZone.blockList.next;
        while (block.next) : (block = block.next) {
            if (block.next == &mainZone.blockList)
                break; // all blocks have been hit

            if (@as(*u8, block + block.size) != @as(*u8, block.next))
                std.debug.print("ERROR: block size does not touch the next block\n", .{});

            if (block.next.?.prev != block)
                std.debug.print("ERROR: next block doesn't have proper back link\n", .{});

            if (block.user == null and block.next.?.user == null)
                std.debug.print("ERROR: two consecutive free blocks\n", .{});
        }
    }

    // Z_ChangeTag
    pub fn changeTag2(self: *Self, ptr: *void, tag: int) void {
        _ = self;
        var block: *MemoryBlock = @as(*MemoryBlock, @as(*u8, ptr - @sizeOf(MemoryBlock)));
        if (block.id != ZONEID)
            std.debug.print("Z_ChangeTag: freed a pointer without ZONEID\n", .{});

        if (tag >= PURGELEVEL and @as(u8, block.user) < 0x100)
            std.debug.print("Z_ChangeTag: an owner is required for purgable blocks\n", .{});

        block.tag = tag;
    }

    pub fn freeMemory() int {
        var block: *MemoryBlock = mainZone.blockList.next;
        var freeSize: int = 0;
        while (block != &mainZone.blockList) : (block = block.next) {
            if (block.user == null or block.tag >= PURGELEVEL)
                freeSize += block.size;
        }
        return freeSize;
    }
};

test "zone" {
    const z = MemoryZone.init();
    _ = z;
}
