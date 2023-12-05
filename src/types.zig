///	Simple basic typedefs, isolated here to make it easier
///	 separating modules.
const std = @import("std");

pub const MAXCHAR = std.math.maxInt(i8);
pub const MAXSHORT = std.math.maxInt(i16);

// Max pos 32-bit int.
pub const MAXINT = std.math.maxInt(i16);
pub const MAXLONG = std.math.maxInt(i32);
pub const MINCHAR = std.math.minInt(i8);
pub const MINSHORT = std.math.minInt(i16);

// Max negative 32-bit integer.
pub const MININT = std.math.minInt(i16);
pub const MINLONG = std.math.minInt(i32);
