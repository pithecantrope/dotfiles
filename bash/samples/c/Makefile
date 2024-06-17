TARGET_EXEC := bin
BUILD_DIR := ./build
SRC_DIR := ./src

CC := gcc
CFLAGS := -O0 -g -Werror -Wall -Wextra -std=c17
# CFLAGS := -O3 -std=c17
LDFLAGS :=
CPPFLAGS := -MMD -MP
VALGRIND_FLAGS := --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.PHONY: all run clean valgrind

all: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CC) $^ -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

run:
	@$(BUILD_DIR)/$(TARGET_EXEC) ${ARGS}

clean:
	rm -rf $(BUILD_DIR)

valgrind:
	valgrind $(VALGRIND_FLAGS) $(BUILD_DIR)/$(TARGET_EXEC) | less

-include $(DEPS)
