const std = @import("std");

const actionF_p1 = fn () void;
const actionF_v = fn (*void) void;
const actionF_p2 = fn (*void, *void) void;

pub const ActionF = union {
    acp1: actionF_p1,
    acv: actionF_v,
    acp2: actionF_p2,
};

pub const Think = ActionF;

pub const Thinker = struct {
    prev: *Thinker,
    next: *Thinker,
    function: Think,
};
