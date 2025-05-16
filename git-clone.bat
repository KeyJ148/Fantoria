@echo off
setlocal enabledelayedexpansion

:: File containing the list of modules
set FILE=settings.gradle.kts
:: Base repository URL
set BASE_URL=https://github.com/KeyJ148

echo Getting list of modules from %FILE%...

:: Search for lines with include(
for /f "tokens=*" %%L in ('findstr /r /c:"include(" "%FILE%"') do (
    set "line=%%L"

    :: Remove include, quotes, parentheses, and spaces
    set "line=!line:include=!"
    set "line=!line:(=!"
    set "line=!line:)=!"
    set "line=!line:"=!"
    set "line=!line: =!"

    if not "!line!"=="" (
        echo Cloning !line! ...
        if exist "!line!" (
            echo Directory !line! already exists, skipping.
        ) else (
            git clone "%BASE_URL%/!line!.git"
        )
    )
)

endlocal
