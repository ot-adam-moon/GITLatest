﻿Certutil.exe -addstore -f "My" "%~dp0..\..\..\certs\ProdSupCA.cert"
Certutil.exe -addstore -user -f "My" "%~dp0..\..\..\certs\ProdSupCA.cert"
Certutil.exe -importPFX -f -p "H4ppyFunB4ll" "%~dp0..\..\..\certs\tuiTestCert.pfx"
Certutil.exe -importPFX -user -f -p "H4ppyFunB4ll" "%~dp0..\..\..\certs\tuiTestCert.pfx"
Certutil.exe -importPFX -f -p "uUbhHHvcXiyw" "%~dp0..\..\..\certs\tui_CCS_EXP_08_02_2028.pfx"
Certutil.exe -importPFX -user -f -p "uUbhHHvcXiyw" "%~dp0..\..\..\certs\tui_CCS_EXP_08_02_2028.pfx"
