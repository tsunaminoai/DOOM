///  Internally used data structures for virtually everything,
///   key definitions, lots of other stuff.

//
// Global parameters/defines.
//
/// DOOM version
pub const Version = enum(u8) {
    version = 110,
};

pub const NumWeapons = 16;

/// Game mode handling - identify IWAD version
///  to handle IWAD dependend animations etc.
pub const GameMode = enum {
    shareware, // DOOM 1 shareware, E1, M9
    registerd, // DOOM 1 registered, E3, M27
    commercial, // DOOM 2 retail, E1 M34
    // DOOM 2 german edition not handled
    retail, // DOOM 1 retail, E4, M36
    indetermined, // Well, no IWAD found.
};

/// Mission packs - might be useful for TC stuff?
pub const GameMission = enum {
    doom, // DOOM 1
    doom2, // DOOM 2
    pack_tnt, // TNT mission pack
    pack_plut, // Plutonia pack
    none,
};

/// Identify language to use, software localization.
pub const Language = enum {
    english,
    french,
    german,
    unkmown,
};

/// Do or do not use external soundserver.
/// The sndserver binary to be run separately
///  has been introduced by Dave Taylor.
/// The integrated sound support is experimental,
///  and unfinished. Default is synchronous.
/// Experimental asynchronous timer based is
///  handled by SNDINTR.
pub const SNDSERV = 0;
//pub const SNDINTR= 0;

/// For resize of screen, at start of game.
/// It will not work dynamically, see visplanes.
pub const BASE_WIDTH = 320;

/// It is educational but futile to change this
///  scaling e.g. to 2. Drawing of status bar,
///  menues etc. is tied to the scale implied
///  by the graphics.
pub const SCREEN_MUL = 1;
pub const INV_ASPECT_RATIO = 0.75;

/// Defines suck. C sucks.
/// C++ might sucks for OOP, but it sure is a better C.
/// So there.
pub const SCREENWIDTH = 320;
//SCREEN_MUL*BASE_WIDTH //320

pub const SCREENHEIGHT = 200;
//(int)(SCREEN_MUL*BASE_WIDTH*INV_ASPECT_RATIO) //200

/// The maximum number of players, multiplayer/networking.
pub const MAXPLAYERS = 4;
/// State updates, number of tics / second.
pub const TICRATE = 35;

/// The current state of the game: whether we are
/// playing, gazing at the intermission screen,
/// the game final animation, or a demo.
pub const GameState = enum {
    Level,
    Intermission,
    Finale,
    DemoScreen,
};

//
// Difficulty/skill settings/filters.
//
/// Skill flags.
pub const MTF_EASY = 1;
pub const MTF_NORMAL = 2;
pub const MTF_HARD = 4;

/// Deaf monsters/do not react to sound.
pub const MTF_AMBUSH = 8;

pub const Skill = enum {
    baby,
    easy,
    medium,
    hard,
    nightmare,
};

/// Key cards.
pub const Card = enum {
    blue,
    yellow,
    red,
    blueSkull,
    yellowSkull,
    redSkull,

    NumCards,
};

/// The defined weapons,
///  including a marker indicating
///  user has not changed weapon.
pub const WeaponType = enum {
    fist,
    pistol,
    shotgun,
    chaingun,
    missile,
    plasma,
    bfg,
    chainsaw,
    supershotgun,

    NumWeapons,

    noChange,
};

// Ammunition types defined.
pub const AmmoType = enum {
    clip, // Pistol / chaingun ammo.
    shell, // Shotgun / double barreled shotgun.
    cell, // Plasma rifle, BFG.
    missle, // Missile launcher.

    NumAmmo,

    noAmmo, // Unlimited for chainsaw / fist.
};

/// Power up artifacts.
pub const PowerType = enum {
    invulnerability,
    strength,
    invisibility,
    ironfeet,
    allmap,
    infrared,
    NumPowers,
};

/// Power up durations,
///  how many seconds till expiration,
///  assuming TICRATE is 35 ticks/second.
pub const PowerDuration = enum(u32) {
    invulnerability = 30 * TICRATE,
    invisibility = 60 * TICRATE,
    infrared = 120 * TICRATE,
    ironfeet = 60 * TICRATE,
};

/// DOOM keyboard definition.
/// This is the stuff configured by Setup.Exe.
/// Most key data are simple ascii (uppercased).
pub const Keys = enum(u8) {
    rightArrow = 0xAE,
    leftArrow = 0xAC,
    upArrow = 0xAD,
    downArrow = 0xAF,
    escape = 27,
    enter = 13,
    tab = 9,
    F1 = (0x80 + 0x3b),
    F2 = (0x80 + 0x3c),
    F3 = (0x80 + 0x3d),
    F4 = (0x80 + 0x3e),
    F5 = (0x80 + 0x3f),
    F6 = (0x80 + 0x40),
    F7 = (0x80 + 0x41),
    F8 = (0x80 + 0x42),
    F9 = (0x80 + 0x43),
    F10 = (0x80 + 0x44),
    F11 = (0x80 + 0x57),
    F12 = (0x80 + 0x58),
    backspace = 127,
    pause = 0xff,
    equals = 0x3d,
    minux = 0x2d,
    rightShift = (0x80 + 0x36),
    rightControl = (0x80 + 0x1d),
    rightAlt = (0x80 + 0x38),
    leftAlt = (0x80 + 0x39),
    comma = ',',
    period = '.',
    space = ' ',
    pub fn toInt(self: @This()) i16 {
        return @intFromEnum(self);
    }
};

// DOOM basic types (boolean),
//  and max/min values.
//#include "doomtype.h"

// Fixed point.
//#include "m_fixed.h"

// Endianess handling.
//#include "m_swap.h"

// Binary Angles, sine/cosine/atan lookups.
//#include "tables.h"

// Event type.
//#include "d_event.h"

// Game function, skills.
//#include "g_game.h"

// All external data is defined here.
//#include "doomdata.h"

// All important printed strings.
// Language selection (message strings).
//#include "dstrings.h"

// Player is a special actor.
//struct player_s;

//#include "d_items.h"
//#include "d_player.h"
//#include "p_mobj.h"
//#include "d_net.h"

// PLAY
//#include "p_tick.h"

// Header, generated by sound utility.
// The utility was written by Dave Taylor.
//#include "sounds.h"
