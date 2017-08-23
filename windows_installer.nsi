# http://nsis.sourceforge.net/
# http://www.mikeball.info/blog/node-webkit-app-windows-installer/
# macOS: brew install nsis

!define VERSION_STR  "5.5.1.303"
!define PRODUCT_NAME "Appazur Kiosk"
!define LINK_FILENAME "appazurkiosk.lnk"
!define INSTALLER_FILENAME "AppazurInstaller.exe"
!define UNINSTALLER_FILENAME "AppazurUninstaller.exe"
!define NWJS_WIN_PATH "nwjs-win-x64"

Name "${PRODUCT_NAME}"

# define the resulting installer's name:
OutFile "${INSTALLER_FILENAME}"

InstallDir $PROGRAMFILES\AppazurKiosk
AllowRootDirInstall true
BrandingText "Appazur Solutions Inc."
ShowInstDetails "Show"
ShowUninstDetails "Show"
VIProductVersion "${VERSION_STR}"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "CompanyName" "Appazur Solutions Inc."
VIAddVersionKey "LegalCopyright" "© Appazur Solutions Inc"
VIAddVersionKey "FileVersion" "${VERSION_STR}"

# default section start
Section

  # define the path to which the installer should install
  SetOutPath $INSTDIR

  # specify the files to go in the output path
  File ${NWJS_WIN_PATH}\d3dcompiler_47.dll
  File ${NWJS_WIN_PATH}\ffmpeg.dll
  File ${NWJS_WIN_PATH}\icudtl.dat
  File ${NWJS_WIN_PATH}\libEGL.dll
  File ${NWJS_WIN_PATH}\libGLESv2.dll
  File ${NWJS_WIN_PATH}\natives_blob.bin
  File ${NWJS_WIN_PATH}\node.dll
  File ${NWJS_WIN_PATH}\nw_100_percent.pak
  File ${NWJS_WIN_PATH}\nw_200_percent.pak
  File ${NWJS_WIN_PATH}\nw_elf.dll
  File ${NWJS_WIN_PATH}\nw.dll
  File ${NWJS_WIN_PATH}\nw.exe
  File ${NWJS_WIN_PATH}\resources.pak
  File ${NWJS_WIN_PATH}\snapshot_blob.bin

  # ZIP file of kiosk/src:
  File package.nw

  SetOutPath $INSTDIR\locales
  File ${NWJS_WIN_PATH}\locales\en-US.pak

  # define the uninstaller name
  WriteUninstaller $INSTDIR\${UNINSTALLER_FILENAME}
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppazurKiosk" \
                 "DisplayName" "Appazur Kiosk v3"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppazurKiosk" \
                 "UninstallString" "$\"$INSTDIR\${UNINSTALLER_FILENAME}$\""
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppazurKiosk" \
                 "QuietUninstallString" "$\"$INSTDIR\${UNINSTALLER_FILENAME}$\" /S"
                 
  CreateShortCut "$SMPROGRAMS\${LINK_FILENAME}" "$INSTDIR\nw.exe"

SectionEnd

# create a section to define what the uninstaller does
Section "Uninstall"

  # delete the uninstaller
  Delete $INSTDIR\${UNINSTALLER_FILENAME}

  # delete the installed files
  Delete $INSTDIR\locales\*
  RMDir $INSTDIR\locales
  Delete $INSTDIR\d3dcompiler_47.dll
  Delete $INSTDIR\ffmpeg.dll
  Delete $INSTDIR\icudtl.dat
  Delete $INSTDIR\libEGL.dll
  Delete $INSTDIR\libGLESv2.dll
  Delete $INSTDIR\natives_blob.bin
  Delete $INSTDIR\node.dll
  Delete $INSTDIR\nw_100_percent.pak
  Delete $INSTDIR\nw_200_percent.pak
  Delete $INSTDIR\nw_elf.dll
  Delete $INSTDIR\nw.dll
  Delete $INSTDIR\nw.exe
  Delete $INSTDIR\resources.pak
  Delete $INSTDIR\snapshot_blob.bin
  Delete $INSTDIR\package.nw
  Delete $SMPROGRAMS\${LINK_FILENAME}
  RMDir $INSTDIR
  
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\AppazurKiosk"

SectionEnd
