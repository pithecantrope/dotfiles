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
#define PTR [static 1]
#define INLINE static inline

INLINE i32
s8cmp(const s8 a PTR, const s8 b PTR) {
        if (a->len != b->len) {
                return a->len < b->len ? -1 : 1;
        }
        return memcmp(a->data, b->data, (size_t)a->len);
}

INLINE bool
s8equals(const s8 a PTR, const s8 b PTR) {
        return a->len == b->len && memcmp(a->data, b->data, (size_t)a->len) == 0;
}
