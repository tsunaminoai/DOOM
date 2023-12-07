///	Mission start screen wipe/melt, special effects.
const std = @import("std");
const DOOM = @import("libdoom.zig");

/// SCREEN WIPE PACKAGE
const WipeTag = enum(u3) {
    // simple gradual pixel change for 8-bit only
    colorXForm,

    // weird screen melt
    melt,

    NUMWIPES,
};

pub fn startScreen(
    x: i16,
    y: i16,
    width: i16,
    height: i16,
) i16 {
    _ = height;
    _ = width;
    _ = y;
    _ = x;
}
pub fn endScreen(
    x: i16,
    y: i16,
    width: i16,
    height: i16,
) i16 {
    _ = height;
    _ = width;
    _ = y;
    _ = x;
}
pub fn wipeScreen(
    wipe: WipeTag,
    x: i16,
    y: i16,
    width: i16,
    height: i16,
    ticks: i16,
) i16 {
    _ = ticks;
    _ = wipe;
    _ = height;
    _ = width;
    _ = y;
    _ = x;
}
