/**
 * @file core.h
 * @brief Core utilities
 * @copyright Copyright (C) 2025 Egor Afanasin <afanasin.egor@gmail.com>
 * @license MIT
 * @requirements
 * - Compiler: GCC or Clang
 * - Platform: POSIX-like systems (Linux, macOS)
 * - C Standard: >= C99
 * @details
 * Types:
 * - Basic: `byte`, `i8`, `u8`, `i16`, `u16`, `i32`, `u32`, `i64`, `u64`, `f32`, `f64`, `isize`, `usize`
 * - Rich: `arena` (region-based allocator), `s8` (string) 
 * Macros:
 * - `assert(c)`: Debugger-oriented assertion that in release builds turns into an optimization hint
 * - `lable(name)`: Inline assembly label for debugging
 * - `countof(xs)`: Computes the size of a static array
 * - `container_of(ptr, type, member)`: Computes the address of the type containing a given member pointer
 * - `in_range(min, value, max)`: Checks if the value is within a range
 * - `PTR`: Non-NULL pointer `[static 1]`
 * - `INLINE`: `static inline`
 * - `TODO(args...)`: Marks incomplete code
 * Sanitizer flags:
 * - Address: `abort_on_error=true`,`check_initialization_order=true`, `strict_init_order=true`, `detect_stack_use_after_return=true`, `strict_string_checks=true`
 * - Undefined Behaviour: `abort_on_error=true`
 * Functions `u8` (ctype.h-style):
 * - is_digit, is_upper, is_lower, is_alpha, is_alnum, is_xdigit
 * - is_print, is_graph, is_blank, is_space, is_ascii, is_cntrl, is_punct
 * - to_upper, to_lower, to_ascii
 * Functions `arena`:
 * -
 * Functions `s8`:
 * - cmp(s1, s2), eq(s1, s2)
 * - starts_with(s, prefix), ends_with(s, suffix)
 * - find(s, sub), count(s, sub) 
 */

#ifndef CORE_H_
#define CORE_H_

#include <float.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

typedef char      byte;
typedef int8_t    i8;
typedef uint8_t   u8;
typedef int16_t   i16;
typedef uint16_t  u16;
typedef int32_t   i32;
typedef uint32_t  u32;
typedef int64_t   i64;
typedef uint64_t  u64;
typedef float     f32;
#define F32_MIN   FLT_MIN
#define F32_MAX   FLT_MAX
typedef double    f64;
#define F64_MIN   DBL_MIN
#define F64_MAX   DBL_MAX
typedef ptrdiff_t isize;
#define ISIZE_MIN PTRDIFF_MIN
#define ISIZE_MAX PTRDIFF_MAX
typedef size_t    usize;
#define USIZE_MAX SIZE_MAX

#define assert(c)   while (!(c)) __builtin_unreachable()
#define label(name) __asm__ volatile (#name ":\n\tnop")
#define countof(xs) (sizeof(xs) / sizeof(0[xs]))
#define container_of(ptr, type, member) ((type*)((byte*)(ptr) - offsetof(type, member)))
#define in_range(min, value, max) ((min) <= (value) && (value) <= (max))
#define PTR [static 1]
#define INLINE static inline

#define TODO(...)                       (CORE_TODO_1 (__VA_ARGS__, 0))
#define CORE_TODO_1(arg, ...) (void)arg, CORE_TODO_2 (__VA_ARGS__, 0)
#define CORE_TODO_2(arg, ...) (void)arg, CORE_TODO_3 (__VA_ARGS__, 0)
#define CORE_TODO_3(arg, ...) (void)arg, CORE_TODO_4 (__VA_ARGS__, 0)
#define CORE_TODO_4(arg, ...) (void)arg, CORE_TODO_5 (__VA_ARGS__, 0)
#define CORE_TODO_5(arg, ...) (void)arg, CORE_TODO_6 (__VA_ARGS__, 0)
#define CORE_TODO_6(arg, ...) (void)arg, CORE_TODO_7 (__VA_ARGS__, 0)
#define CORE_TODO_7(arg, ...) (void)arg, CORE_TODO_8 (__VA_ARGS__, 0)
#define CORE_TODO_8(arg, ...) (void)arg

#if __has_feature(address_sanitizer) || defined(__SANITIZE_ADDRESS__)
const char* __asan_default_options (void) { return "abort_on_error=true:check_initialization_order=true:strict_init_order=true:detect_stack_use_after_return=true:strict_string_checks=true"; }
#endif
#if __has_feature(undefined_behavior_sanitizer) || defined(__SANITIZE_UNDEFINED__)
const char* __ubsan_default_options(void) { return "abort_on_error=true"; }
#endif

