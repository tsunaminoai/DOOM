//	Main loop menu stuff.
///	Default Config File.
///	PCX Screenshots.
const std = @import("std");
const Video = @import("video.zig");
const HUD = @import("hud.zig");
const Defs = @import("definitions.zig");
const WAD = @import("wad.zig");

// static const char
// rcsid[] = "$Id: m_misc.c,v 1.6 1997/02/03 22:45:10 b1 Exp $";
pub const rcsid = "$Id: m_misc.c,v 1.6 1997/02/03 22:45:10 b1 Exp $";

// #include "doomdef.h"

// #include "z_zone.h"

// #include "m_swap.h"
// #include "m_argv.h"

// #include "w_wad.h"

// #include "i_system.h"
// #include "i_video.h"
// #include "v_video.h"

// #include "hu_stuff.h"

// extern patch_t*		hu_font[HU_FONTSIZE];
pub var hu_font: [HUD.FONTSIZE]Video.Patch = undefined;
///  Returns the final X coordinate
///  HU_Init must have been called to init the font
pub fn drawTest(x: i16, y: i16, direct: bool, string: []const u8) i16 {
    var ret: i16 = x;
    var w: i16 = 0;
    for (string) |c| {
        const char = std.ascii.toUpper(c) - HUD.FONTSTART;
        if (char < 0 or char > HUD.FONTSIZE) {
            ret += 4;
            continue;
        }
        w = HUD.hu_font[c].width;
        if (ret + w > Defs.SCREENWIDTH)
            break;
        if (direct)
            Video.drawPatchDirect(x, y, 0, hu_font[c])
        else
            Video.drawPatch(x, y, 0, hu_font[c]);
        ret += w;
    }
    return ret;
}

pub fn fatal(comptime msg: []const u8, args: anytype) noreturn {
    const stderr = std.io.getStdErr();
    const writer = stderr.writer();
    try writer.print(msg, args) catch std.debug.panic("Cant event write correctly", .{});
    std.os.exit(1);
}

pub fn errorPrint(comptime msg: []const u8, args: anytype) !void {
    const stderr = std.io.getStdErr();
    const writer = stderr.writer();
    try writer.print(msg, args);
}
///  M_WriteFile
pub fn writeFile(
    name: []const u8,
    source: []const u8,
) !void {
    var file = std.fs.cwd().openFile(
        name,
        .{ .mode = .write_only },
    ) catch |err| blk: {
        if (err == error.FileNotFound)
            break :blk try std.fs.cwd().createFile(name, .{})
        else
            return err;
    };
    defer file.close();
    errdefer file.close();

    return file.writeAll(source) catch errorPrint("Couldn't write to file {s}\n", .{name});
}

pub fn readFile(name: []const u8, alloc: std.mem.Allocator) ![]u8 {
    var file = try std.fs.cwd().openFile(
        name,
        .{ .mode = .read_only },
    );
    defer file.close();
    errdefer file.close();

    var meta = try file.metadata();
    return try file.readToEndAlloc(alloc, meta.size());
}

test "write/read file" {
    const content =
        \\Test
        \\TEXT
    ;
    try writeFile("tmp/text.txt", content);
    const t = try readFile("tmp/text.txt", std.testing.allocator);
    defer std.testing.allocator.free(t);

    try std.testing.expectEqualDeep(t[0..], @constCast(content[0..]));
}

const Default = struct {
    name: []u8,
    location: *i16,
    defaultvalue: i16,
    scantranslate: i16, // PC scan code hack
    untranslated: i16, // lousy hack
};

///  DEFAULTS
const SettingTag = enum(u16) {
    useMouse,
    useJoyStick,

    key_right,
    key_left,
    key_up,
    key_down,
    key_strafeleft,
    key_straferight,
    key_fire,
    key_use,
    key_strafe,
    key_speed,
    mousebfire,
    mousebstrafe,
    mousebforward,
    joybfire,
    joybstrafe,
    joybuse,
    joybspeed,
    viewwidth,
    viewheight,
    mouseSensitivity,
    showMessages,
    detailLevel,
    screenblocks,

    //  machine-independent sound params
    numChannels,

    //  UNIX hack, to be removed.
    //todo: remove
    // #ifdef SNDSERV
    // extern char*	sndserver_filename;
    // extern int	mb_used;
    // #endif

    // #ifdef LINUX
    // char*		mousetype;
    // char*		mousedev;
    // #endif
    SFXVolume,
    musicVolume,
    useGamma,
};
const Setting = struct {
    tag: SettingTag,
    name: []const u8,
    defaultValue: i16,
    currentValue: i16 = 0,
    pub fn init(tag: SettingTag, name: []const u8, defaultValue: i16) @This() {
        return .{
            .tag = tag,
            .name = name,
            .defaultValue = defaultValue,
            .currentValue = defaultValue,
        };
    }
};
chatMacros: []*u8,

