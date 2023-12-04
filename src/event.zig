const std = @import("std");

pub const MAXEVENTS = 64;

pub const EventType = enum {
    keydown,
    keyup,
    mouse,
    joystick,
};

pub const Event = struct {
    eType: EventType,
    data1: u32, // keys / mouse/joystick buttons
    data2: u32, // mouse/joystick x move
    data3: u32, // mouse/joystick y move
};

pub const GameAction = enum {
    nothing,
    loadLevel,
    newGame,
    loadGame,
    saveGame,
    playDemo,
    completed,
    victory,
    worldDone,
    screenShot,
};

pub const ButtonCode = enum(u8) {
    attack = 1,
    use = 2,
    special = 128,
    specialMask = 3,
    change = 4,
    weaponMask = (8 + 16 + 32),
    weaponShift = 3,
    pause = 1,
    saveGame = 2,
    saveMask = (4 + 8 + 16),
    saveShift = 2,
};
