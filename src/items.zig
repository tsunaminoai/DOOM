///	Items: key cards, artifacts, weapon, ammunition.
const std = @import("std");
const Defs = @import("definitions.zig");

/// Weapon info: sprite frames, ammunition use.
pub const WeaponInfo = struct {
    ammo: Defs.AmmoType,
    upState: i32,
    downState: i32,
    readyState: i32,
    attackState: i32,
    flashState: i32,
};

pub var weaponInfo: [Defs.NumWeapons]WeaponInfo = undefined;
