pub const Version = enum(u8) {
    version = 110,
};

pub const NumWeapons = 16;

pub const GameMode = enum {
    shareware,
    registerd,
    commercial,
    retail,
    indetermined,
};

pub const GameMission = enum {
    doom,
    doom2,
    pack_tnt,
    pack_plut,
    none,
};

pub const Language = enum {
    english,
    french,
    german,
    unkmown,
};

pub const SNDSERV = 0;
pub const BASE_WIDTH = 320;
pub const SCREEN_MUL = 1;
pub const INV_ASPECT_RATIO = 0.75;

pub const SCREENWIDTH = 320;
pub const SCREENHEIGHT = 200;

pub const MAXPLAYERs = 4;
pub const TICRATE = 35;

pub const GameState = enum {
    Level,
    Intermission,
    Finale,
    DemoScreen,
};

pub const MTF_EASY = 1;
pub const MTF_NORMAL = 2;
pub const MTF_HARD = 4;

pub const MTF_AMBUSH = 8;

pub const Skill = enum {
    baby,
    easy,
    medium,
    hard,
    nightmare,
};

pub const Card = enum {
    blue,
    yellow,
    red,
    blueSkull,
    yellowSkull,
    redSkull,

    NumCards,
};

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

pub const AmmoType = enum {
    clip,
    shell,
    cell,
    missle,

    NumAmmo,

    noAmmo,
};

pub const PowerType = enum {
    invulnerability,
    strength,
    invisibility,
    ironfeet,
    allmap,
    infrared,
    NumPowers,
};

pub const PowerDuration = enum(u32) {
    invulnerability = 30 * TICRATE,
    invisibility = 60 * TICRATE,
    infrared = 120 * TICRATE,
    ironfeet = 60 * TICRATE,
};

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
    leftAlt = (0x80 + 0x38),
};
