//	Main loop menu stuff.
///	Default Config File.
///	PCX Screenshots.
const std = @import("std");
const DOOM = @import("libdoom.zig");

// static const char
// rcsid[] = "$Id: m_misc.c,v 1.6 1997/02/03 22:45:10 b1 Exp $";
pub const rcsid = "$Id: m_misc.c,v 1.6 1997/02/03 22:45:10 b1 Exp $";

// #include "doomdef.h"

// #include "z_zone.h"

// #include "m_swap.h"
// #include "m_argv.h"

// #include "w_wad.h"

// #include "i_system.h"
// #include "i_video.h"
// #include "v_video.h"

// #include "hu_stuff.h"

// extern patch_t*		hu_font[HU_FONTSIZE];
pub var hu_font: [DOOM.HU_FONTSIZE]DOOM.Patch = undefined;
///  Returns the final X coordinate
///  HU_Init must have been called to init the font
pub fn drawTest(x: i16, y: i16, direct: bool, string: []const u8) i16 {
    var ret: i16 = x;
    var w: i16 = 0;
    for (string) |c| {
        const char = std.ascii.toUpper(c) - DOOM.HU_FONTSTART;
        if (char < 0 or char > DOOM.HU_FONTSIZE) {
            ret += 4;
            continue;
        }
        w = DOOM.hu_font[c].width;
        if (ret + w > DOOM.SCREENWIDTH)
            break;
        if (direct)
            DOOM.drawPatchDirect(x, y, 0, hu_font[c])
        else
            DOOM.drawPatch(x, y, 0, hu_font[c]);
        ret += w;
    }
    return ret;
}

pub fn fatal(comptime msg: []const u8, args: anytype) noreturn {
    const stderr = std.io.getStdErr();
    const writer = stderr.writer();
    try writer.print(msg, args) catch std.debug.panic("Cant event write correctly", .{});
    std.os.exit(1);
}

pub fn errorPrint(comptime msg: []const u8, args: anytype) !void {
    const stderr = std.io.getStdErr();
    const writer = stderr.writer();
    try writer.print(msg, args);
}
///  M_WriteFile
pub fn writeFile(
    name: []const u8,
    source: []const u8,
) !void {
    var file = std.fs.cwd().openFile(
        name,
        .{ .mode = .write_only },
    ) catch |err| blk: {
        if (err == error.FileNotFound)
            break :blk try std.fs.cwd().createFile(name, .{})
        else
            return err;
    };
    defer file.close();
    errdefer file.close();

    return file.writeAll(source) catch errorPrint("Couldn't write to file {s}\n", .{name});
}

pub fn readFile(name: []const u8, alloc: std.mem.Allocator) ![]u8 {
    var file = try std.fs.cwd().openFile(
        name,
        .{ .mode = .read_only },
    );
    defer file.close();
    errdefer file.close();

    var meta = try file.metadata();
    return try file.readToEndAlloc(alloc, meta.size());
}

test "write/read file" {
    const content =
        \\Test
        \\TEXT
    ;
    try writeFile("tmp/text.txt", content);
    const t = try readFile("tmp/text.txt", std.testing.allocator);
    defer std.testing.allocator.free(t);

    try std.testing.expectEqualDeep(t[0..], @constCast(content[0..]));
}

const Default = struct {
    name: []u8,
    location: *i16,
    defaultvalue: i16,
    scantranslate: i16, // PC scan code hack
    untranslated: i16, // lousy hack
};

///  DEFAULTS
const SettingTag = enum(u16) {
    useMouse,
    useJoyStick,

    key_right,
    key_left,
    key_up,
    key_down,
    key_strafeleft,
    key_straferight,
    key_fire,
    key_use,
    key_strafe,
    key_speed,
    mousebfire,
    mousebstrafe,
    mousebforward,
    joybfire,
    joybstrafe,
    joybuse,
    joybspeed,
    viewwidth,
    viewheight,
    mouseSensitivity,
    showMessages,
    detailLevel,
    screenblocks,

    //  machine-independent sound params
    numChannels,

    //  UNIX hack, to be removed.
    //todo: remove
    // #ifdef SNDSERV
    // extern char*	sndserver_filename;
    // extern int	mb_used;
    // #endif

    // #ifdef LINUX
    // char*		mousetype;
    // char*		mousedev;
    // #endif
    SFXVolume,
    musicVolume,
    useGamma,
};
const Setting = struct {
    tag: SettingTag,
    name: []const u8,
    defaultValue: i16,
    currentValue: i16 = 0,
    pub fn init(tag: SettingTag, name: []const u8, defaultValue: i16) @This() {
        return .{
            .tag = tag,
            .name = name,
            .defaultValue = defaultValue,
            .currentValue = defaultValue,
        };
    }
};
chatMacros: []*u8,

