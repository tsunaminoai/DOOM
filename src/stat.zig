///   All the global variables that store the internal state.
///   Theoretically speaking, the internal state of the engine
///    should be found by looking at the variables collected
///    here, and every relevant module will have to include
///    this header file.
///   In practice, things are a bit messy.
const std = @import("std");
const DOOM = @import("libdoom.zig");

/// Command line parameters.
pub var noMonsters: bool = false; // checkparm of -nomonsters
pub var respawnParm: bool = false; // checkparm of -respawn
pub var fastParm: bool = false; // checkparm of -fast
pub var devParm: bool = false; // DEBUG: launched with -devparm

/// Game Mode - identify IWAD as shareware, retail etc.
// extern GameMode_t	gamemode;
// extern GameMission_t	gamemission;
pub var gameMode: DOOM.GameMode = undefined;
pub var gameMission: DOOM.GameMission = undefined;

/// Set if homebrew PWAD stuff has been added.
// extern  boolean	modifiedgame;
pub var modifiedGame: bool = false;

/// Language.
pub var language: DOOM.Language = undefined;

// Selected skill type, map etc.

/// Defaults for menu, methinks.
pub var startSkill: DOOM.Skill = undefined;
pub var startEpisode: i16 = 0;
pub var startMap: i16 = 0;

pub var autoStart: bool = false;

/// Selected by user.
// extern  skill_t         gameskill;
// extern  int		gameepisode;
// extern  int		gamemap;
pub var gameSkill: DOOM.Skill = undefined;
pub var gameEpisode: i16 = 0;
pub var gameMap: i16 = 0;

/// Nightmare mode flag, single player.
pub var respawnMonsters: bool = false;

/// Netgame? Only true if >1 player.
pub var netGame: bool = false;

/// Flag: true only if started as net deathmatch.
/// An enum might handle altdeath/cooperative better.
pub var isDeathMatch: bool = false;

/// Internal parameters for sound rendering.
/// These have been taken from the DOS version,
///  but are not (yet) supported with Linux
///  (e.g. no sound volume adjustment with menu.
/// These are not used, but should be (menu).
/// From m_menu.c:
///  Sound FX volume has default, 0 - 15
///  Music volume has default, 0 - 15
/// These are multiplied by 8.
pub var sndFXVolume: i16 = 0; // maximum volume for sound
pub var sndMusicVolume: i16 = 0; // maximum volume for music

/// Current music/sfx card - index useless
///  w/o a reference LUT in a sound module.
/// Ideally, this would use indices found
///  in: /usr/include/linux/soundcard.h
pub var sndFXDevice: i16 = 0;
pub var sndMusicDevice: i16 = 0;

/// Config file? Same disclaimer as above.
pub var sndDesiredFXDevice: i16 = 0;
pub var sndDesiredMusicDevice: i16 = 0;

// -------------------------
// Status flags for refresh.
//

/// Depending on view size - no status bar?
/// Note that there is no way to disable the
///  status bar explicitely.
pub var statusBarActive: bool = false;

pub var autoMapActive: bool = false; // In AutoMap mode?
pub var menuActive: bool = false; // Menu overlayed?
pub var paused: bool = false; // Game Pause?

pub var vieActive: bool = false;
pub var noDrawers: bool = false;
pub var noBlit: bool = false;

pub var viewWindowX: i16 = 0;
pub var viewWindowY: i16 = 0;
pub var viewHeight: i16 = 0;
pub var viewWidth: i16 = 0;
pub var scaledViewWidth: i16 = 0;

/// This one is related to the 3-screen display mode.
/// ANG90 = left side, ANG270 = right
pub var viewAngleOffset: i16 = 0;

/// Player taking events, and displaying.
pub var consolePlayer: i16 = 0;
pub var displayPlayer: i16 = 0;

/// Scores, rating.
/// Statistics on a given map, for intermission.
pub var totalKills: i16 = 0;
pub var totalItems: i16 = 0;
pub var totalSecret: i16 = 0;

/// Timer, for scores.
pub var levelStartTick: i16 = 0; // gametic at level start
pub var levelTime: i16 = 0; // tics in game play for par

/// DEMO playback/recording related stuff.
/// No demo, there is a human player in charge?
/// Disable save/end game?
pub var userGame: bool = false;
pub var demoPlayback: bool = false;
pub var demoRecording: bool = false;

// Quit after playing a demo from cmdline.
pub var singleDemo: bool = false;

pub var gameState: DOOM.GameState = undefined;

/// Internal parameters, fixed.
/// These are set by the engine, and not changed
///  according to user inputs. Partly load from
///  WAD, partly set at startup time.
pub var gameTick: i16 = 0;

/// Bookkeeping on players - state.
pub var players: [DOOM.MAXPLAYERS]DOOM.Player = undefined;

/// Alive? Disconnected?
pub var playerInGame: [DOOM.MAXPLAYERS]bool = undefined;

/// Player spawn spots for deathmatch.
pub const MAX_DM_STARTS = 10;
// extern  mapthing_t      deathmatchstarts[MAX_DM_STARTS];
// extern  mapthing_t*	deathmatch_p;
pub var deathMatchStarts: [MAX_DM_STARTS]DOOM.MapThing = undefined;
pub var deathMatch: ?*DOOM.MapThing = undefined;

/// Player spawn spots.
pub var playerStarts: [DOOM.MAXPLAYERS]DOOM.MapThing = undefined;

/// Intermission stats.
/// Parameters for world map / intermission.
pub var WebMatchInfo: DOOM.WebStart = undefined;

/// LUT of ammunition limits for each kind.
/// This doubles with BackPack powerup item.
pub var maxAmmo: [@intFromEnum(DOOM.AmmoType.NumAmmo)]i16 = undefined;

/// Internal parameters, used for engine.
/// File handling stuff.
pub var baseDefault: [1024]u8 = undefined;
pub var debugFile: *std.fs.File = undefined;

/// if true, load all graphics at level load
// extern  boolean         precache;
pub var preCache: bool = false;

/// wipegamestate can be set to -1
///  to force a wipe on the next draw
pub var wipeGameState: DOOM.GameState = undefined;

pub var mouseSensitivity: i16 = 0;
/// debug flag to cancel adaptiveness
pub var singleTicks: bool = false;

pub var bodyQueslot: i16 = 0;

/// Needed to store the number of the dummy sky flat.
/// Used for rendering,
///  as well as tracking projectiles etc.
pub var skyFlatNum: i16 = 0;

// Netgame stuff (buffers and pointers, i.e. indices).

// This is ???
// pub var doomCom: *DOOM.DoomCom = undefined;

// This points inside doomcom.
// pub var netBuffer: *DOOM.DoomData = undefined;

// extern  ticcmd_t	localcmds[BACKUPTICS];
// extern	int		rndindex;

// extern	int		maketic;
// extern  int             nettics[MAXNETNODES];

// extern  ticcmd_t        netcmds[MAXPLAYERS][BACKUPTICS];
// extern	int		ticdup;
