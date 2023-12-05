///	Items: key cards, artifacts, weapon, ammunition.
const std = @import("std");
const defs = @import("definitions.zig");

/// Weapon info: sprite frames, ammunition use.
pub const WeaponInfo = struct {
    ammo: defs.AmmoType,
    upState: i32,
    downState: i32,
    readyState: i32,
    attackState: i32,
    flashState: i32,
};

pub var weaponInfo: [defs.NumWeapons]WeaponInfo = undefined;
