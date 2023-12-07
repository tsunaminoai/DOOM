///	Created by the sound utility written by Dave Taylor.
///	Kept as a sample, DOOM2  sounds. Frozen.
const std = @import("std");
const DOOM = @import("libdoom.zig");

///  SoundFX struct.
pub const SFXInfo = struct {
    ///  up to 6-character name
    name: *u8,

    ///  Sfx singularity (only one at a time)
    singularity: i16,

    ///  Sfx priority
    priority: i16,

    ///  referenced sound if a link
    link: *SFXInfo,

    ///  pitch if a link
    pitch: i16,

    ///  volume if a link
    volume: i16,

    ///  sound data
    data: *void,

    ///  this is checked every second to see if sound
    ///  can be thrown out (if 0, then decrement, if -1,
    ///  then throw out, if > 0, then it is in use)
    usefuleness: i16,

    ///  lump number of sfx
    lumpNumber: i16,
};

///  MusicInfo struct.
pub const MusicInfo = struct {
    ///  up to 6-character name
    name: *u8,

    ///  lump number of music
    lumpNumber: i16,

    ///  music data
    data: *void,

    ///  music handle once registered
    handle: i16,
};

///  the complete set of sound effects
pub var SoundFX: []SFXInfo = undefined;

///  the complete set of music
pub var Music: []MusicInfo = undefined;

///  Identifiers for all music in game.
pub const MusicTag = enum { None, e1m1, e1m2, e1m3, e1m4, e1m5, e1m6, e1m7, e1m8, e1m9, e2m1, e2m2, e2m3, e2m4, e2m5, e2m6, e2m7, e2m8, e2m9, e3m1, e3m2, e3m3, e3m4, e3m5, e3m6, e3m7, e3m8, e3m9, inter, intro, bunny, victor, introa, runnin, stalks, countd, betwee, doom, the_da, shawn, ddtblu, in_cit, dead, stlks2, theda2, doom2, ddtbl2, runni2, dead2, stlks3, romero, shawn2, messag, count2, ddtbl3, ampie, theda3, adrian, messg2, romer2, tense, shawn3, openin, evil, ultima, read_m, dm2ttl, dm2int, NUMMUSIC };

///  Identifiers for all sfx in game.
pub const SoundFXTag = enum {
    None,
    pistol,
    shotgn,
    sgcock,
    dshtgn,
    dbopn,
    dbcls,
    dbload,
    plasma,
    bfg,
    sawup,
    sawidl,
    sawful,
    sawhit,
    rlaunc,
    rxplod,
    firsht,
    firxpl,
    pstart,
    pstop,
    doropn,
    dorcls,
    stnmov,
    swtchn,
    swtchx,
    plpain,
    dmpain,
    popain,
    vipain,
    mnpain,
    pepain,
    slop,
    itemup,
    wpnup,
    oof,
    telept,
    posit1,
    posit2,
    posit3,
    bgsit1,
    bgsit2,
    sgtsit,
    cacsit,
    brssit,
    cybsit,
    spisit,
    bspsit,
    kntsit,
    vilsit,
    mansit,
    pesit,
    sklatk,
    sgtatk,
    skepch,
    vilatk,
    claw,
    skeswg,
    pldeth,
    pdiehi,
    podth1,
    podth2,
    podth3,
    bgdth1,
    bgdth2,
    sgtdth,
    cacdth,
    skldth,
    brsdth,
    cybdth,
    spidth,
    bspdth,
    vildth,
    kntdth,
    pedth,
    skedth,
    posact,
    bgact,
    dmact,
    bspact,
    bspwlk,
    vilact,
    noway,
    barexp,
    punch,
    hoof,
    metal,
    chgun,
    tink,
    bdopn,
    bdcls,
    itmbk,
    flame,
    flamst,
    getpow,
    bospit,
    boscub,
    bossit,
    bospn,
    bosdth,
    manatk,
    mandth,
    sssit,
    ssdth,
    keenpn,
    keendt,
    skeact,
    skesit,
    skeatk,
    radio,
    NUMSFX,
};

