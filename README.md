# Linux Cursor AI Installer 🚀

A simple installation manager script for Cursor AI on Linux systems with automated setup and easy management.

## ✨ Script Features

- 🛠️ **Interactive Mode**: User-friendly menu-driven installation
- 🔄 **Command Line Options**: Support for `--install`, `--remove`, and `--help` flags
- 📦 **Automated Setup**: Handles all installation steps automatically
- 🎯 **System Integration**: 
  - Creates desktop entry
  - Adds application to system menu
  - Sets up command-line access
  - Manages icons and shortcuts
- 🧹 **Clean Uninstallation**: Complete removal of all components
- 🔒 **Safe Execution**: Error handling and validation checks

## 📥 Usage

### Interactive Mode
```bash
./cursor_manager.sh
```
This will present you with options to:
1. Install Cursor
2. Remove Cursor
3. Exit

### Command Line Options
```bash
./cursor_manager.sh --install    # Install Cursor
./cursor_manager.sh --remove     # Remove Cursor
./cursor_manager.sh --help       # Show help message
```

## 🔧 What the Script Does

### During Installation
1. Downloads the latest AppImage
2. Sets up in `/opt` directory
3. Creates desktop integration
4. Configures system-wide command `cursor`
5. Installs application icon
6. Sets appropriate permissions

### During Removal
1. Removes AppImage
2. Cleans desktop entries
3. Removes system command
4. Deletes application icons
5. Complete system cleanup

## 🚀 Quick Start

1. Make the script executable:
```bash
chmod +x cursor_manager.sh
```

2. Run in interactive mode:
```bash
./cursor_manager.sh
```

## 🔍 Troubleshooting

If you encounter a "Permission denied" error:
```bash
chmod +x cursor_manager.sh
```

For other issues:
- Open issue on the repository

## 📢 Contributing

Feel free to:
- Report issues
- Suggest improvements
- Submit pull requests

## ⚖️ Legal Notice and Attribution

This is an **unofficial** installation helper script for Cursor AI. This project is not affiliated with, officially connected to, or endorsed by Cursor or Anysphere Inc.

- Cursor and its logo are trademarks of [Anysphere Inc](https://www.cursor.com/)
- All rights for Cursor belong to their respective owners
- This script is provided as-is without any warranties
- Visit [cursor.com](https://www.cursor.com/) for the official product

The script is intended to help Linux users install Cursor AI more easily, while respecting all intellectual property rights of the original product.

