LDFLAGS :=

TARGET_EXEC := bin
BUILD_DIR := ./build
SRC_DIR := ./src
CC := gcc
CPPFLAGS := -MMD -MP

CFLAGS_RELEASE := -O3 -flto=auto
CFLAGS_PROFILE := -O3 -flto=auto -g
CFLAGS_DEBUG := -O0 -ggdb3
CFLAGS_DEV := -O0 -g3 -fsanitize=address,undefined -Werror -Wall -Wextra -Wfloat-equal -Wundef -Wshadow -Wlogical-op -Wswitch-default -Wswitch-enum -Wconversion -Winline -Wdouble-promotion -pedantic-errors -std=c17

ifeq ($(MAKECMDGOALS),release)
    CFLAGS := $(CFLAGS_RELEASE)
else ifeq ($(MAKECMDGOALS),profile)
    CFLAGS := $(CFLAGS_PROFILE)
else ifeq ($(MAKECMDGOALS),debug)
    CFLAGS := $(CFLAGS_DEBUG)
else
    CFLAGS := $(CFLAGS_DEV)
	LDFLAGS += -lasan -lubsan
endif

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.PHONY: all release profile debug run clean compile_commands

all: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	@$(CC) $^ -o $@ $(CFLAGS) $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

release: clean all

profile: clean all
	@perf record -g --freq=max -o $(BUILD_DIR)/perf.data $(BUILD_DIR)/$(TARGET_EXEC) $(ARGS)
	@perf script -i $(BUILD_DIR)/perf.data | stackcollapse-perf.pl | flamegraph.pl > $(BUILD_DIR)/flamegraph.svg
	@chromium $(BUILD_DIR)/flamegraph.svg
	
debug: clean all
	@gdbgui $(BUILD_DIR)/$(TARGET_EXEC)

run:
	@$(BUILD_DIR)/$(TARGET_EXEC) $(ARGS)

clean:
	@rm -rf $(BUILD_DIR)

compile_commands: clean
	@bear -- make

-include $(DEPS)
