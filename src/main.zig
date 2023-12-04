const std = @import("std");
const defs = @import("definitions.zig");
const event = @import("event.zig");

pub const MAXWADFILES = 20;
pub var wadfiles: [MAXWADFILES]*u8 = undefined;

pub const BGCOLOR = 7;
pub const FGCOLOR = 8;

pub fn main() !void {}
