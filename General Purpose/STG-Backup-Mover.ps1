# Moves the backups Simple Tab Groups (https://addons.mozilla.org/en-US/firefox/addon/simple-tab-groups/) 
# makes to a specified directory

# change this to your downloads folder path
$downloads_folder_path = "C:\Users\Albertus\Downloads"

# change this to the folder you want to move the backups to
$move_to_path = "F:\Backups\Browser Backups\Simple Tab Groups Backups"

# Hides the window, since -windowstyle hidden doesn't work with Windows Terminal
$script:showwindowAsync = Add-Type -memberDefinition @"
[DllImport ("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdshow);
"@ -name "Win32ShowWindowAsync" -namespace Win32Functions -passThru

$showwindowAsync: : ShowWindowAsync( (Get-Process -id $pid).MainWindowHandle, 2)

# specify the path to the folder you want to monitor:
$Path = $downloads_folder_path

# specify which files you want to monitor
$FileFilter = '*'  

# specify whether you want to monitor subfolders as well:
$IncludeSubfolders = $true

# specify the file or folder properties you want to monitor:
$AttributeFilter = [IO.NotifyFilters]::FileName, [IO.NotifyFilters]::LastWrite 

# specify the type of changes you want to monitor:
$ChangeTypes = [System.IO.WatcherChangeTypes]::All

# specify the maximum time (in milliseconds) you want to wait for changes:
$Timeout = 1000

# define a function that gets called for every change:
function Invoke-SomeAction
{
  param
  (
    [Parameter(Mandatory)]
    [System.IO.WaitForChangedResult]
    $ChangeInformation
  )
  
  $ChangeInformation | Out-String | Write-Host -ForegroundColor DarkYellow
  Write-Warning 'Change detected:'
  Move-Item -Path "$Path\STG-backups-FF-*" -Destination $move_to_path -Force -Verbose

  # cd "C:\Users\Albertus\Downloads"
  # $MoveDirs = Get-ChildItem "STG*" -Attributes Directory
  # Add-Type -AssemblyName Microsoft.VisualBasic[Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile('"C:\Users\Albertus\Downloads\STG-backups-FF-*','OnlyErrorDialogs','SendToRecycleBin')
  #Move-Item -Path "C:\Users\Albertus\Downloads\*" -Destination "F:\Backups\Browser Backups\Simple Tab Groups Backups" -Include STG-backups-FF-* 
  #>> "C:\Users\Albertus\Documents\Utilities\Scripts\STG Backup Mover Log.txt"
  # $MoveDirs | Out-String | Write-Host -ForegroundColor DarkYellow
  # robocopy "C:\Users\Albertus\Downloads" "F:\Backups\Browser Backups\Simple Tab Groups Backups" /E /MOVE STG-backups-FF-* >> "F:\Backups\Browser Backups\Simple Tab Groups Backups\robocopy_log.txt"
}

# use a try...finally construct to release the
# filesystemwatcher once the loop is aborted
# by pressing CTRL+C

try
{
  Write-Warning "FileSystemWatcher is monitoring $Path"
  
  # create a filesystemwatcher object
  $watcher = New-Object -TypeName IO.FileSystemWatcher -ArgumentList $Path, $FileFilter -Property @{
    IncludeSubdirectories = $IncludeSubfolders
    NotifyFilter = $AttributeFilter
  }

  # start monitoring manually in a loop:
  do
  {
    # wait for changes for the specified timeout
    # IMPORTANT: while the watcher is active, PowerShell cannot be stopped
    # so it is recommended to use a timeout of 1000ms and repeat the
    # monitoring in a loop. This way, you have the chance to abort the
    # script every second.
    $result = $watcher.WaitForChanged($ChangeTypes, $Timeout)
    # if there was a timeout, continue monitoring:
    if ($result.TimedOut) { continue }
    
    Invoke-SomeAction -Change $result
    # the loop runs forever until you hit CTRL+C    
  } while ($true)
}
finally
{
  # release the watcher and free its memory:
  $watcher.Dispose()
  Write-Warning 'FileSystemWatcher removed.'
}