const std = @import("std");
const english = @import("lang/english.zig");
const Language = english;
const french = @import("lang/french.zig");
const german = @import("lang/german.zig");

const string = []const u8;

pub fn LangStrings() type {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const t = std.ArrayList(u8).init(gpa.allocator());
    _ = t;

    for (@typeInfo(english).Struct.fields, 0..) |field, i| {
        _ = i;
        _ = field;
        // @compileLog(.{ i, field });
    }

    return u8;
}

// pub const strings = {
//     .key = "Key",
// };
test "wat" {
    const t = LangStrings();
    std.debug.print("T: {any}\n", .{t});
}

pub fn Strings(comptime language: anytype) @TypeOf(Language) {
    return switch (language) {
        .english => english,
        .french => french,
        .german => german,
    };
}
