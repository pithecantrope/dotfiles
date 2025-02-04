#include <float.h>
#include <stddef.h>
#include <stdint.h>

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

#define assert(c)   while (!(c)) __builtin_unreachable()
#define countof(xs) (sizeof(xs) / sizeof((xs)[0]))
#define lengthof(s) (countof(s) - 1)
