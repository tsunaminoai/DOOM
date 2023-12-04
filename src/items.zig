const std = @import("std");
const defs = @import("definitions.zig");

pub const WeaponInfo = struct {
    ammo: defs.AmmoType,
    upState: i32,
    downState: i32,
    readyState: i32,
    attackState: i32,
    flashState: i32,
};

pub var weaponinfo: [defs.NumWeapons]WeaponInfo = undefined;
