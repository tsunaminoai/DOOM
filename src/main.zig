const std = @import("std");
const config = @import("config");
const Strings = @import("strings.zig").Strings(config.language);
const Sound = @import("root").Sound;

//todo: "d_main.h"

// Returns the position of the given parameter
// in the arg list (0 if not found).
fn checkParm(check: []const u8) i16 {
    _ = check;
}

pub const MAXWADFILES = 20;
pub var wadfiles: [MAXWADFILES]*u8 = undefined;

pub const BGCOLOR = 7;
pub const FGCOLOR = 8;

pub fn main() !void {
    std.debug.print("{s}", .{Strings.QUITMSG});
}
