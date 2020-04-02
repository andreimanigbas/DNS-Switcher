TITLE DNS Switcher
COLOR 0F
@ECHO off
goto CheckAdmin

:CheckAdmin
cls
    net session >nul 2>&1
    if %errorLevel% == 0 (
		mode con:cols=48 lines=5
		color 0A
		echo.
		echo.
        echo     Admin permission granted. Redirecting...
		TIMEOUT /t 3 > NUL
		GOTO MENU
    ) else (
		mode con:cols=48 lines=5
		color 04
		echo.
		echo.
        echo   You must run this program as Administrator.
		TIMEOUT /t 5 > NUL
		EXIT
    )

:MENU
mode con:cols=48 lines=26
CLS
ECHO.
ECHO                            ,--.             
ECHO          ,---,           ,--.'^|  .--.--.    
ECHO        .'  .' `\     ,--,:  : ^| /  /    '.  
ECHO      ,---.'     \ ,`--.'`^|  ' :^|  :  /`. /  
ECHO      ^|   ^|  .`\  ^|^|   :  :  ^| ^|;  ^|  ^|--`   
ECHO      :   : ^|  '  ^|:   ^|   \ ^| :^|  :  ;_     
ECHO      ^|   ' '  ;  :^|   : '  '; ^| \  \    `.  
ECHO      '   ^| ;  .  ^|'   ' ;.    ;  `----.   \ 
ECHO      ^|   ^| :  ^|  '^|   ^| ^| \   ^|  __ \  \  ^| 
ECHO      '   : ^| /  ; '   : ^|  ; .' /  /`--'  / 
ECHO      ^|   ^| '` ,/  ^|   ^| '`--'  '--'.     /  
ECHO      ;   :  .'    '   : ^|        `--'---'   
ECHO      ^|   ,.'      ;   ^|.'                   
ECHO      '---'        '---'                     
ECHO.
ECHO.
ECHO               1 - Google DNS
ECHO               2 - Cloudflare DNS
ECHO               3 - AdGuard DNS
ECHO               4 - Manual
ECHO               _ - Clear
ECHO               x - Exit
ECHO.
SET "what="
SET /P what=^>
IF NOT DEFINED what GOTO CLEAR
IF %what%==1 GOTO GOOGLE
IF %what%==2 GOTO CLOUDFLARE
IF %what%==3 GOTO ADGUARD
IF %what%==4 GOTO MANUAL
IF %what%==x EXIT

:MANUAL
mode con:cols=48 lines=20
CLS
ECHO.
ECHO                            ,--.             
ECHO          ,---,           ,--.'^|  .--.--.    
ECHO        .'  .' `\     ,--,:  : ^| /  /    '.  
ECHO      ,---.'     \ ,`--.'`^|  ' :^|  :  /`. /  
ECHO      ^|   ^|  .`\  ^|^|   :  :  ^| ^|;  ^|  ^|--`   
ECHO      :   : ^|  '  ^|:   ^|   \ ^| :^|  :  ;_     
ECHO      ^|   ' '  ;  :^|   : '  '; ^| \  \    `.  
ECHO      '   ^| ;  .  ^|'   ' ;.    ;  `----.   \ 
ECHO      ^|   ^| :  ^|  '^|   ^| ^| \   ^|  __ \  \  ^| 
ECHO      '   : ^| /  ; '   : ^|  ; .' /  /`--'  / 
ECHO      ^|   ^| '` ,/  ^|   ^| '`--'  '--'.     /  
ECHO      ;   :  .'    '   : ^|        `--'---'   
ECHO      ^|   ,.'      ;   ^|.'                   
ECHO      '---'        '---'                     
ECHO.
SET "primary="
SET /P primary=Set Primary: 
IF NOT DEFINED primary GOTO MENU
SET /P secondary=Set Secondary: 
GOTO SET

:SET
mode con:cols=48 lines=20
CLS
ECHO.
ECHO                            ,--.             
ECHO          ,---,           ,--.'^|  .--.--.    
ECHO        .'  .' `\     ,--,:  : ^| /  /    '.  
ECHO      ,---.'     \ ,`--.'`^|  ' :^|  :  /`. /  
ECHO      ^|   ^|  .`\  ^|^|   :  :  ^| ^|;  ^|  ^|--`   
ECHO      :   : ^|  '  ^|:   ^|   \ ^| :^|  :  ;_     
ECHO      ^|   ' '  ;  :^|   : '  '; ^| \  \    `.  
ECHO      '   ^| ;  .  ^|'   ' ;.    ;  `----.   \ 
ECHO      ^|   ^| :  ^|  '^|   ^| ^| \   ^|  __ \  \  ^| 
ECHO      '   : ^| /  ; '   : ^|  ; .' /  /`--'  / 
ECHO      ^|   ^| '` ,/  ^|   ^| '`--'  '--'.     /  
ECHO      ;   :  .'    '   : ^|        `--'---'   
ECHO      ^|   ,.'      ;   ^|.'                   
ECHO      '---'        '---'                     
ECHO.
ECHO    Primary DNS will be set to %primary%
ECHO    Primary DNS will be set to %secondary%
TIMEOUT /T 5 > NUL
wmic nicconfig where (IPEnabled=TRUE) call SetDNSServerSearchOrder ("%primary%", "%secondary%") > NUL
EXIT

:CLEAR
mode con:cols=48 lines=20
cls
ECHO.
ECHO                            ,--.             
ECHO          ,---,           ,--.'^|  .--.--.    
ECHO        .'  .' `\     ,--,:  : ^| /  /    '.  
ECHO      ,---.'     \ ,`--.'`^|  ' :^|  :  /`. /  
ECHO      ^|   ^|  .`\  ^|^|   :  :  ^| ^|;  ^|  ^|--`   
ECHO      :   : ^|  '  ^|:   ^|   \ ^| :^|  :  ;_     
ECHO      ^|   ' '  ;  :^|   : '  '; ^| \  \    `.  
ECHO      '   ^| ;  .  ^|'   ' ;.    ;  `----.   \ 
ECHO      ^|   ^| :  ^|  '^|   ^| ^| \   ^|  __ \  \  ^| 
ECHO      '   : ^| /  ; '   : ^|  ; .' /  /`--'  / 
ECHO      ^|   ^| '` ,/  ^|   ^| '`--'  '--'.     /  
ECHO      ;   :  .'    '   : ^|        `--'---'   
ECHO      ^|   ,.'      ;   ^|.'                   
ECHO      '---'        '---'                     
ECHO.
ECHO.
ECHO              DNS will be cleared...
ECHO.
TIMEOUT /T 5 > NUL
wmic nicconfig where (IPEnabled=TRUE) call SetDNSServerSearchOrder > NUL
EXIT

:GOOGLE
SET "primary=8.8.8.8"
SET "secondary=8.8.4.4"
GOTO SET

:CLOUDFLARE
SET "primary=1.1.1.1"
SET "secondary=1.0.0.1"
GOTO SET

:ADGUARD
SET "primary=176.103.130.130"
SET "secondary=176.103.130.131"
GOTO SET