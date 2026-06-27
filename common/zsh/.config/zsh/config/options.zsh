# ==============================================================================
# Zsh Options
# ==============================================================================

# Basic settings
setopt NO_BEEP                 # No beeps
setopt AUTO_CD                 # Auto cd to directory
setopt AUTO_PUSHD              # Auto push old directory to stack
setopt PUSHD_IGNORE_DUPS       # Don't push duplicates to stack
setopt PUSHD_SILENT            # Don't print stack after pushd/popd
setopt PUSHD_TO_HOME           # Pushd ~ = pushd $HOME
setopt CDABLE_VARS             # Change directory to variable content
setopt ALWAYS_TO_END           # Move cursor to end after completion
setopt AUTO_MENU               # Show completion menu on successive tabs
setopt COMPLETE_IN_WORD        # Complete from both ends
setopt PATH_DIRS               # Path search for executables
setopt GLOB_DOTS               # Include dotfiles in globbing

# History settings
setopt HIST_VERIFY             # Verify history commands before execution
setopt HIST_IGNORE_SPACE       # Ignore commands starting with space
setopt HIST_IGNORE_DUPS        # Ignore duplicate commands
setopt HIST_IGNORE_ALL_DUPS    # Delete old duplicate entries
setopt HIST_FIND_NO_DUPS       # Don't find duplicates when searching
setopt HIST_SAVE_NO_DUPS       # Don't save duplicate entries
setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks
setopt APPEND_HISTORY          # Append to history file
setopt INC_APPEND_HISTORY      # Write to history file immediately
setopt SHARE_HISTORY           # Share history between sessions

# Globbing
setopt EXTENDED_GLOB           # Extended globbing
setopt NOMATCH                 # Report pattern matching errors
setopt GLOB_STAR_SHORT         # Treat ** as * and */*

# Job control
setopt LONG_LIST_JOBS          # List jobs in long format
setopt AUTO_RESUME             # Resume suspended jobs by name
setopt NOTIFY                  # Report job status immediately
setopt BG_NICE                 # Run background jobs at lower priority
