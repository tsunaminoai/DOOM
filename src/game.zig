/// duh
const std = @import("std");
const Defs = @import("definitions.zig");
const Event = @import("event.zig");

//
// GAME
//
pub fn deathMatchSpawnPlayer(playerNum: i16) void {
    _ = playerNum;
}

pub fn initNew(skill: Defs.Skill, episode: i16, map: i16) void {
    _ = map;
    _ = episode;
    _ = skill;
}

/// Can be called by the startup code or M_Responder.
/// A normal game starts at map 1,
/// but a warp test can start elsewhere
pub fn deferedInitNew(skill: Defs.Skill, episode: i16, map: i16) void {
    _ = map;
    _ = episode;
    _ = skill;
}
pub fn deferedPlayDemo(demo: *u8) void {
    _ = demo;
}

/// Can be called by the startup code or M_Responder,
/// calls P_SetupLevel or W_EnterWorld.
pub fn loadGame(name: *u8) void {
    _ = name;
}

pub fn doLoadGame() void {}

/// Called by M_Responder.
pub fn saveGame(slot: i16, description: *u8) void {
    _ = description;
    _ = slot;
}

/// Only called by startup code.
pub fn recordDemo(name: *u8) void {
    _ = name;
}
pub fn beginRecording() void {}

pub fn playDemo(name: *u8) void {
    _ = name;
}
pub fn timeDemo(name: *u8) void {
    _ = name;
}

pub fn checkDemoStatus() bool {}

pub fn exitLevel() void {}
pub fn secretExitLevel() void {}
pub fn worldDone() void {}
pub fn ticker() void {}
pub fn responder(event: *Event.Event) bool {
    _ = event;
}

pub fn screenShot() void {}
