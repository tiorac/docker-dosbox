mkdir -p /config/diskC
touch /config/diskC/autoexec.bat
/usr/bin/dosbox -fullscreen -c "mount c /config/diskC" -c "c:" -c "cls" -c "autoexec.bat"