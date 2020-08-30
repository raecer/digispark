$Username = "bsfn.edu\op_jimmy"

Function Button_Click(){
    Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList {/k gpupdate /force}
}

Function Button2_Click(){
    netsh wlan delete profile name="bsf-edu"
}

Function Button3_Click(){
    rundll32.exe SHELL32.DLL,SHHelpShortcuts_RunDLL AddPrinter
}

Function Button4_Click(){
    Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList {/c runas.exe /user:bsfn.edu\op_jimmy cmd}
    #Start-Process -FilePath "C:\Windows\System32\cmd.exe" -verb runasuser
}

Function Button5_Click(){
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = [Environment]::GetFolderPath("Desktop") 
        Filter = "Exe Files|*.exe|All Files|*.*"
        Title = "Välj fil att starta som $Username"
    }
    $result = $FileBrowser.ShowDialog()
    if($result -eq "Cancel"){    
        [System.Windows.Forms.MessageBox]::Show("Inget valt.")
    }
    else {
        Start-Process -Credential $Username -FilePath $FileBrowser.FileName
        #Start-Process -FilePath "C:\Windows\System32\cmd.exe" -ArgumentList '/k runas.exe /user:bsfn.edu\op_jimmy', `"$($FileBrowser.FileName)`"
    } 
}

Function Generate-Form{
    Add-Type -assembly System.Windows.Forms

    $main_form = New-Object System.Windows.Forms.Form
    $main_form.Text ='GUI'
    $main_form.Width = 600
    $main_form.Height = 400
    $main_form.AutoSize = $true

    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Size(10,10)
    $Button.Size = New-Object System.Drawing.Size(120,23)
    $Button.Text = "Gpupdate /force"
    $Button.Add_Click({Button_Click})

    $Button2 = New-Object System.Windows.Forms.Button
    $Button2.Location = New-Object System.Drawing.Size(150,10)
    $Button2.Size = New-Object System.Drawing.Size(120,23)
    $Button2.Text = "Reinstall wifi"
    $Button2.Add_Click({Button2_Click})

    $Button3 = New-Object System.Windows.Forms.Button
    $Button3.Location = New-Object System.Drawing.Size(300,10)
    $Button3.Size = New-Object System.Drawing.Size(120,23)
    $Button3.Text = "Add printer"
    $Button3.Add_Click({Button3_Click})
    
    $Button4 = New-Object System.Windows.Forms.Button
    $Button4.Location = New-Object System.Drawing.Size(450,10)
    $Button4.Size = New-Object System.Drawing.Size(120,23)
    $Button4.Text = "Run as"
    $Button4.Add_Click({Button4_Click})
    
    $Button5 = New-Object System.Windows.Forms.Button
    $Button5.Location = New-Object System.Drawing.Size(600,10)
    $Button5.Size = New-Object System.Drawing.Size(120,23)
    $Button5.Text = "Run program as"
    $Button5.Add_Click({Button5_Click})

    $main_form.Controls.Add($Button)
    $main_form.Controls.Add($Button2)
    $main_form.Controls.Add($Button3)
    $main_form.Controls.Add($Button4)
    $main_form.Controls.Add($Button5)
    $main_form.ShowDialog()
}
Generate-Form
