/// MENUS
///   Menu widget stuff, episode selection and such.
const std = @import("std");
const Event = @import("event.zig");

/// Called by main loop,
/// saves config file and calls I_Quit when user exits.
/// Even when the menu is not displayed,
/// this can resize the view and change game parameters.
/// Does all the real work of the menu interaction.
pub fn responder(event: *Event.Event) bool {
    _ = event;
}

/// Called by main loop,
/// only used for menu (skull cursor) animation.
pub fn ticker() void {}

/// Called by main loop,
/// draws the menus directly into the screen buffer.
pub fn drawer() void {}

/// Called by D_DoomMain,
/// loads the config file.
pub fn init() void {}

/// Called by intro code to force menu up upon a keypress,
/// does nothing if menu is already up.
pub fn startControlPanel() void {}
