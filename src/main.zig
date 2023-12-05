const std = @import("std");
const DOOM = @import("DOOM");
const config = @import("config");
const Strings = @import("strings.zig").Strings(config.language);

//todo: "dstrings.h"
//todo: "sounds.h"
//todo: "z_zone.h"
//todo: "w_wad.h"
//todo: "s_sound.h"
//todo: "v_video.h"
//todo: "f_finale.h"
//todo: "f_wipe.h"
//todo: "m_argv.h"
//todo: "m_misc.h"
//todo: "m_menu.h"
//todo: "i_system.h"
//todo: "i_sound.h"
//todo: "i_video.h"
//todo: "g_game.h"
//todo: "hu_stuff.h"
//todo: "wi_stuff.h"
//todo: "st_stuff.h"
//todo: "am_map.h"
//todo: "p_setup.h"
//todo: "r_local.h"
//todo: "d_main.h"

pub const MAXWADFILES = 20;
pub var wadfiles: [MAXWADFILES]*u8 = undefined;

pub const BGCOLOR = 7;
pub const FGCOLOR = 8;

pub fn main() !void {
    std.debug.print("{s}", .{Strings.D_CDROM});
}
