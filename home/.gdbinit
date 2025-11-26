# set disassembly-flavor intel
# set width unlimited
# set height unlimited
# set pagination off
# set verbose off

set debuginfod enabled off
set confirm off
set disassembly-flavor intel
set history save on
set history filename ~/.gdb_history
# set history size 100000
# set history remove-duplicates 10
set host-charset UTF-8
set target-charset UTF-8
set target-wide-charset UTF-8

set print pretty on
set print object on
set print static-members on
set print vtbl on

set print demangle on
set demangle-style gnu-v3
set print sevenbit-strings off


# Essential .gdbinit configuration
set confirm off
set pagination off
set history save on
set history filename ~/.gdb_history

# Better display
set print pretty on
set print object on
set print static-members on
set print vtbl on
set print array on
set print array-indexes on

# Stop at first instruction
set startup-with-shell off

# Common shortcuts
define x
  examine/8x $arg0
end

define xx
  examine/16x $arg0
end

define d
  examine/8dw $arg0
end

define dd
  examine/16dw $arg0
end

# Enhanced backtrace
define bt
  backtrace
  frame
end

# Common hook
define hook-quit
  set confirm on
end

# TUI mode improvements
tui enable
set tui border-kind ascii
set tui tab-width 4

# Source code context
set listsize 20
set disassembly-flavor intel



break abort                # Catch abort() calls
break __assert_fail        # Catch failed assertions
break exit                 # Catch normal exits
break _exit                # Catch immediate exits
