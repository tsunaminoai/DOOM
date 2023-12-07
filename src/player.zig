const std = @import("std");
const Mobj = @import("mobj.zig");
const Ticks = @import("ticks.zig");
const Defs = @import("definitions.zig");
const Fixed = @import("fixed.zig");
const Sprite = @import("../sprite.zig");

/// Player states.
pub const PlayerState = enum {
    // Playing or camping.
    live,
    // Dead on the ground, view follows killer.
    dead,
    // Ready to restart/respawn???
    reborn,
};

/// Player internal flags, for cheats and debug.
pub const Cheat = enum(u8) {

    // No clipping, walk through barriers.
    noClip = 1,

    // No damage, no health loss.
    godMode = 2,

    // Not really a cheat, just a debug aid.
    noMomentum = 4,
};

/// Extended player object info
pub const Player = struct {
    mo: ?*Mobj.Mobj,
    playerState: PlayerState,
    cmd: Ticks.TickCommand,

    // Determine POV,
    //  including viewpoint bobbing during movement.

    // Focal origin above r.z
    viewZ: Fixed.Fixed,

    // Base height above floor for viewz.
    viewHeight: Fixed.Fixed,

    // Bob/squat speed.
    deltaViewHeight: Fixed.Fixed,

    //bounded/scaled total momentum.
    bob: Fixed.Fixed,

    // This is only used between levels,
    // mo->health is used during levels.
    health: i16,
    armorPoints: i16,
    // Armor type is 0-2.
    armorType: i16,

    // Power ups. invinc and invis are tic counters.
    powers: [@intFromEnum(Defs.PowerType.NumPowers)]i16,
    cards: [@intFromEnum(Defs.Card.NumCards)]bool,
    backpack: bool,

    // Frags, kills of other players.
    frags: [Defs.MAXPLAYERS]i16,
    readyWeapon: Defs.WeaponType,

    // Is wp_nochange if not changing.
    pendingWeapon: Defs.WeaponType,

    weaponOwned: [@intFromEnum(Defs.WeaponType.NumWeapons)]bool,
    ammo: [@intFromEnum(Defs.AmmoType.NumAmmo)]i16,
    maxAmmo: [@intFromEnum(Defs.AmmoType.NumAmmo)]i16,

    // True if button down last tic.
    attckDown: i16,
    useDown: i16,

    // Bit flags, for cheats and debug.
    // See cheat_t, above.
    cheats: i16,

    // Refired shots are less accurate.
    refire: i16,

    // For intermission stats.
    killCount: i16,
    itemCount: i16,
    secretCount: i16,

    // Hint messages.
    message: *u8,

    // For screen flashing (red or bright).
    damageCount: i16,
    bonusCount: i16,

    // Who did damage (NULL for floors/ceilings).
    attacker: ?*Mobj.Mobj,

    // So gun flashes light up areas.
    extraLight: i16,

    // Current PLAYPAL, ???
    //  can be set to REDCOLORMAP for pain, etc.
    fixedColorMap: i16,

    // Player skin colorshift,
    //  0-3 for which color to draw player.
    colorMap: i16,

    // Overlay view sprites (gun, etc).
    sprites: [@intFromEnum(Sprite.SpriteNum.NumSprites)]Sprite.SpriteDef,

    // True if secret level has been done.
    didSecret: bool,
};

//
// INTERMISSION
//

// Structure passed e.g. to WI_Start(wb)
//
// typedef struct
// {
//     boolean	in;	// whether the player is in game

// Player stats, kills, collected items etc.
//     int		skills;
//     int		sitems;
//     int		ssecret;
//     int		stime;
//     int		frags[4];
//     int		score;	// current score on entry, modified on return

// } wbplayerstruct_t;

pub const WebPlayer = struct {
    inGame: bool,
    // Player stats, kills, collected items etc.
    kills: i16,
    items: i16,
    secret: i16,
    time: i16,
    frags: [4]i16,
    // current score on entry, modified on return
    score: i16,
};

pub const WebStart = struct {
    // episode # (0-2)
    episode: i16,

    // if true, splash the secret level
    didSecret: bool,

    // previous and next levels, origin 0
    last: i16,
    next: i16,

    maxkills: i16,
    maxitems: i16,
    maxsecret: i16,
    maxfrags: i16,

    // the par time
    parTime: i16,

    // index of this player in game
    playerNumber: i16,

    player: [Defs.MAXPLAYERS]WebPlayer,
};
