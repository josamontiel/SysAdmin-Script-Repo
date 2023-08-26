# User Management Script

function Show-Menu {
    Clear-Host
    Write-Host "User Management Menu"
    Write-Host "1. Create a new user account"
    Write-Host "2. Copy profile for a new user"
    Write-Host "3. Disable or enable a user account"
    Write-Host "4. Reset user password"
    Write-Host "5. Modify user properties"
    Write-Host "6. Move user to a different OU"
    Write-Host "7. Exit"
}

do {
    Show-Menu
    $choice = Read-Host "Enter your choice"

    switch ($choice) {
        1 {
            $username = Read-Host "Enter the username"
            $password = Read-Host "Enter the password" -AsSecureString
            $ou = Read-Host "Enter the target OU"
            
            # Create new user account
            New-ADUser -Name $username -SamAccountName $username -UserPrincipalName "$username@domain.com" -Path $ou -AccountPassword $password -Enabled $true
        }
        2 {
            $newUser = Read-Host "Enter the new username"
            $sourceUser = Read-Host "Enter the source username for profile copy"
            
            # Copy profile for new user
            # Add your code here to copy the profile
        }
        3 {
            $username = Read-Host "Enter the username"
            $isEnabled = Read-Host "Enable (E) or Disable (D) the user account"
            
            # Enable or disable user account
            Set-ADUser -Identity $username -Enabled ($isEnabled -eq "E")
        }
        4 {
            $username = Read-Host "Enter the username"
            $newPassword = Read-Host "Enter the new password" -AsSecureString
            
            # Reset user password
            Set-ADAccountPassword -Identity $username -NewPassword $newPassword -Reset
        }
        5 {
            $username = Read-Host "Enter the username"
            
            # Modify user properties
            # Add your code here to modify properties
        }
        6 {
            $username = Read-Host "Enter the username"
            $targetOU = Read-Host "Enter the target OU"
            
            # Move user to a different OU
            Move-ADObject -Identity $username -TargetPath $targetOU
        }
        7 {
            Write-Host "Exiting..."
            break
        }
        default {
            Write-Host "Invalid choice. Please select a valid option."
        }
    }
    
    Write-Host "Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
} while ($choice -ne 7)