const S = Setting;
pub var settings = [_]Setting{
    Setting.init(.mouseSensitivity, "mouse_sensitivity", 5),
    Setting.init(.SFXVolume, "sfx_volume", 8),
    Setting.init(.musicVolume, "music_volume", 5),
    Setting.init(.showMessages, "show_messages", 5),
    Setting.init(.key_right, "key_right", DOOM.Keys.rightArrow.toInt()),
    Setting.init(.key_down, "key_down", DOOM.Keys.downArrow.toInt()),
    Setting.init(.key_left, "key_left", DOOM.Keys.leftArrow.toInt()),
    Setting.init(.key_up, "key_up", DOOM.Keys.upArrow.toInt()),
    Setting.init(.key_strafeleft, "key_strafeleft", DOOM.Keys.comma.toInt()),
    Setting.init(.key_straferight, "key_straferight", DOOM.Keys.period.toInt()),
    Setting.init(.key_fire, "key_fire", DOOM.Keys.rightControl.toInt()),
    Setting.init(.key_use, "key_straferight", DOOM.Keys.space.toInt()),
    Setting.init(.key_speed, "key_speed", DOOM.Keys.rightShift.toInt()),
    //  UNIX hack, to be removed.
    // #ifdef SNDSERV
    //     {"sndserver", (int *) &sndserver_filename, (int) "sndserver"},
    //     {"mb_used", &mb_used, 2},
    // #endif

    // #endif

    // #ifdef LINUX
    //     {"mousedev", (int*)&mousedev, (int)"/dev/ttyS0"},
    //     {"mousetype", (int*)&mousetype, (int)"microsoft"},
    // #endif
    Setting.init(.useMouse, "use_mouse", 1),
    Setting.init(.mousebfire, "mouseb_fire", 0),
    Setting.init(.mousebstrafe, "mouseb_strafe", 1),
    Setting.init(.mousebforward, "mouseb_forward", 2),
    Setting.init(.useJoyStick, "mouseb_forward", 0),
    Setting.init(.joybfire, "mouseb_forward", 0),
    Setting.init(.joybstrafe, "mouseb_forward", 1),
    Setting.init(.joybuse, "mouseb_forward", 3),
    Setting.init(.joybspeed, "mouseb_forward", 2),
    Setting.init(.screenblocks, "screenblocks", 9),
    Setting.init(.detailLevel, "detaillevel", 0),
    Setting.init(.numChannels, "snd_channels", 3),
    Setting.init(.useGamma, "usegamma", 0),
    //todo: come back and do chat macros
    //     {"chatmacro0", (int *) &chat_macros[0], (int) HUSTR_CHATMACRO0 },
    //     {"chatmacro1", (int *) &chat_macros[1], (int) HUSTR_CHATMACRO1 },
    //     {"chatmacro2", (int *) &chat_macros[2], (int) HUSTR_CHATMACRO2 },
    //     {"chatmacro3", (int *) &chat_macros[3], (int) HUSTR_CHATMACRO3 },
    //     {"chatmacro4", (int *) &chat_macros[4], (int) HUSTR_CHATMACRO4 },
    //     {"chatmacro5", (int *) &chat_macros[5], (int) HUSTR_CHATMACRO5 },
    //     {"chatmacro6", (int *) &chat_macros[6], (int) HUSTR_CHATMACRO6 },
    //     {"chatmacro7", (int *) &chat_macros[7], (int) HUSTR_CHATMACRO7 },
    //     {"chatmacro8", (int *) &chat_macros[8], (int) HUSTR_CHATMACRO8 },
    //     {"chatmacro9", (int *) &chat_macros[9], (int) HUSTR_CHATMACRO9 }
};

pub var numDefaults: i16 = undefined;
pub var defaultFile: []const u8 = undefined;

///  M_SaveDefaults
pub fn saveSettings(alloc: std.mem.Allocator) !void {
    const sets = try std.json.stringifyAlloc(alloc, settings, .{ .whitespace = .indent_2 });
    defer alloc.free(sets);

    try writeFile(defaultFile, sets);
}
test "save settings" {
    defaultFile = "tmp/defaults.json";
    try saveSettings(std.testing.allocator);
}
// void M_SaveDefaults (void)
// {
//     int		i;
//     int		v;
//     FILE*	f;

//     f = fopen (defaultfile, "w");
//     if (!f)
// 	return; // can't write the file, but don't complain

//     for (i=0 ; i<numdefaults ; i++)
//     {
// 	if (defaults[i].defaultvalue > -0xfff
// 	    && defaults[i].defaultvalue < 0xfff)
// 	{
// 	    v = *defaults[i].location;
// 	    fprintf (f,"%s\t\t%i\n",defaults[i].name,v);
// 	} else {
// 	    fprintf (f,"%s\t\t\"%s\"\n",defaults[i].name,
// 		     * (char **) (defaults[i].location));
// 	}
//     }

//     fclose (f);
// }

//
//  M_LoadDefaults
//
// extern byte	scantokey[128];

// void M_LoadDefaults (void)
// {
//     int		i;
//     int		len;
//     FILE*	f;
//     char	def[80];
//     char	strparm[100];
//     char*	newstring;
//     int		parm;
//     boolean	isstring;

