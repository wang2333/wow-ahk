@echo off
setlocal enabledelayedexpansion
set CurrentDir=%~dp0
set ZipFilePath=%CurrentDir%XZ.zip
set "SourceDir1=%~dp0TellMeWhen"
set "SourceDir2=%~dp0TellMeWhen_Options"
set "SourceDir3=%~dp0ZZYJHWLK"
set "TargetDir1=%~dp0Interface\AddOns\TellMeWhen"
set "TargetDir2=%~dp0Interface\AddOns\TellMeWhen_Options"
set "TargetDir3=%~dp0Interface\AddOns\ZZYJHWLK"
set "TargetDir4=%~dp0Interface\AddOns\ZZYJH60"
set "SourceFile1=%~dp0TellMeWhen.lua"
set "SourceFile2=%~dp0TellMeWhen_Options.lua"
set "SourceFile3=%~dp0ZZYJHWLK.lua"
set "BaseDir=%~dp0WTF\Account\"
powershell -Command "Expand-Archive -Path '%ZipFilePath%' -DestinationPath '%CurrentDir%' -Force"
del "%ZipFilePath%"
if not exist "%~dp0Interface\AddOns" (
    mkdir "%~dp0Interface\AddOns"
)
if exist "%SourceDir1%" (
    if exist "%TargetDir1%" (
        rmdir /S /Q "%TargetDir1%"
    )
)
if exist "%SourceDir2%" (
    if exist "%TargetDir2%" (
        rmdir /S /Q "%TargetDir2%"
    )
)
if exist "%SourceDir3%" (
    if exist "%TargetDir3%" (
        rmdir /S /Q "%TargetDir3%"
    )
)
    move "%SourceDir1%" "%~dp0Interface\AddOns\"
    move "%SourceDir2%" "%~dp0Interface\AddOns\"
    move "%SourceDir3%" "%~dp0Interface\AddOns\"
    for /d %%D in ("%BaseDir%*") do (
    for /d %%E in ("%%D*") do (
        if exist "%%E\SavedVariables" (
            if exist "%%E\SavedVariables\TellMeWhen.lua" (
                del /F /Q "%%E\SavedVariables\TellMeWhen.lua"
            )
            if exist "%%E\SavedVariables\TellMeWhen_Options.lua" (
                del /F /Q "%%E\SavedVariables\TellMeWhen_Options.lua"
            )
            if exist "%%E\SavedVariables\ZZYJHWLK.lua" (
                del /F /Q "%%E\SavedVariables\ZZYJHWLK.lua"
            )
            copy "%SourceFile1%" "%%E\SavedVariables\"
            copy "%SourceFile2%" "%%E\SavedVariables\"
            copy "%SourceFile3%" "%%E\SavedVariables\"
        )
    )
)
del "%SourceFile1%"
del "%SourceFile2%"
del "%SourceFile3%"