// arena -------------------------------------------------------------------------------------------

// u8 ----------------------------------------------------------------------------------------------
#define U8SIZE 8
#define U8ALPHABET 256

INLINE bool u8is_digit (u8 c) { return in_range('0', c, '9'); }
INLINE bool u8is_upper (u8 c) { return in_range('A', c, 'Z'); }
INLINE bool u8is_lower (u8 c) { return in_range('a', c, 'z'); }
INLINE bool u8is_print (u8 c) { return in_range(' ', c, '~'); }
INLINE bool u8is_graph (u8 c) { return in_range(' ' + 1, c, '~'); }
INLINE bool u8is_alpha (u8 c) { return u8is_upper(c) || u8is_lower(c); }
INLINE bool u8is_alnum (u8 c) { return u8is_digit(c) || u8is_alpha(c); }
INLINE bool u8is_xdigit(u8 c) { return u8is_digit(c) || in_range('A', c, 'F') || in_range('a', c, 'f'); }
INLINE bool u8is_blank (u8 c) { return c == ' ' || c == '\t'; }
INLINE bool u8is_space (u8 c) { return u8is_blank(c) || c == '\r' || c == '\n' || c == '\f' || c == '\v'; }
INLINE bool u8is_ascii (u8 c) { return c <= 127; }
INLINE bool u8is_cntrl (u8 c) { return c < ' ' || c == 127; }
INLINE bool u8is_punct (u8 c) { return u8is_graph(c) && !u8is_alnum(c); }
INLINE u8   u8to_upper (u8 c) { return in_range('a', c, 'z') ? c - ('a' - 'A') : c; }
INLINE u8   u8to_lower (u8 c) { return in_range('A', c, 'Z') ? c + ('a' - 'A') : c; }
INLINE u8   u8to_ascii (u8 c) { return c & 127; }

// s8 ----------------------------------------------------------------------------------------------
typedef struct {
        u8* data;
        isize len;
} s8;
#define s8(s) (s8){.data = (u8*)s, .len = (isize)(sizeof(s) - 1)}
// #define s8(s) (s8){.data = (u8*)s, .len = (isize)(strlen(s))}
// TODO: _Generic (from FILE*, itself(copy))

INLINE i32
s8cmp(const s8 s1 PTR, const s8 s2 PTR) {
        if (s1->len != s2->len) { return s1->len < s2->len ? -1 : 1; }
        return memcmp(s1->data, s2->data, (size_t)s1->len);
}

INLINE bool
s8eq(const s8 s1 PTR, const s8 s2 PTR) {
        return s8cmp(s1, s2) == 0;
}

INLINE bool
s8starts_with(const s8 s PTR, const s8 prefix PTR) {
        return (s->len >= prefix->len) && memcmp(s->data, prefix->data, (size_t)prefix->len) == 0;
}

INLINE bool
s8ends_with(const s8 s PTR, const s8 suffix PTR) {
        return (s->len >= suffix->len) &&
               memcmp(s->data + (s->len - suffix->len), suffix->data, (size_t)suffix->len) == 0;
}

// Horspool algorithm
INLINE isize
s8find(const s8 s PTR, const s8 sub PTR) {
        if (sub->len == 0 || s->len < sub->len) { return -1; }
        isize last_occ[U8ALPHABET];
        memset(last_occ, -1, U8SIZE * U8ALPHABET);
        for (isize i = 0; i < sub->len - 1; ++i) { last_occ[sub->data[i]] = i; }

        for (isize i = 0; i <= s->len - sub->len;) {
                for (isize j = sub->len - 1; sub->data[j] == s->data[j + i];) {
                        if (--j == -1) { return i; }
                }
                i += sub->len - 1 - last_occ[s->data[i + sub->len - 1]];
        }
        return -1;
}

INLINE isize
s8count(const s8 s PTR, const s8 sub PTR) {
        if (sub->len == 0 || s->len < sub->len) { return 0; }
        isize count = 0;
        isize last_occ[U8ALPHABET];
        memset(last_occ, -1, U8SIZE * U8ALPHABET);
        for (isize i = 0; i < sub->len - 1; ++i) { last_occ[sub->data[i]] = i; }

        for (isize i = 0; i <= s->len - sub->len;) {
                for (isize j = sub->len - 1; sub->data[j] == s->data[j + i];) {
                        if (--j == -1) { ++count; break; }
                }
                i += sub->len - 1 - last_occ[s->data[i + sub->len - 1]];
        }
        return count;
}

#endif // CORE_H_
