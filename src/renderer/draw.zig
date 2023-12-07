const std = @import("std");
const Defs = @import("definitions.zig");

dc_colorMap: *Defs.LightTable,
dc_x: i16,
dc_yl: i16,
dc_yh: i16,

dc_iScale: Defs.Fixed,
dc_textureMid: Defs.Fixed,

/// first pixel in a column
dc_source: *u8,

ds_y: i16,
ds_x1: i16,
ds_x2: i16,

ds_colorMap: *Defs.LightTable,

ds_xFrac: Defs.Fixed,
ds_yFrac: Defs.Fixed,
ds_xStep: Defs.Fixed,
ds_yStep: Defs.Fixed,

// start of a 64*64 tile image
ds_source: *u8,

translationTables: *u8,
ds_translation: *u8,

/// The span blitting interface.
/// Hook in assembler or system specific BLT
///  here.
pub fn drawColumn() void {}
pub fn drawColumnLow() void {}

/// The Spectre/Invisibility effect.
pub fn drawFuzzColumn() void {}
pub fn drawFuzzColumnLow() void {}

/// Draw with color translation tables,
///  for player sprite rendering,
///  Green/Red/Blue/Indigo shirts.
pub fn drawTranslatedColumn() void {}
pub fn drawTranslatedColumnLow() void {}

pub fn videoErase(offset: u16, count: i16) void {
    _ = offset;
    _ = count;
}

/// Span blitting for rows, floor/ceiling.
/// No Sepctre effect needed.
pub fn drawSpan() void {}

/// Low resolution mode, 160x200?
pub fn drawSpanLow() void {}

pub fn initBuffer(width: i16, height: i16) void {
    _ = width;
    _ = height;
}

/// Initialize color translation tables,
///  for player rendering etc.
pub fn initTranslationTables() void {}
