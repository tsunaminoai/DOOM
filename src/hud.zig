/// Head up display
const std = @import("std");
const DOOM = @import("libdoom.zig");

//
// Globally visible constants.
//
pub const FONTSTART = '!'; // the first font characters
pub const FONTEND = '_'; // the last font characters

// Calculate # of glyphs in font.
pub const FONTSIZE = FONTEND - FONTSTART + 1;

pub const BROADCAST = 5;

pub const MSGREFRESH = DOOM.Keys.enter;
pub const MSGX = 0;
pub const MSGY = 0;
pub const MSGWIDTH = 64; // in characters
pub const MSGHEIGHT = 1; // in lines

pub const MSGTIMEOUT = 4 * DOOM.TICRATE;

/// HEADS UP TEXT
pub fn init() void {}
pub fn start() void {}
pub fn responder(event: *DOOM.Event) bool {
    _ = event;
}
pub fn ticker() void {}
pub fn drawer() void {}
pub fn dequeueChatChar() u8 {}
pub fn erase() void {}
