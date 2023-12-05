///	System specific interface stuff.
const std = @import("std");

/// The data sampled per tick (single player)
/// and transmitted to other peers (multiplayer).
/// Mainly movements/button commands per game tick,
/// plus a checksum for internal state consistency.
pub const TickCommand = struct {
    forwardMove: u8, // *2048 for move
    sideMove: u8, // *2048 for move
    angleTurn: i16,
    consistency: i16,
    chatChar: u8,
    buttons: u8,
};
