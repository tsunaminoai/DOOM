///	WAD I/O functions.
const std = @import("std");
const DOOM = @import("libdoom.zig");

// TYPES
pub const WADInfo = struct {
    // Should be "IWAD" or "PWAD".

    identification: [4]u8,
    numlumps: i16,
    infotableofs: i16,
};

pub const FileLump = struct {
    filepos: i16,
    size: i16,
    name: [8]u8,
};

// WADFILE I/O related stuff.
pub const LumpInfo = struct {
    name: [8]u8,
    handle: i16,
    position: i16,
    size: i16,
};

pub var lumpCache: **void = undefined;
pub var lumpInfo: LumpInfo = undefined;
pub var numLumps: i16 = 0;

pub fn initMultipleFiles(filenames: [][]const u8) void {
    _ = filenames;
}
pub fn reload() void {}

pub fn checkNumForName(name: []const u8) i16 {
    _ = name;
}
pub fn getNumForName(name: []const u8) i16 {
    _ = name;
}
pub fn lumpLength(lump: i16) i16 {
    _ = lump;
}
pub fn readLump(lump: i16, dest: *void) void {
    _ = dest;
    _ = lump;
}

pub fn cacheLumpNum(lump: i16, tag: i16) *void {
    _ = tag;
    _ = lump;
}
pub fn cacheLumpNam(name: []const u8, tag: i16) *void {
    _ = tag;
    _ = name;
}
