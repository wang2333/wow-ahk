; 安装程序设置
Name "Screen Color Monitor"
OutFile "ScreenColorMonitor-Setup.exe"
InstallDir "$PROGRAMFILES\ScreenColorMonitor"
RequestExecutionLevel admin

; 页面
Page directory
Page instfiles

; 安装部分
Section "Install"
    SetOutPath $INSTDIR

    ; 复制主程序文件
    File "release\screen-monitor.exe"
    File "release\config.json"
    File "release\start.bat"

    ; 创建并复制资源文件
    CreateDirectory "$INSTDIR\resources"
    SetOutPath "$INSTDIR\resources"
    File "release\resources\mode1.wav"
    File "release\resources\mode2.wav"
    File "release\resources\pause.wav"

    ; 创建开始菜单快捷方式
    CreateDirectory "$SMPROGRAMS\Screen Color Monitor"
    CreateShortcut "$SMPROGRAMS\Screen Color Monitor\Screen Color Monitor.lnk" "$INSTDIR\screen-monitor.exe"
    CreateShortcut "$SMPROGRAMS\Screen Color Monitor\Uninstall.lnk" "$INSTDIR\uninstall.exe"

    ; 创建卸载程序
    WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd

; 卸载部分
Section "Uninstall"
    ; 删除主程序文件
    Delete "$INSTDIR\screen-monitor.exe"
    Delete "$INSTDIR\config.json"
    Delete "$INSTDIR\start.bat"
    Delete "$INSTDIR\uninstall.exe"

    ; 删除资源文件
    Delete "$INSTDIR\resources\mode1.wav"
    Delete "$INSTDIR\resources\mode2.wav"
    Delete "$INSTDIR\resources\pause.wav"
    RMDir "$INSTDIR\resources"

    ; 删除快捷方式
    Delete "$SMPROGRAMS\Screen Color Monitor\Screen Color Monitor.lnk"
    Delete "$SMPROGRAMS\Screen Color Monitor\Uninstall.lnk"
    RMDir "$SMPROGRAMS\Screen Color Monitor"

    ; 删除安装目录
    RMDir "$INSTDIR"
SectionEnd