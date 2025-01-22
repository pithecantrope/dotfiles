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
CFLAGS_PROFILE := -O3 -flto=auto -g
CFLAGS_DEV := -std=c17 -O0 -g3 -fsanitize=address,undefined -Werror -Wall -Wextra \
			  -pedantic-errors -Wlogical-op -Wconversion -Winline -Wundef -Wshadow \
			  -Wswitch-default -Wdouble-promotion -Wfloat-equal -Wswitch-enum  
CFLAGS := $(CFLAGS_$(CONFIG))

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(TARGET_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.SILENT:
.PHONY: all release debug profile run gdb _gdb perf _perf clean compile

all: $(TARGET_DIR)/$(TARGET)

$(TARGET_DIR):
	mkdir -p $@

$(TARGET_DIR)/$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(TARGET_DIR)/%.o: $(SRC_DIR)/%.c | $(TARGET_DIR)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

release:
	$(MAKE) -s CONFIG=RELEASE

debug:
	$(MAKE) -s CONFIG=DEBUG

profile:
	$(MAKE) -s CONFIG=PROFILE

run: $(TARGET_DIR)/$(TARGET)
	$^ $(ARGS)

gdb:
	$(MAKE) -s CONFIG=DEBUG _gdb

_gdb:
	gdb -q -ex 'break main' --tui --args $(TARGET_DIR)/$(TARGET) $(ARGS)

perf:
	$(MAKE) -s CONFIG=PROFILE _perf
 
_perf:
	perf record -g --freq=max -o $(TARGET_DIR)/perf.data $(TARGET_DIR)/$(TARGET) $(ARGS)
	perf script -i $(TARGET_DIR)/perf.data | stackcollapse-perf.pl | flamegraph.pl > $(TARGET_DIR)/flamegraph.svg
	$(BROWSER) $(TARGET_DIR)/flamegraph.svg
	
clean:
	rm -rf $(BUILD_DIR)

compile: clean
	bear -- make

-include $(DEPS)
