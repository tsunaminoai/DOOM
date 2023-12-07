///	Gamma correction LUT.
///	Functions to draw patches (by post) directly to screen.
///	Functions to blit a block to the screen.
const std = @import("std");
const DOOM = @import("libdoom.zig");

//
// VIDEO
//

pub const CENTERY = (DOOM.SCREENHEIGHT / 2);

// Screen 0 is the screen updated by I_Update screen.
// Screen 1 is an extra buffer.

pub var screens: [5]*u8 = undefined;
pub var dirtybox: [4]i16 = undefined;
pub var gammatable: [5][256]u8 = undefined;
pub var useGamma: i16 = 0;

/// Allocates buffer screens, call before R_Init.
pub fn init() void {}

pub fn copyRect(
    srcx: i16,
    srcy: i16,
    srcscrn: i16,
    width: i16,
    height: i16,
    destx: i16,
    desty: i16,
    destscrn: i16,
) void {
    _ = destscrn;
    _ = desty;
    _ = destx;
    _ = height;
    _ = width;
    _ = srcscrn;
    _ = srcy;
    _ = srcx;
}

pub fn drawPatch(
    x: i16,
    y: i16,
    screen: i16,
    patch: *DOOM.Patch,
) void {
    _ = patch;
    _ = screen;
    _ = y;
    _ = x;
}
pub fn drawPatchDirect(
    x: i16,
    y: i16,
    screen: i16,
    patch: *DOOM.Patch,
) void {
    _ = patch;
    _ = screen;
    _ = y;
    _ = x;
}

/// Draw a linear block of pixels into the view buffer.
pub fn drawBlock(
    x: i16,
    y: i16,
    screen: i16,
    width: i16,
    height: i16,
    src: *u8,
) void {
    _ = src;
    _ = height;
    _ = width;
    _ = screen;
    _ = y;
    _ = x;
}

// Reads a linear block of pixels into the view buffer.
pub fn getBlock(
    x: i16,
    y: i16,
    screen: i16,
    width: i16,
    height: i16,
    dest: *u8,
) void {
    _ = dest;
    _ = height;
    _ = width;
    _ = screen;
    _ = y;
    _ = x;
}

pub fn markRect(x: i16, y: i16, width: i16, height: i16) void {
    _ = height;
    _ = width;
    _ = y;
    _ = x;
}

/// Called by D_DoomMain,
/// determines the hardware configuration
/// and sets up the video mode
pub fn initGraphics() void {}

pub fn shutDownGraphics() void {}

// Takes full 8 bit values.
pub fn setPalette(pallet: *u8) void {
    _ = pallet;
}

pub fn updateNoBlit() void {}
pub fn fishishUpdate() void {}

// Wait for vertical retrace or pause a bit.
pub fn waitVBL(count: i16) void {
    _ = count;
}

pub fn readScreen(screen: *u8) void {
    _ = screen;
}
pub fn beginRead() void {}
pub fn endRead() void {}
