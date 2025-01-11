#!/bin/bash

# Cursor Installer/Remover Script with Flags

set -e

# Architecture detection function
function get_arch() {
    local arch=$(uname -m)
    if [ "$arch" == "x86_64" ]; then
        echo "x64"
    elif [ "$arch" == "aarch64" ]; then
        echo "arm64"
    else
        echo "Unsupported architecture: $arch" >&2
        exit 1
    fi
}

# Constants
SCRIPT_DIR=$(dirname "$(realpath "$0")")
APPIMAGE_PATH="/opt/cursor.appimage"
DESKTOP_ENTRY_PATH="/usr/share/applications/cursor.desktop"
ICON_PATH="/opt/cursor.png"
ICON_URL="https://raw.githubusercontent.com/Trsnaqe/cursor-linux-installer/main/assets/cursor.png"
TERMINAL=$(tty) # Default terminal to the system's active terminal
ARCH=$(get_arch) # Get system architecture
APPIMAGE_URL="https://downloader.cursor.sh/linux/appImage/$ARCH" # Dynamic download link based on architecture

function install_cursor() {
    echo -e "🛠️ Starting installation..."
    echo -e "💻 Detected architecture: $ARCH"

    # Step 1: Download the AppImage
    echo -e "⬇️ Downloading Cursor AppImage for $ARCH..."
    curl -L "$APPIMAGE_URL" -o "$SCRIPT_DIR/cursor.appimage"

    # Check if the AppImage has been downloaded correctly
    if [ ! -f "$SCRIPT_DIR/cursor.appimage" ]; then
        echo -e "❌ Error: Failed to download the AppImage."
        exit 1
    fi
    echo -e "✅ AppImage downloaded successfully."

    # Step 2: Move the AppImage to /opt
    echo -e "📦 Moving AppImage to /opt..."
    sudo mv "$SCRIPT_DIR/cursor.appimage" "$APPIMAGE_PATH"

    # Step 3: Make the AppImage Executable
    echo -e "⚙️ Making AppImage executable..."
    sudo chmod +x "$APPIMAGE_PATH"

    # Step 4: Download and install the icon
    echo -e "🎨 Downloading and installing icon..."
    curl -L "$ICON_URL" -o "/tmp/cursor.png"
    if [ ! -f "/tmp/cursor.png" ]; then
        echo -e "❌ Error: Failed to download the icon."
        exit 1
    fi
    sudo mv "/tmp/cursor.png" "$ICON_PATH"

    # Step 5: Create Desktop Entry
    echo -e "📝 Creating Desktop Entry..."
    sudo bash -c "cat > $DESKTOP_ENTRY_PATH" << EOL
[Desktop Entry]
Name=Cursor
Exec=$TERMINAL -e /opt/cursor.appimage
Icon=$ICON_PATH
Type=Application
Categories=Development;
Terminal=true
EOL

    # Step 6: Create a symlink for 'cursor' command
    echo -e "🔗 Creating symlink for 'cursor' command..."
    sudo ln -sf "$APPIMAGE_PATH" /usr/local/bin/cursor

    echo -e "\n🟢 Cursor installed successfully! You can find it in your application menu.\n"
    echo -e "🚀 Installation Complete!"
    echo -e "✅ Build Completed!"
}

function remove_cursor() {
    echo -e "🛠️ Starting removal..."

    # Step 1: Remove the AppImage
    if [ -f "$APPIMAGE_PATH" ]; then
        echo -e "🗑️ Removing AppImage..."
        sudo rm "$APPIMAGE_PATH"
    fi

    # Step 2: Remove the Desktop Entry
    if [ -f "$DESKTOP_ENTRY_PATH" ]; then
        echo -e "🗑️ Removing Desktop Entry..."
        sudo rm "$DESKTOP_ENTRY_PATH"
    fi

    # Step 3: Remove the Icon
    if [ -f "$ICON_PATH" ]; then
        echo -e "🗑️ Removing Icon..."
        sudo rm "$ICON_PATH"
    fi

    # Step 4: Remove the 'cursor' symlink
    if [ -L "/usr/local/bin/cursor" ]; then
        echo -e "🗑️ Removing symlink for 'cursor' command..."
        sudo rm /usr/local/bin/cursor
    fi

    echo -e "\n🟢 Cursor uninstalled successfully!"
    echo -e "🚀 Uninstallation Complete!"
    echo -e "✅ Script Completed!"

}

function show_help() {
    echo -e "📚 Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  --install    Install Cursor"
    echo "  --remove     Remove Cursor"
    echo "  --help       Show this help message"
}

# Parse Flags
if [ "$#" -eq 0 ]; then
    echo -e "No options provided. Use the default interactive mode."
    echo -e "1) Install Cursor"
    echo -e "2) Remove Cursor"
    echo -e "3) Exit"
    read -rp "Enter your choice [1-3]: " choice
    case $choice in
        1)
            install_cursor
            ;;
        2)
            remove_cursor
            ;;
        3)
            echo -e "Exiting..."
            exit 0
            ;;
        *)
            echo -e "❌ Invalid choice. Exiting..."
            exit 1
            ;;
    esac
else
    case "$1" in
        --install)
            install_cursor
            ;;
        --remove)
            remove_cursor
            ;;
        --help)
            show_help
            ;;
        *)
            echo -e "❌ Invalid option: $1"
            show_help
            exit 1
            ;;
    esac
fi