const S = Setting;
pub var settings = [_]Setting{
    Setting.init(.mouseSensitivity, "mouse_sensitivity", 5),
    Setting.init(.SFXVolume, "sfx_volume", 8),
    Setting.init(.musicVolume, "music_volume", 5),
    Setting.init(.showMessages, "show_messages", 5),
    Setting.init(.key_right, "key_right", Defs.Keys.rightArrow.toInt()),
    Setting.init(.key_down, "key_down", Defs.Keys.downArrow.toInt()),
    Setting.init(.key_left, "key_left", Defs.Keys.leftArrow.toInt()),
    Setting.init(.key_up, "key_up", Defs.Keys.upArrow.toInt()),
    Setting.init(.key_strafeleft, "key_strafeleft", Defs.Keys.comma.toInt()),
    Setting.init(.key_straferight, "key_straferight", Defs.Keys.period.toInt()),
    Setting.init(.key_fire, "key_fire", Defs.Keys.rightControl.toInt()),
    Setting.init(.key_use, "key_straferight", Defs.Keys.space.toInt()),
    Setting.init(.key_speed, "key_speed", Defs.Keys.rightShift.toInt()),
    //  UNIX hack, to be removed.
    // #ifdef SNDSERV
    //     {"sndserver", (int *) &sndserver_filename, (int) "sndserver"},
    //     {"mb_used", &mb_used, 2},
    // #endif

    // #endif

    // #ifdef LINUX
    //     {"mousedev", (int*)&mousedev, (int)"/dev/ttyS0"},
    //     {"mousetype", (int*)&mousetype, (int)"microsoft"},
    // #endif
    Setting.init(.useMouse, "use_mouse", 1),
    Setting.init(.mousebfire, "mouseb_fire", 0),
    Setting.init(.mousebstrafe, "mouseb_strafe", 1),
    Setting.init(.mousebforward, "mouseb_forward", 2),
    Setting.init(.useJoyStick, "mouseb_forward", 0),
    Setting.init(.joybfire, "mouseb_forward", 0),
    Setting.init(.joybstrafe, "mouseb_forward", 1),
    Setting.init(.joybuse, "mouseb_forward", 3),
    Setting.init(.joybspeed, "mouseb_forward", 2),
    Setting.init(.screenblocks, "screenblocks", 9),
    Setting.init(.detailLevel, "detaillevel", 0),
    Setting.init(.numChannels, "snd_channels", 3),
    Setting.init(.useGamma, "usegamma", 0),
    //todo: come back and do chat macros
    //     {"chatmacro0", (int *) &chat_macros[0], (int) HUSTR_CHATMACRO0 },
    //     {"chatmacro1", (int *) &chat_macros[1], (int) HUSTR_CHATMACRO1 },
    //     {"chatmacro2", (int *) &chat_macros[2], (int) HUSTR_CHATMACRO2 },
    //     {"chatmacro3", (int *) &chat_macros[3], (int) HUSTR_CHATMACRO3 },
    //     {"chatmacro4", (int *) &chat_macros[4], (int) HUSTR_CHATMACRO4 },
    //     {"chatmacro5", (int *) &chat_macros[5], (int) HUSTR_CHATMACRO5 },
    //     {"chatmacro6", (int *) &chat_macros[6], (int) HUSTR_CHATMACRO6 },
    //     {"chatmacro7", (int *) &chat_macros[7], (int) HUSTR_CHATMACRO7 },
    //     {"chatmacro8", (int *) &chat_macros[8], (int) HUSTR_CHATMACRO8 },
    //     {"chatmacro9", (int *) &chat_macros[9], (int) HUSTR_CHATMACRO9 }
};