/// Initializes sound stuff, including volume
/// Sets channels, SFX and music volume,
///  allocates channel buffer, sets S_sfx lookup.
pub fn init(sfxVolume: i16, musicVolume: i16) void {
    _ = musicVolume;
    _ = sfxVolume;
}

/// Per level startup code.
/// Kills playing sounds at start of level,
///  determines music if any, changes music.
pub fn start() void {}

/// Start sound for thing at <origin>
///  using <sound_id> from sounds.h
pub fn startSound(origin: *void, soundId: i16) void {
    _ = soundId;
    _ = origin;
}

/// Will start a sound at a given volume.
pub fn startSoundAtVolume(origin: *void, soundId: i16, volume: i16) void {
    _ = volume;
    _ = soundId;
    _ = origin;
}

/// Stop sound for thing at <origin>
pub fn stopSound(origin: *void) void {
    _ = origin;
}

/// Start music using <music_id> from sounds.h
pub fn startMusic(musicId: i16) void {
    _ = musicId;
}

/// Start music using <music_id> from sounds.h,
///  and set whether looping
pub fn changeMusic(musicId: i16, looping: i16) void {
    _ = looping;
    _ = musicId;
}

/// Stops the music fer sure.
pub fn stopMusic() void {}

/// Stop and resume music, during game PAUSE.
pub fn pauseMusic() void {}
pub fn resumeMusic() void {}

/// Updates music & sounds
pub fn updateSounds(listener: *void) void {
    _ = listener;
}
pub fn setMusicVolume(volume: i16) void {
    _ = volume;
}
pub fn setSFXVolume(volume: i16) void {
    _ = volume;
}

// UNIX hack, to be removed.
// #ifdef SNDSERV
// #include <stdio.h>
// extern FILE* sndserver;
// extern char* sndserver_filename;
// #endif

// Init at program start...
pub fn initSound() void {}

// ... update sound buffer and audio device at runtime...

pub fn updateSound() void {}
pub fn submitSound() void {}

// ... shut down and relase at program termination.
pub fn shutDownSound() void {}

///   SFX I/O
///  Initialize channels?
pub fn setChannels() void {}

///  Get raw data lump index for sound descriptor.
pub fn getSFXLumpNumber(sfxinfo: *SFXInfo) i16 {
    _ = sfxinfo;
}

///  Starts a sound in a particular sound channel.
pub fn startSoundChannel(
    id: i16,
    volume: i16,
    sep: i16,
    pitch: i16,
    priority: i16,
) i16 {
    _ = priority;
    _ = pitch;
    _ = sep;
    _ = volume;
    _ = id;
}

///  Stops a sound channel.
pub fn stopSoundChannel(handle: i16) void {
    _ = handle;
}

///  Called by S_*() functions
///   to see if a channel is still playing.
///  Returns 0 if no longer playing, 1 if playing.
pub fn isSoundPlaying(handle: i16) bool {
    _ = handle;
}

///  Updates the volume, separation,
///   and pitch of a sound channel.
pub fn updateSoundParams(
    handle: i16,
    volume: i16,
    sep: i16,
    pitch: i16,
) void {
    _ = pitch;
    _ = sep;
    _ = volume;
    _ = handle;
}

///   MUSIC I/O
pub fn initMusic() void {}
pub fn shutDownMusic() void {}

///  PAUSE game handling.
pub fn pauseSong(handle: i16) void {
    _ = handle;
}
pub fn resumeSong(handle: i16) void {
    _ = handle;
}

///  Registers a song handle to song data.
pub fn registerSong(data: *u8) i16 {
    _ = data;
}

///  Called by anything that wishes to start music.
///   plays a song, and when the song is done,
///   starts playing it again in an endless loop.
///  Horrible thing to do, considering.
pub fn playSong(handle: i16, looping: bool) void {
    _ = looping;
    _ = handle;
}

///  Stops a song over 3 seconds.
pub fn stopSong(handle: i16) void {
    _ = handle;
}

///  See above (register), then think backwards
pub fn unRegisterSong(handle: i16) void {
    _ = handle;
}