//  set everything to base values
//     numdefaults = sizeof(defaults)/sizeof(defaults[0]);
//     for (i=0 ; i<numdefaults ; i++)
// 	*defaults[i].location = defaults[i].defaultvalue;

//  check for a custom default file
//     i = M_CheckParm ("-config");
//     if (i && i<myargc-1)
//     {
// 	defaultfile = myargv[i+1];
// 	printf ("	default file: %s\n",defaultfile);
//     }
//     else
// 	defaultfile = basedefault;

//  read the file in, overriding any set defaults
//     f = fopen (defaultfile, "r");
//     if (f)
//     {
// 	while (!feof(f))
// 	{
// 	    isstring = false;
// 	    if (fscanf (f, "%79s %[^\n]\n", def, strparm) == 2)
// 	    {
// 		if (strparm[0] == '"')
// 		{
//  get a string default
// 		    isstring = true;
// 		    len = strlen(strparm);
// 		    newstring = (char *) malloc(len);
// 		    strparm[len-1] = 0;
// 		    strcpy(newstring, strparm+1);
// 		}
// 		else if (strparm[0] == '0' && strparm[1] == 'x')
// 		    sscanf(strparm+2, "%x", &parm);
// 		else
// 		    sscanf(strparm, "%i", &parm);
// 		for (i=0 ; i<numdefaults ; i++)
// 		    if (!strcmp(def, defaults[i].name))
// 		    {
// 			if (!isstring)
// 			    *defaults[i].location = parm;
// 			else
// 			    *defaults[i].location =
// 				(int) newstring;
// 			break;
// 		    }
// 	    }
// 	}

// 	fclose (f);
//     }
// }

//
//  SCREEN SHOTS
//

// typedef struct
// {
//     char		manufacturer;
//     char		version;
//     char		encoding;
//     char		bits_per_pixel;

//     unsigned short	xmin;
//     unsigned short	ymin;
//     unsigned short	xmax;
//     unsigned short	ymax;

//     unsigned short	hres;
//     unsigned short	vres;

//     unsigned char	palette[48];

//     char		reserved;
//     char		color_planes;
//     unsigned short	bytes_per_line;
//     unsigned short	palette_type;

//     char		filler[58];
//     unsigned char	data;		// unbounded
// } pcx_t;

//
//  WritePCXfile
//
// void
// WritePCXfile
// ( char*		filename,
//   byte*		data,
//   int		width,
//   int		height,
//   byte*		palette )
// {
//     int		i;
//     int		length;
//     pcx_t*	pcx;
//     byte*	pack;

//     pcx = Z_Malloc (width*height*2+1000, PU_STATIC, NULL);

//     pcx->manufacturer = 0x0a;		// PCX id
//     pcx->version = 5;			// 256 color
//     pcx->encoding = 1;			// uncompressed
//     pcx->bits_per_pixel = 8;		// 256 color
//     pcx->xmin = 0;
//     pcx->ymin = 0;
//     pcx->xmax = SHORT(width-1);
//     pcx->ymax = SHORT(height-1);
//     pcx->hres = SHORT(width);
//     pcx->vres = SHORT(height);
//     memset (pcx->palette,0,sizeof(pcx->palette));
//     pcx->color_planes = 1;		// chunky image
//     pcx->bytes_per_line = SHORT(width);
//     pcx->palette_type = SHORT(2);	// not a grey scale
//     memset (pcx->filler,0,sizeof(pcx->filler));

//  pack the image
//     pack = &pcx->data;

//     for (i=0 ; i<width*height ; i++)
//     {
// 	if ( (*data & 0xc0) != 0xc0)
// 	    *pack++ = *data++;
// 	else
// 	{
// 	    *pack++ = 0xc1;
// 	    *pack++ = *data++;
// 	}
//     }

//  write the palette
//     *pack++ = 0x0c;	// palette ID byte
//     for (i=0 ; i<768 ; i++)
// 	*pack++ = *palette++;

//  write output file
//     length = pack - (byte *)pcx;
//     M_WriteFile (filename, pcx, length);

//     Z_Free (pcx);
// }

//
//  M_ScreenShot
//
// void M_ScreenShot (void)
// {
//     int		i;
//     byte*	linear;
//     char	lbmname[12];

//  munge planar buffer to linear
//     linear = screens[2];
//     I_ReadScreen (linear);

//  find a file name to save it to
//     strcpy(lbmname,"DOOM00.pcx");

//     for (i=0 ; i<=99 ; i++)
//     {
// 	lbmname[4] = i/10 + '0';
// 	lbmname[5] = i%10 + '0';
// 	if (access(lbmname,0) == -1)
// 	    break;	// file doesn't exist
//     }
//     if (i==100)
// 	I_Error ("M_ScreenShot: Couldn't create a PCX");

//  save the pcx file
//     WritePCXfile (lbmname, linear,
// 		  SCREENWIDTH, SCREENHEIGHT,
// 		  W_CacheLumpName ("PLAYPAL",PU_CACHE));

//     players[consoleplayer].message = "screen shot";
// }
