const std = @import("std");
const config = @import("config");
const Strings = @import("strings.zig").Strings(config.language);
const DOOM = @import("DOOM");

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
    var event = DOOM.Event.Event{
        .eType = .mouse,
        .data1 = 1,
        .data2 = 1,
        .data3 = 1,
    };
    postEvent(&event);
}

// Called by IO functions when input is detected.
pub fn postEvent(event: *DOOM.Event.Event) void {
    _ = event;
}

pub fn pageTicker() void {}
pub fn pageDrawer() void {}
pub fn advanceDemo() void {}
pub fn startTitle() void {}

/// D-DoomLoop()
/// Not a globally visible function,
///  just included for source reference,
///  called by D_DoomMain, never exits.
/// Manages timing and IO,
///  calls all ?_Responder, ?_Ticker, and ?_Drawer,
///  calls I_GetTime, I_StartFrame, and I_StartTic
///
fn doomLoop() void {}

wadFiles: [MAXWADFILES]*u8,
devParm: bool, // started game with -devparm
noMonsters: bool, // checkparm of -nomonsters
respawnParm: bool, // checkparm of -respawn
fastParm: bool, // checkparm of -fast

drone: bool,
singleTicks: bool = false, // debug flag to cancel adaptiveness

soundVolume: i16,
SFXVolume: i16,
musicVolume: i16,

inHelpScreens: bool,

startSkill: DOOM.Defs.Skill,
startEpisode: i16,
startMap: i16,
autoStart: bool,

debugFile: *std.fs.File,

advanceDemo: bool,

wadfile: [1024]u8, // primary wad file
mapdir: [1024]u8, // directory of development maps
basedefault: [1024]u8, // default file

pub fn checkNetGame() void {}
pub fn processEvents() void {}
pub fn buildTickCommand(cmd: DOOM.Ticks.TickCommand) void {
    _ = cmd;
}
pub fn doAdvanceDemo() void {}
