const std = @import("std");
const DOOM = @import("DOOM");
const config = @import("config");
const Strings = @import("strings.zig").Strings(config.language);
const Sounds = @import("sounds.zig");

//todo: "d_main.h"

pub const MAXWADFILES = 20;
pub var wadfiles: [MAXWADFILES]*u8 = undefined;

pub const BGCOLOR = 7;
pub const FGCOLOR = 8;

pub fn main() !void {
    std.debug.print("{s}", .{Strings.D_CDROM});
}
