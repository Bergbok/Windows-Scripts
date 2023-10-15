@REM Kills Steam.
@REM Since the UI bugs out so oftenly with multi monitor setups when connecting/disconnecting displays.
TaskKill /IM steam.exe /F
TaskKill /IM steamservice.exe /F
TaskKill /IM steamwebhelper.exe /F