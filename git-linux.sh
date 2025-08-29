#!/bin/bash
# git-menu.sh
# Simple Git automation with menu

# Ensure we are in a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Not inside a Git repository. Please navigate to a repo and run again."
    exit 1
fi

echo "Select an option:"
echo "1. Pull"
echo "2. Push"
echo "3. Pull + Push"
echo "4. Reset + Clone"
echo "5. Exit"

read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo "🔄 Pulling latest changes..."
        git pull
        ;;
    2)
        read -p "Enter commit message: " msg
        echo "➕ Adding all changes..."
        git add .
        echo "💾 Committing..."
        git commit -m "$msg"
        echo "📤 Pushing..."
        git push
        ;;
    3)
        echo "🔄 Pulling latest changes first..."
        git pull
        read -p "Enter commit message: " msg
        echo "➕ Adding all changes..."
        git add .
        echo "💾 Committing..."
        git commit -m "$msg"
        echo "📤 Pushing..."
        git push
        ;;
    4)
        echo "Deleting all the files and resetting the vault, are you sure? (enter for yes)"
        read enter
        echo "Deleting all the files"
        cd ..
        sudo rm -r obsidian-vault
        echo "Dowloading files"
        git clone https://github.com/rnr-roah/obsidian-vault
        cd obsidian-vault
        ;;
    5)
        echo "👋 Exiting..."
        exit 0
        ;;
    *)
        echo "❌ Invalid choice. Please try again."
        ;;
esac

echo "✅ Done!"

