///	Sky rendering.
const std = @import("std");

// SKY, store the number for name.
pub const SkyFlatName = "F_SKY1";

// The sky map is 256*128*4 maps.
pub const AngleToSkyShift = 22;

skyTexture: i16,
skyTextureMid: i16,

pub fn initSkyMap() void {}