pub var numDefaults: i16 = undefined;
pub var defaultFile: []const u8 = undefined;

///  M_SaveDefaults
pub fn saveSettings(alloc: std.mem.Allocator) !void {
    const sets = try std.json.stringifyAlloc(alloc, settings, .{ .whitespace = .indent_2 });
    defer alloc.free(sets);

    try writeFile(defaultFile, sets);
}
test "save settings" {
    defaultFile = "tmp/defaults.json";
    try saveSettings(std.testing.allocator);
}

var scanToKey: [128]i16 = undefined;

///  M_LoadDefaults
pub fn loadSettings(alloc: std.mem.Allocator) !void {
    const sets = try readFile(defaultFile, alloc);
    defer alloc.free(sets);
    std.debug.print("{s}\n", .{sets});

    const config = try std.json.parseFromSlice(u8, alloc, sets, .{});
    defer config.deinit();
    std.debug.print("{any}\n", .{config});
}

//todo: fix loading settings
// test "load settings" {
//     defaultFile = "tmp/defaults.json";
//     try saveSettings(std.testing.allocator);
//     try loadSettings(std.testing.allocator);
//     try std.testing.expectEqual(settings[0].currentValue, 5);
// }

//
//  SCREEN SHOTS
//
const PCXHeader = struct {
    manufacturer: u8,
    version: u8,
    encoding: u8,
    bits_per_pixel: u8,
    xmin: u16,
    ymin: u16,
    xmax: u16,
    ymax: u16,
    hres: u16,
    vres: u16,
    palette: [48]u8,
    reserved: u8,
    color_planes: u8,
    bytes_per_line: u16,
    palette_type: u16,
    filler: [58]u8,
    data: [0]u8,
};

///  WritePCXfile
pub fn writePCXFile(
    filename: []const u8,
    data: []const u8,
    width: i16,
    height: i16,
    palette: []const u8,
    alloc: std.mem.Allocator,
) !void {
    var pcx = try alloc.alloc(PCXHeader, 1);
    defer alloc.free(pcx);

    pcx.manufacturer = 0x0a; // PCX id
    pcx.version = 5; // 256 color
    pcx.encoding = 1; // uncompressed
    pcx.bits_per_pixel = 8; // 256 color
    pcx.xmin = 0;
    pcx.ymin = 0;
    pcx.xmax = width - 1;
    pcx.ymax = height - 1;
    pcx.hres = width;
    pcx.vres = height;
    pcx.color_planes = 1; // chunky image
    pcx.bytes_per_line = width;
    pcx.palette_type = 2; // not a grey scale

    //  pack the image
    var pack = &pcx.data;
    for (data) |c| {
        if (c & 0xc0 != 0xc0) {
            pack.* = c;
            pack += 1;
        } else {
            pack.* = 0xc1;
            pack += 1;
            pack.* = c;
            pack += 1;
        }
    }

    //  write the palette
    pack.* = 0x0c; // palette ID byte
    pack += 1;
    for (palette) |c| {
        pack.* = c;
        pack += 1;
    }

    //  write output file
    const length = pack - &pcx.data;
    try writeFile(filename, &pcx, length);
}

pub fn readScreen(v: anytype) void {
    _ = v;
}

/// M_ScreenShot
pub fn screenShot(alloc: std.mem.Allocator) !void {
    const linear = try alloc.alloc(u8, Defs.SCREENWIDTH * Defs.SCREENHEIGHT);
    defer alloc.free(linear);

    readScreen(linear);

    var name = try alloc.alloc(u8, 12);
    defer alloc.free(name);

    name = "DOOM00.pcx";
    for (name[4..]) |c| {
        if (c == 0)
            break;
        if (c == '.')
            break;
        if (c == '9') {
            c = '0';
            name[3] += 1;
        } else {
            c += 1;
        }
    }

    writePCXFile(
        name,
        linear,
        Defs.SCREENWIDTH,
        Defs.SCREENHEIGHT,
        WAD.WAD.cacheLumpName("PLAYPAL"),
        std.testing.allocator,
    );
    //     players[consoleplayer].message = "screen shot";

}
