# =============================================================================
# Module Loaders
# =============================================================================

# Load a specific file if it exists
load_module() {
	local file="$1"

    [[ -r "$file" ]] && source "$file"
}

# Load all zsh files from a directory
load_modules() {
	local dir="$1"

	if [[ ! -d "$dir" ]]; then
		return 1
	fi
	
	for file in "$dir"/*.zsh(N); do
		load_module "$file"
	done
}

load_profiles() {
	local dir="$1"

	if [[ ! -d "$dir" ]]; then
		return 1
	fi

	local profile_dir name
	
	for profile_dir in "$dir"/*(/N); do
		name="${profile_dir:t}"
		load_module "$profile_dir/profile.$name.zsh"
	done
}

# Command exists check
command_exists() {
  command -v "$@" > /dev/null 2>&1
}

path_append() {
    local dir="$1"

    [[ -d "$HOME$dir" ]] || return
	export PATH="$HOME$dir:$PATH"
}