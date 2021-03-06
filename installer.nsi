Unicode true

!include "MUI2.nsh"
 
InstallDir $PROGRAMFILES64\xterminate

# retreive xterminate version and add it to the installer's name
!getdllversion "target\release\xterminate.exe" EXEVERSION
Name "xterminate v${EXEVERSION1}.${EXEVERSION2}.${EXEVERSION3}"

# set installer executable name
OutFile "target\release\xterminate-setup.exe"

RequestExecutionLevel admin

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

# run xterminate when setup is complete
Function .oninstsuccess   
Exec "$INSTDIR\xterminate.exe"   
FunctionEnd

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"



Section
 
# define output path
SetOutPath $INSTDIR

# add files to uninstaller
File LICENSE
File target\release\xterminate.exe

SetOutPath $INSTDIR\res
File /r res\*.*
SetOutPath $INSTDIR
 
# create uninstaller
WriteUninstaller $INSTDIR\uninstall.exe

CreateShortcut "$SMPROGRAMS\xterminate.lnk" "$INSTDIR\xterminate.exe"
CreateShortcut "$SMPROGRAMS\Uninstall xterminate.lnk" "$INSTDIR\uninstall.exe"

# run xterminate on startup
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Run" "xterminate" "$INSTDIR\xterminate.exe"

# add uninstaller to list of installed programs
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "DisplayName" "xterminate"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "UninstallString" "$INSTDIR\uninstall.exe"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "Publisher" "Alex Karlsson Lindén"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "DisplayVersion" "${EXEVERSION1}.${EXEVERSION2}.${EXEVERSION3}"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "VersionMajor" "${EXEVERSION1}"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "VersionMinor" "${EXEVERSION2}"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "Version" "${EXEVERSION3}"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "InstallLocation" "$INSTDIR"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "Contact" "Alex Karlsson Lindén @ alexkarlin.dev@gmail.com"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                 "URLInfoAbout" "https://github.com/alexkarlin/xterminate"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                   "HelpLink" "https://github.com/alexkarlin/xterminate"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                   "Readme" "$INSTDIR\README"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                   "QuietUninstallString" "$\"$INSTDIR\uninstall.exe$\" /S"
WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                   "DisplayIcon" "$INSTDIR\xterminate.exe"
WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                   "NoModify" 1
WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate" \
                   "NoRepair" 1

SectionEnd



Section "Uninstall"
 
# remove the xterminat installation directory and shortcuts
RMDir /r $INSTDIR

Delete $SMPROGRAMS\xterminate.lnk
Delete "$SMPROGRAMS\Uninstall xterminate.lnk"

# remove run on startup registry value
DeleteRegValue HKLM "Software\Microsoft\Windows\CurrentVersion\Run" "xterminate"

# remove from list of installed programs
DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\xterminate"


SectionEnd