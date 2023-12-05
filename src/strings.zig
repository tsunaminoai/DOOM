const std = @import("std");
const config = @import("config");
const english = @import("lang/english.zig").strings;
const Language = english;
const french = @import("lang/french.zig").strings;
const german = @import("lang/german.zig").strings;

pub fn Strings(comptime language: anytype) @TypeOf(Language) {
    return switch (language) {
        .english => english,
        .french => french,
        .german => german,
    };
}
