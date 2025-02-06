#include <float.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

typedef int8_t    i8;
typedef uint8_t   u8;
typedef int16_t   i16;
typedef uint16_t  u16;
typedef int32_t   i32;
typedef uint32_t  u32;
typedef int64_t   i64;
typedef uint64_t  u64;
typedef ptrdiff_t isize;
#define ISIZE_MIN PTRDIFF_MIN
#define ISIZE_MAX PTRDIFF_MAX
typedef size_t    usize;
#define USIZE_MAX SIZE_MAX
typedef float     f32;
#define F32_MIN   FLT_MIN
#define F32_MIN   FLT_MIN
typedef double    f64;
#define F64_MAX   DBL_MAX
#define F64_MAX   DBL_MAX
typedef char      byte;
typedef struct {
        const u8* data;
        isize len;
} s8;
#define s8(s) (s8){.data = (const u8*)s, .len = sizeof(s) - 1}

#define assert(c)   while (!(c)) __builtin_unreachable()
#define label(name) __asm__ volatile (#name ":\n\tnop")
#define countof(xs) (sizeof(xs) / sizeof(0[xs]))
#define container_of(ptr, type, member) ((type*)((byte*)(ptr) - offsetof(type, member)))
#define in_range(min, value, max) ((min) <= (value) && (value) <= (max))
#define PTR [static 1]
#define INLINE static inline

// u8 ----------------------------------------------------------------------------------------------
INLINE bool
u8is_digit(u8 c) {
        return in_range('0', c, '9');
}

INLINE bool
u8is_upper(u8 c) {
        return in_range('A', c, 'Z');
}

INLINE bool
u8is_lower(u8 c) {
        return in_range('a', c, 'z');
}

INLINE bool
u8is_print(u8 c) {
        return in_range(' ', c, '~');
}

INLINE bool
u8is_graph(u8 c) {
        return in_range(' ' + 1, c, '~');
}

INLINE bool
u8is_alpha(u8 c) {
        return u8is_upper(c) || u8is_lower(c);
}

INLINE bool
u8is_alnum(u8 c) {
        return u8is_digit(c) || u8is_alpha(c);
}

INLINE bool
u8is_xdigit(u8 c) {
  return u8is_digit(c) || in_range('A', c, 'F') || in_range('a', c, 'f');
}

INLINE bool
u8is_blank(u8 c) {
        return c == ' ' || c == '\t';
}

INLINE bool
u8is_space(u8 c) {
        return u8is_blank(c) || c == '\r' || c == '\n' || c == '\f' || c == '\v';
}

INLINE bool
u8is_ascii(u8 c) {
        return c <= 127;
}

INLINE bool
u8is_cntrl(u8 c) {
        return c < ' ' || c == 127;
}

INLINE bool
u8is_punct(u8 c) {
        return u8is_graph(c) && !u8is_alnum(c);
}

INLINE u8
u8to_upper(u8 c) {
        return in_range('a', c, 'z') ? c - ('a' - 'A') : c;
}

INLINE u8
u8to_lower(u8 c) {
        return in_range('A', c, 'Z') ? c + ('a' - 'A') : c;
}

INLINE u8
u8to_ascii(u8 c) {
        return c & 127;
}

// s8 ----------------------------------------------------------------------------------------------
INLINE i32
s8cmp(const s8 s1 PTR, const s8 s2 PTR) {
        if (s1->len != s2->len) {
                return s1->len < s2->len ? -1 : 1;
        }
        return memcmp(s1->data, s2->data, (size_t)s1->len);
}

INLINE bool
s8eq(const s8 s1 PTR, const s8 s2 PTR) {
        return s8cmp(s1, s2) == 0;
}

INLINE i32
s8icmp(const s8 s1 PTR, const s8 s2 PTR) {
        if (s1->len != s2->len) {
                return s1->len < s2->len ? -1 : 1;
        }
        for (isize i = 0; i < s1->len; ++i) {
                u8 c1 = u8to_lower(s1->data[i]);
                u8 c2 = u8to_lower(s2->data[i]);
                if (c1 != c2) {
                        return c1 < c2 ? -1 : 1;
                }
        }
        return 0;
}

INLINE bool
s8ieq(const s8 s1 PTR, const s8 s2 PTR) {
        return s8icmp(s1, s2) == 0;
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

INLINE bool
s8istarts_with(const s8 s PTR, const s8 prefix PTR) {
        if (s->len < prefix->len) {
                return false;
        }
        for (isize i = 0; i < prefix->len; ++i) {
                if (u8to_lower(s->data[i]) != u8to_lower(prefix->data[i])) {
                        return false;
                }
        }
        return true;
}

INLINE bool
s8iends_with(const s8 s PTR, const s8 suffix PTR) {
        if (s->len < suffix->len) {
                return false;
        }
        for (isize i = 0; i < suffix->len; ++i) {
                if (u8to_lower(s->data[i + (s->len - suffix->len)]) !=
                    u8to_lower(suffix->data[i])) {
                        return false;
                }
        }
        return true;
}
