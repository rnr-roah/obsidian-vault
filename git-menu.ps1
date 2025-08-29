# git-menu.ps1
# Simple Git automation with menu


Write-Host "Select an option:" -ForegroundColor Yellow
Write-Host "1. Pull" -ForegroundColor Cyan
Write-Host "2. Push" -ForegroundColor Cyan
Write-Host "3. Pull + Push" -ForegroundColor Cyan
Write-Host "4. Exit" -ForegroundColor Cyan

$choice = Read-Host "Enter your choice (1-4)"

switch ($choice) {
    "1" {
        Write-Host "Pulling latest changes..." -ForegroundColor Green
        git pull
    }
    "2" {
        $msg = Read-Host "Enter commit message"
        Write-Host "`Adding all changes..." -ForegroundColor Green
        git add .
        Write-Host "Committing..." -ForegroundColor Green
        git commit -m "$msg"
        Write-Host "Pushing..." -ForegroundColor Green
        git push
    }
    "3" {
        Write-Host "Pulling latest changes first..." -ForegroundColor Green
        git pull
        $msg = Read-Host "Enter commit message"
        Write-Host "Adding all changes..." -ForegroundColor Green
        git add .
        Write-Host "Committing..." -ForegroundColor Green
        git commit -m "$msg"
        Write-Host "Pushing..." -ForegroundColor Green
        git push
    }
    "4" {
        Write-Host "Exiting..." -ForegroundColor Magenta
        exit
    }
    Default {
        Write-Host "Invalid choice, please try again." -ForegroundColor Red
    }
}

Write-Host "Done!" -ForegroundColor Green
