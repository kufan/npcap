
:: Copy Packet.dll
xcopy /Y	"..\packetWin7\Dll\Project\Release No NetMon and AirPcap\Packet.dll"		.\win7_above\x86
xcopy /Y	"..\packetWin7\Dll\Project\x64\Release No NetMon and AirPcap\Packet.dll"	.\win7_above\x64

:: Copy NPcapHelper.exe
xcopy /Y	"..\packetWin7\Helper\release\NPcapHelper.exe"								.\win7_above\x86\admin_only
xcopy /Y	"..\packetWin7\Helper\x64\release\NPcapHelper.exe"							.\win7_above\x64\admin_only

:: Copy Npcap driver files
xcopy /Y	"..\packetWin7\npf\Win7Release\npf Package\npcap.cat"						.\win7_above\x86
xcopy /Y	"..\packetWin7\npf\Win7Release\npf Package\npcap.inf"						.\win7_above\x86
xcopy /Y	"..\packetWin7\npf\Win7Release\npf Package\npcap.sys"						.\win7_above\x86
xcopy /Y	"..\packetWin7\npf\x64\Win7Release\npf Package\npcap.cat"					.\win7_above\x64
xcopy /Y	"..\packetWin7\npf\x64\Win7Release\npf Package\npcap.inf"					.\win7_above\x64
xcopy /Y	"..\packetWin7\npf\x64\Win7Release\npf Package\npcap.sys"					.\win7_above\x64
xcopy /Y	"..\packetWin7\npf\Win7ReleaseAdmin-onlyMode\npf Package\npcap.cat"			.\win7_above\x86\admin_only
xcopy /Y	"..\packetWin7\npf\Win7ReleaseAdmin-onlyMode\npf Package\npcap.inf"			.\win7_above\x86\admin_only
xcopy /Y	"..\packetWin7\npf\Win7ReleaseAdmin-onlyMode\npf Package\npcap.sys"			.\win7_above\x86\admin_only
xcopy /Y	"..\packetWin7\npf\x64\Win7ReleaseAdmin-onlyMode\npf Package\npcap.cat"		.\win7_above\x64\admin_only
xcopy /Y	"..\packetWin7\npf\x64\Win7ReleaseAdmin-onlyMode\npf Package\npcap.inf"		.\win7_above\x64\admin_only
xcopy /Y	"..\packetWin7\npf\x64\Win7ReleaseAdmin-onlyMode\npf Package\npcap.sys"		.\win7_above\x64\admin_only

:: Copy NPFInstall.exe
xcopy /Y	"..\packetWin7\NPFInstall\Release\NPFInstall.exe"							.\win7_above\x86
xcopy /Y	"..\packetWin7\NPFInstall\x64\Release\NPFInstall.exe"						.\win7_above\x64

:: Npcap uses the original WinPcap wpcap.dll with exactly the same code, we just changed the version number.
:: Copy wpcap.dll
xcopy /Y	"..\wpcap\PRJ\Release No AirPcap\x86\wpcap.dll"								.
xcopy /Y	"..\wpcap\PRJ\Release No AirPcap\x64\wpcap.dll"								.\x64

:: First need to add "signtool.exe" to PATH, then put the cert file (e.g. C:\xxx.pfx) to environment variable %NPF_CERT_PATH%,
:: put the private key string (e.g. 123456) to environment variable %NPF_SIGN_PK%
:: Sign NPcapHelper.exe
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\win7_above\x86\admin_only\NPcapHelper.exe
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\win7_above\x64\admin_only\NPcapHelper.exe

:: Sign Packet.dll
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\win7_above\x86\Packet.dll
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\win7_above\x64\Packet.dll

:: Sign NPFInstall.exe
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\win7_above\x86\NPFInstall.exe
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\win7_above\x64\NPFInstall.exe

:: Sign wpcap.dll
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\wpcap.dll
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\x64\wpcap.dll

:: First need to add "makensis.exe" to PATH
:: Generate installer
"C:\Program Files (x86)\NSIS\makensis.exe" .\NPcap-for-nmap.nsi

:: Sign npcap-nmap-0.01.exe
signtool sign /f %NPF_CERT_PATH% /p %NPF_SIGN_PK% .\npcap-nmap-0.01.exe

pause
