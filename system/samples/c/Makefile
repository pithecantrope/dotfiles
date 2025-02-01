PROJECT_NAME := bin
LDFLAGS :=
ARGS ?=

BUILD_DIR := build
SRC_DIR := src
CONFIG ?= DEV
CC := gcc
CPPFLAGS := -MMD -MP

TARGET_DIR := $(BUILD_DIR)/$(CONFIG)
TARGET := $(PROJECT_NAME)-$(CONFIG)

CFLAGS_RELEASE := -O3 -flto=auto -DNDEBUG
CFLAGS_DEBUG := -O0 -ggdb3
CFLAGS_PROFILE := -O2 -fno-inline -fno-omit-frame-pointer -g3
CFLAGS_DEV := -std=c17 -O0 -g3 -fsanitize=address,undefined -Werror -Wall -Wextra \
			  -pedantic-errors -Wlogical-op -Wconversion -Winline -Wundef -Wshadow \
			  -Wswitch-default -Wdouble-promotion -Wfloat-equal -Wswitch-enum  
CFLAGS := $(CFLAGS_$(CONFIG))

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(TARGET_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.SILENT:
.PHONY: all release _release debug _debug perf _perf cache _cache call _call mem _mem run clean compile

all: $(TARGET_DIR)/$(TARGET)

$(TARGET_DIR):
	mkdir -p $@

$(TARGET_DIR)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.c | $(TARGET_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

release:
	$(MAKE) -s CONFIG=RELEASE
	$(MAKE) -s CONFIG=RELEASE _release

_release:
	$(TARGET_DIR)/$(TARGET) $(ARGS)

debug:
	$(MAKE) -s CONFIG=DEBUG
	$(MAKE) -s CONFIG=DEBUG _debug

_debug:
	gdb -q -ex 'break main' --tui --args $(TARGET_DIR)/$(TARGET) $(ARGS)

perf:
	$(MAKE) -s CONFIG=PROFILE
	$(MAKE) -s CONFIG=PROFILE _perf

_perf:
	perf record -g --freq=max -o $(TARGET_DIR)/perf.data $(TARGET_DIR)/$(TARGET) $(ARGS)
	perf script -i $(TARGET_DIR)/perf.data | stackcollapse-perf.pl | flamegraph.pl > $(TARGET_DIR)/flamegraph.svg
	$(BROWSER) $(TARGET_DIR)/flamegraph.svg

cache:
	$(MAKE) -s CONFIG=PROFILE
	$(MAKE) -s CONFIG=PROFILE _cache

_cache:
	valgrind -q --tool=cachegrind --cachegrind-out-file=$(TARGET_DIR)/cache.out $(TARGET_DIR)/$(TARGET) $(ARGS)
	cg_annotate $(TARGET_DIR)/cache.out > $(TARGET_DIR)/cache.txt
	$(EDITOR) $(TARGET_DIR)/cache.txt

call:
	$(MAKE) -s CONFIG=PROFILE
	$(MAKE) -s CONFIG=PROFILE _call

_call:
	valgrind -q --tool=callgrind --callgrind-out-file=$(TARGET_DIR)/call.out $(TARGET_DIR)/$(TARGET) $(ARGS)
	callgrind_annotate $(TARGET_DIR)/call.out > $(TARGET_DIR)/call.txt
	$(EDITOR) $(TARGET_DIR)/call.txt

mem:
	$(MAKE) -s CONFIG=PROFILE
	$(MAKE) -s CONFIG=PROFILE _mem

_mem:
	valgrind -q --tool=massif --massif-out-file=$(TARGET_DIR)/mem.out $(TARGET_DIR)/$(TARGET) $(ARGS)
	ms_print $(TARGET_DIR)/mem.out > $(TARGET_DIR)/mem.txt
	$(EDITOR) $(TARGET_DIR)/mem.txt

run: $(TARGET_DIR)/$(TARGET)
	$^ $(ARGS)

clean:
	rm -rf $(BUILD_DIR)

compile: clean
	bear -- make

-include $(DEPS)
