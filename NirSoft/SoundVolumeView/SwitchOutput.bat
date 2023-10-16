@REM Download SoundVolumeView here: https://www.nirsoft.net/utils/sound_volume_view.html
@REM Switches default sound device betweens two devices specified by device name
set "SOUNDVOLUMEVIEW_PATH=C:\Users\Albertus\Documents\Utilities\NirSoft\SoundVolumeView"
set "DEVICE1_NAME=MySpeakers"
set "DEVICE2_NAME=MyHeadphones"
%SOUNDVOLUMEVIEW_PATH%\SoundVolumeView.exe /SwitchDefault %DEVICE1_NAME% %DEVICE2_NAME% all
