const std = @import("std");
const config = @import("config");
const english = @import("lang/english.zig");
const Language = english;
const french = @import("lang/french.zig");
// const german = @import("lang/german.zig");

pub fn Strings(comptime language: anytype) @TypeOf(Language) {
    return switch (language) {
        .english => english,
        .french => french,
        // .german => german,
    };
}
