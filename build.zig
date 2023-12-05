const std = @import("std");

fn buildNativeC(b: *std.Build, target: anytype, optimize: anytype) void {
    const cflags = "-g -Wall -DNORMALUNIX -DLINUX";
    _ = cflags;
    //LDFLAGS=-L/usr/X11R6/lib
    // LIBS=-lXext -lX11 -lnsl -lm
    const native = b.addExecutable(.{
        .target = target,
        .optimize = optimize,
        .name = "doomC",
        .root_source_file = .{ .path = "linuxdoom-1.10/i_main.c" },
    });
    native.addCSourceFiles(.{ .files = Cfiles, .flags = &.{
        "-DNORMALUNIX",
        "-DLINUX",
    } });
    native.import_symbols = true;
    native.linkLibC();
    // native.linkSystemLibrary("X11");
    // native.linkSystemLibrary("values");
    native.addIncludePath(.{ .path = "./linuxdoom-1.10" });
    b.installArtifact(native);
}

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard optimization options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall. Here we do not
    // set a preferred release mode, allowing the user to decide how to optimize.
    const optimize = b.standardOptimizeOption(.{});

    // buildNativeC(b, target, optimize);

    const lib = b.addStaticLibrary(.{
        .name = "DOOM",
        // In this case the main source file is merely a path, however, in more
        // complicated build scripts, this could be a generated file.
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    // This declares intent for the library to be installed into the standard
    // location when the user invokes the "install" step (the default step when
    // running `zig build`).
    b.installArtifact(lib);

    const exe = b.addExecutable(.{
        .name = "DOOM",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.linkLibrary(lib);
    // This declares intent for the executable to be installed into the
    // standard location when the user invokes the "install" step (the default
    // step when running `zig build`).
    b.installArtifact(exe);

    // This *creates* a Run step in the build graph, to be executed when another
    // step is evaluated that depends on it. The next line below will establish
    // such a dependency.
    const run_cmd = b.addRunArtifact(exe);

    // By making the run step depend on the install step, it will be run from the
    // installation directory rather than directly from within the cache directory.
    // This is not necessary, however, if the application depends on other installed
    // files, this ensures they will be present and in the expected location.
    run_cmd.step.dependOn(b.getInstallStep());

    // This allows the user to pass arguments to the application in the build
    // command itself, like this: `zig build run -- arg1 arg2 etc`
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    // This creates a build step. It will be visible in the `zig build --help` menu,
    // and can be selected like this: `zig build run`
    // This will evaluate the `run` step rather than the default, which is "install".
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    // Creates a step for unit testing. This only builds the test executable
    // but does not run it.
    const lib_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/root.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const exe_unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    // Similar to creating the run step earlier, this exposes a `test` step to
    // the `zig build --help` menu, providing a way for the user to request
    // running the unit tests.
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);
}

const Cfiles = &[_][]const u8{
    "linuxdoom-1.10/am_map.c",
    "linuxdoom-1.10/d_items.c",
    "linuxdoom-1.10/d_main.c",
    "linuxdoom-1.10/d_net.c",
    "linuxdoom-1.10/doomdef.c",
    "linuxdoom-1.10/doomstat.c",
    "linuxdoom-1.10/dstrings.c",
    "linuxdoom-1.10/f_finale.c",
    "linuxdoom-1.10/f_wipe.c",
    "linuxdoom-1.10/g_game.c",
    "linuxdoom-1.10/hu_lib.c",
    "linuxdoom-1.10/hu_stuff.c",
    "linuxdoom-1.10/i_main.c",
    "linuxdoom-1.10/i_net.c",
    // "linuxdoom-1.10/i_sound.c",
    "linuxdoom-1.10/i_system.c",
    "linuxdoom-1.10/i_video.c",
    "linuxdoom-1.10/info.c",
    "linuxdoom-1.10/m_argv.c",
    "linuxdoom-1.10/m_bbox.c",
    "linuxdoom-1.10/m_cheat.c",
    "linuxdoom-1.10/m_fixed.c",
    "linuxdoom-1.10/m_menu.c",
    "linuxdoom-1.10/m_misc.c",
    "linuxdoom-1.10/m_random.c",
    "linuxdoom-1.10/m_swap.c",
    "linuxdoom-1.10/p_ceilng.c",
    "linuxdoom-1.10/p_doors.c",
    "linuxdoom-1.10/p_enemy.c",
    "linuxdoom-1.10/p_floor.c",
    "linuxdoom-1.10/p_inter.c",
    "linuxdoom-1.10/p_lights.c",
    "linuxdoom-1.10/p_map.c",
    "linuxdoom-1.10/p_maputl.c",
    "linuxdoom-1.10/p_mobj.c",
    "linuxdoom-1.10/p_plats.c",
    "linuxdoom-1.10/p_pspr.c",
    "linuxdoom-1.10/p_saveg.c",
    "linuxdoom-1.10/p_setup.c",
    "linuxdoom-1.10/p_sight.c",
    "linuxdoom-1.10/p_spec.c",
    "linuxdoom-1.10/p_switch.c",
    "linuxdoom-1.10/p_telept.c",
    "linuxdoom-1.10/p_tick.c",
    "linuxdoom-1.10/p_user.c",
    "linuxdoom-1.10/r_bsp.c",
    "linuxdoom-1.10/r_data.c",
    "linuxdoom-1.10/r_draw.c",
    "linuxdoom-1.10/r_main.c",
    "linuxdoom-1.10/r_plane.c",
    "linuxdoom-1.10/r_segs.c",
    "linuxdoom-1.10/r_sky.c",
    "linuxdoom-1.10/r_things.c",
    "linuxdoom-1.10/s_sound.c",
    "linuxdoom-1.10/sounds.c",
    "linuxdoom-1.10/st_lib.c",
    "linuxdoom-1.10/st_stuff.c",
    "linuxdoom-1.10/tables.c",
    "linuxdoom-1.10/v_video.c",
    "linuxdoom-1.10/w_wad.c",
    "linuxdoom-1.10/wi_stuff.c",
    "linuxdoom-1.10/z_zone.c",
};

const headers = &[_][]const u8{
    "linuxdoom-1.10/am_map.h",
    "linuxdoom-1.10/d_englsh.h",
    "linuxdoom-1.10/d_event.h",
    "linuxdoom-1.10/d_french.h",
    "linuxdoom-1.10/d_items.h",
    "linuxdoom-1.10/d_main.h",
    "linuxdoom-1.10/d_net.h",
    "linuxdoom-1.10/d_player.h",
    "linuxdoom-1.10/d_textur.h",
    "linuxdoom-1.10/d_think.h",
    "linuxdoom-1.10/d_ticcmd.h",
    "linuxdoom-1.10/doomdata.h",
    "linuxdoom-1.10/doomdef.h",
    "linuxdoom-1.10/doomstat.h",
    "linuxdoom-1.10/doomtype.h",
    "linuxdoom-1.10/dstrings.h",
    "linuxdoom-1.10/f_finale.h",
    "linuxdoom-1.10/f_wipe.h",
    "linuxdoom-1.10/g_game.h",
    "linuxdoom-1.10/hu_lib.h",
    "linuxdoom-1.10/hu_stuff.h",
    "linuxdoom-1.10/i_net.h",
    "linuxdoom-1.10/i_sound.h",
    "linuxdoom-1.10/i_system.h",
    "linuxdoom-1.10/i_video.h",
    "linuxdoom-1.10/info.h",
    "linuxdoom-1.10/m_argv.h",
    "linuxdoom-1.10/m_bbox.h",
    "linuxdoom-1.10/m_cheat.h",
    "linuxdoom-1.10/m_fixed.h",
    "linuxdoom-1.10/m_menu.h",
    "linuxdoom-1.10/m_misc.h",
    "linuxdoom-1.10/m_random.h",
    "linuxdoom-1.10/m_swap.h",
    "linuxdoom-1.10/p_inter.h",
    "linuxdoom-1.10/p_local.h",
    "linuxdoom-1.10/p_mobj.h",
    "linuxdoom-1.10/p_pspr.h",
    "linuxdoom-1.10/p_saveg.h",
    "linuxdoom-1.10/p_setup.h",
    "linuxdoom-1.10/p_spec.h",
    "linuxdoom-1.10/p_tick.h",
    "linuxdoom-1.10/r_bsp.h",
    "linuxdoom-1.10/r_data.h",
    "linuxdoom-1.10/r_defs.h",
    "linuxdoom-1.10/r_draw.h",
    "linuxdoom-1.10/r_local.h",
    "linuxdoom-1.10/r_main.h",
    "linuxdoom-1.10/r_plane.h",
    "linuxdoom-1.10/r_segs.h",
    "linuxdoom-1.10/r_sky.h",
    "linuxdoom-1.10/r_state.h",
    "linuxdoom-1.10/r_things.h",
    "linuxdoom-1.10/s_sound.h",
    "linuxdoom-1.10/sounds.h",
    "linuxdoom-1.10/st_lib.h",
    "linuxdoom-1.10/st_stuff.h",
    "linuxdoom-1.10/tables.h",
    "linuxdoom-1.10/v_video.h",
    "linuxdoom-1.10/w_wad.h",
    "linuxdoom-1.10/wi_stuff.h",
    "linuxdoom-1.10/z_zone.h",
};
