@REM Opens VLC and plays all audio tracks on a file simultaneosly.
@REM You might need to change the VLC path if you have it installed somewhere differently.
set "VLC_PATH=C:\Program Files (x86)\VideoLAN\VLC\vlc.exe"
start "" "%VLC_PATH%" --sout-all --sout #display