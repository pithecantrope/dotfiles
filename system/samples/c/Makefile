TARGET_EXEC := bin
BUILD_DIR := ./build
SRC_DIR := ./src

CC := gcc
CFLAGS := -Og -g3 -fsanitize=address,undefined -Werror -Wall -Wextra -std=c17
# CFLAGS := -O3
LDFLAGS :=
LDFLAGS += -lasan -lubsan
CPPFLAGS := -MMD -MP

SRCS := $(wildcard $(SRC_DIR)/*.c)
OBJS := $(SRCS:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
DEPS := $(OBJS:.o=.d)

.PHONY: all run clean

all: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	@$(CC) $^ -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

run:
	@$(BUILD_DIR)/$(TARGET_EXEC) ${ARGS}

clean:
	@rm -rf $(BUILD_DIR)

-include $(DEPS)
