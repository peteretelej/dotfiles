#!/bin/bash
# Dotfiles installation script
# Installs required dev tools and dotfiles .bashrc, .vimrc, and .tmux.conf

# Make sure we're not running as root
if [ $(id -u) -eq 0 ]; then
	echo "ERROR: ./install.sh should not be run as root"
	exit 2
fi

# Ensure we're in the dotfiles directory
if [ "${PWD##*/}" != "dotfiles" ]; then
	echo "ERROR: ./install.sh must be run from dotfiles directory"
	exit 2
fi

# Define tools to install
COMMON_TOOLS="git curl vim tmux"
SYSTEM_TOOLS="htop jq net-tools unzip zip"
DEBIAN_BUILD_TOOLS="build-essential"
RHEL_BUILD_TOOLS="gcc make"
MAC_TOOLS=""

# Installation type (simple by default)
INSTALLTYPE="simple"
if [ "$1" == "--full" ] || [ "$1" == "-full" ]; then
	INSTALLTYPE="full"
	echo "Running FULL install.sh"
else
	echo "Running simple dotfiles install. Use './install.sh --full' for full install if needed"
fi

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Created backup directory: $BACKUP_DIR"

# Function to backup and install a dotfile
install_dotfile() {
	SOURCE="$1"
	DEST="$HOME/$2"
	
	# Backup existing file if it exists and is not a symlink
	if [ -f "$DEST" ] && [ ! -L "$DEST" ]; then
		echo "Backing up existing $DEST to $BACKUP_DIR"
		cp "$DEST" "$BACKUP_DIR/"
	fi
	
	# Copy the file
	echo "Installing $SOURCE to $DEST"
	cp "$SOURCE" "$DEST"
}

# Function to install all dotfiles and source bashrc
install_all_dotfiles() {
	echo "Installing dotfiles..."
	
	# Install .bashrc
	install_dotfile ".bashrc" ".bashrc"
	
	# Install .vimrc
	install_dotfile ".vimrc" ".vimrc"
	
	# Install .tmux.conf
	install_dotfile ".tmux.conf" ".tmux.conf"
	
	echo "Installation complete!"
	
	# Source the new .bashrc
	echo "Applying new bash configuration..."
	source "$HOME/.bashrc"
	echo "New bash configuration applied!"
}

# If it's a simple install, just install dotfiles and exit
if [ "$INSTALLTYPE" == "simple" ]; then
	install_all_dotfiles
	
	echo
	echo "Dotfiles successfully installed! Use './install.sh --full' for a full installation with dependencies."
	exit 0
fi

# If we get here, we're doing a full install
echo "Installing dependencies..."

INSTALLED_TOOLS=""

# Detect package manager
if command -v apt-get >/dev/null 2>&1; then
	# Debian/Ubuntu
	INSTALLED_TOOLS="$DEBIAN_BUILD_TOOLS $COMMON_TOOLS $SYSTEM_TOOLS"
	sudo apt-get update && \
	sudo apt-get install -y $INSTALLED_TOOLS
elif command -v yum >/dev/null 2>&1; then
	# RHEL/CentOS/Fedora
	INSTALLED_TOOLS="$RHEL_BUILD_TOOLS $COMMON_TOOLS $SYSTEM_TOOLS"
	sudo yum install -y $INSTALLED_TOOLS
elif command -v brew >/dev/null 2>&1; then
	# macOS
	INSTALLED_TOOLS="$COMMON_TOOLS $SYSTEM_TOOLS $MAC_TOOLS"
	brew update && \
	brew install $INSTALLED_TOOLS
else
	echo "WARNING: No recognized package manager found. Please install dependencies manually:"
	echo "  - $COMMON_TOOLS $SYSTEM_TOOLS"
fi

# Install dotfiles
install_all_dotfiles

# Show a concise summary of installed tools
echo
echo "Installed tools:"

# Format the tools with bullet points
formatted_tools=""
for tool in $INSTALLED_TOOLS; do
	formatted_tools="$formatted_tools • $tool"
done

# Display tools in a wrapped format
echo $formatted_tools | fold -s -w 70

echo
echo "Dotfiles successfully installed!"