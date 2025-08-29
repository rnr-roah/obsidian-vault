#!/bin/bash
# git-linux.sh
# Git automation with menu
# Reads PAT from external file for safe GitHub push

GIT_USERNAME="rnr-roah"
TOKEN_FILE="/home/roah/git-files/git-auth-token"

# Check if token file exists
if [ ! -f "$TOKEN_FILE" ]; then
    echo "❌ Token file not found at $TOKEN_FILE"
    exit 1
fi

# Read the token
GIT_TOKEN=$(< "$TOKEN_FILE")

# Ensure we are in a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Not inside a Git repository. Please navigate to a repo and run again."
    exit 1
fi

echo "Username: $GIT_USERNAME"
echo "Select an option:"
echo "1. Pull"
echo "2. Push"
echo "3. Pull + Push"
echo "4. Reset + Clone"
echo "5. Exit"

read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo "🔄 Pulling latest changes..."
        git pull
        ;;
    2)
        read -p "Enter commit message: " msg
        git add *
        git commit -m "$msg"
        echo "📤 Pushing..."
        git push https://$GIT_USERNAME:$GIT_TOKEN@github.com/rnr-roah/obsidian-vault.git

        ;;
    3)
        echo "🔄 Pulling latest changes first..."
        git pull
        read -p "Enter commit message: " msg
        git add .
        git commit -m "$msg"
        echo "📤 Pushing..."
	git push https://$GIT_USERNAME:$GIT_TOKEN@github.com/rnr-roah/obsidian-vault.git

        ;;
    4)
        echo "Deleting all the files and resetting the vault, are you sure? (press Enter for yes)"
        read enter
        cd ..
        sudo rm -r obsidian-vault
        echo "Downloading files"
        git clone https://$GIT_USERNAME:$GIT_TOKEN@github.com/rnr-roah/obsidian-vault.git

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

