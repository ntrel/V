// Copyright (c) 2019-2020 Alexander Medvednikov. All rights reserved.
// Use of this source code is governed by an MIT license
// that can be found in the LICENSE file.
module rand

import rand.util
import rand.wyrand

// Configuration struct for creating a new instance of the default RNG.
pub struct PRNGConfigStruct {
	seed []u32 = util.time_seed_array(2)
}

__global default_rng &wyrand.WyRandRNG
fn init() {
	default_rng = new_default({})
}

// new_default returns a new instance of the default RNG. If the seed is not provided, the current time will be used to seed the instance.
pub fn new_default(config PRNGConfigStruct) &wyrand.WyRandRNG {
	mut rng := &wyrand.WyRandRNG{}
	rng.seed(config.seed)
	return rng
}

// seed sets the given array of `u32` values as the seed for the `default_rng`.
pub fn seed(seed []u32) {
	default_rng.seed(seed)
}

// u32() returns a uniformly distributed u32 in _[0, 2<sup>32</sup>)_
pub fn u32() u32 {
	return default_rng.u32()
}

// u64() returns a uniformly distributed u64 in _[0, 2<sup>64</sup>)_
pub fn u64() u64 {
	return default_rng.u64()
}

// u32n(max) returns a uniformly distributed pseudorandom 32-bit signed positive u32 in _[0, max)_
pub fn u32n(max u32) u32 {
	return default_rng.u32n(max)
}

// u64n(max) returns a uniformly distributed pseudorandom 64-bit signed positive u64 in _[0, max)_
pub fn u64n(max u64) u64 {
	return default_rng.u64n(max)
}

// u32_in_range(min, max) returns a uniformly distributed pseudorandom 32-bit unsigned u32 in _[min, max)_
pub fn u32_in_range(min, max u32) u32 {
	return default_rng.u32_in_range(min, max)
}

// u64_in_range(min, max) returns a uniformly distributed pseudorandom 64-bit unsigned u64 in _[min, max)_
pub fn u64_in_range(min, max u64) u64 {
	return default_rng.u64_in_range(min, max)
}

// int() returns a uniformly distributed pseudorandom 32-bit signed (possibly negative) int
pub fn int() int {
	return default_rng.int()
}

// intn(max) returns a uniformly distributed pseudorandom 32-bit signed positive int in _[0, max)_
pub fn intn(max int) int {
	return default_rng.intn(max)
}

// int_in_range(min, max) returns a uniformly distributed pseudorandom
// 32-bit signed int in [min, max). Both min and max can be negative, but we must have _min < max_.
pub fn int_in_range(min, max int) int {
	return default_rng.int_in_range(min, max)
}

// int31() returns a uniformly distributed pseudorandom 31-bit signed positive int
pub fn int31() int {
	return default_rng.int31()
}

// i64() returns a uniformly distributed pseudorandom 64-bit signed (possibly negative) i64
pub fn i64() i64 {
	return default_rng.i64()
}

// i64n(max) returns a uniformly distributed pseudorandom 64-bit signed positive i64 in _[0, max)_
pub fn i64n(max i64) i64 {
	return default_rng.i64n(max)
}

// i64_in_range(min, max) returns a uniformly distributed pseudorandom 64-bit signed int in _[min, max)_
pub fn i64_in_range(min, max i64) i64 {
	return default_rng.i64_in_range(min, max)
}

// int63() returns a uniformly distributed pseudorandom 63-bit signed positive int
pub fn int63() i64 {
	return default_rng.int63()
}

// f32() returns a uniformly distributed 32-bit floating point in _[0, 1)_
pub fn f32() f32 {
	return default_rng.f32()
}

// f64() returns a uniformly distributed 64-bit floating point in _[0, 1)_
pub fn f64() f64 {
	return default_rng.f64()
}

// f32n() returns a uniformly distributed 32-bit floating point in _[0, max)_
pub fn f32n(max f32) f32 {
	return default_rng.f32n(max)
}

// f64n() returns a uniformly distributed 64-bit floating point in _[0, max)_
pub fn f64n(max f64) f64 {
	return default_rng.f64n(max)
}

// f32_in_range(min, max) returns a uniformly distributed 32-bit floating point in _[min, max)_
pub fn f32_in_range(min, max f32) f32 {
	return default_rng.f32_in_range(min, max)
}

// f64_in_range(min, max) returns a uniformly distributed 64-bit floating point in _[min, max)_
pub fn f64_in_range(min, max f64) f64 {
	return default_rng.f64_in_range(min, max)
}

const (
	chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
	hex_chars = '0123456789abcdef'
)

pub fn string(len int) string {
	mut buf := malloc(len)
	for i in 0..len {
		unsafe {
			buf[i] = chars[intn(chars.len)]
		}
	}
	return string(buf, len)
}

// rand.uuid_v4 generate a completely random UUID (v4)
// See https://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_(random)
pub fn uuid_v4() string {
	mut buf := malloc(37)
	for i in 0..36 {
		mut v := intn(16)
		if i == 19 {
			v = (v & 0x3) | 0x8
		}
		unsafe {
			buf[i] = hex_chars[v]
		}
	}
	unsafe {
		buf[8] = `-`
		buf[13] = `-`
		buf[14] = `4`
		buf[18] = `-`
		buf[23] = `-`
		buf[36] = 0
	}
	return string(buf, 36)
}
