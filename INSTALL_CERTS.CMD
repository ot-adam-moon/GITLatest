Certutil.exe -addstore -f "My" "%~dp0..\Certs\ProdSupCA.cert"
Certutil.exe -addstore -user -f "My" "%~dp0..\Certs\ProdSupCA.cert"
Certutil.exe -importPFX -f -p "H4ppyFunB4ll" "%~dp0..\Certs\tuiTestCert.pfx"
Certutil.exe -importPFX -user -f -p "H4ppyFunB4ll" "%~dp0..\Certs\tuiTestCert.pfx"
