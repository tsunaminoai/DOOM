const std = @import("std");

pub const FractionalBits = 16;
pub const FractionalUnit = (1 << FractionalBits);

pub const Fixed = i32;

pub fn FixedMultiply(a: Fixed, b: Fixed) Fixed {
    return (a * b) >> FractionalBits;
}
pub fn FixedDivide(a: Fixed, b: Fixed) Fixed {
    if (@abs(a) >> 14 >= @abs(b))
        return if (a ^ b < 0) std.math.minInt(i32) else std.math.maxInt(i32);
    return FixedDivide2(a, b);
}
pub fn FixedDivide2(a: Fixed, b: Fixed) !Fixed {
    const c = @divExact(a, b) * FractionalUnit;
    if (c >= 2147483648.0 or c < -2147483648.0)
        return error.DivisionByZero;
    return c;
}
