OT Development Environment Setup
============================

* Create root projects directory. Example c:\projects\
* Provided is an `OT-Setup.zip` file
* unzip `OT-Setup` files in {ProjectsRoot}
      

git setup
---------
* [Setup Git] (https://help.github.com/articles/set-up-git)
* [Generate SSH Keys for git] https://help.github.com/articles/generating-ssh-keys

Install Nodejs
--------------
* execute installer in `nodejs` folder in `OT-Setup` folder

Install Ruby
------------
* Execute installer file from `ruby` folder in `OT-Setup` folder
* During the install select the checkbox to add bin directory to PATH Environment Variable
* After installing Ruby make sure to reopen powershell window because PATH Environment change

REBOOT BOX AT THIS POINT
------------------------

Install Console2
----------------

* Copy `Console2` folder from `OT-Setup` folder to c:\Program Files\
* Open Console2.exe as Administrator
* Click Edit > Settings ... in Menu
* Add the following tabs
-------------
* `Powershell`  Shell: `%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe`
                Startup dir: `{ProjectsRoot}\GITLatest\`
* `GitBash`     Shell: `C:\Windows\SysWOW64\cmd.exe /c "C:\Program Files (x86)\Git\bin\sh.exe" --login -i`
                Startup dir: `{ProjectsRoot}\SpendOnLife\`

      
Powershell Setup with GIT
-------------------------
  

* Open Powershell Tab in Console2
* Run Command -> `Set-ExecutionPolicy Bypass -Scope CurrentUser -Confirm`

Install posh-git
----------------
* in same `Powershell` tab in `Console2`
* `cd` to `posh-git` folder in `OT-Setup` folder
* run `.\install.ps1` 
* Close `Console2` and reopen as Administrator

Initial Setup
-------------
* Copy`certs` directory from OT-Setup folder and paste into {ProjectsDirectory}

Setup GITLatest
-------------
* `cd {ProjectsRoot}`
* Run `git clone git@github.com:ot-adam-moon/GITLatest.git`
* Run `npm install`


Setup SQL Server Configuration and Permissions
---------------------------------------------
* Open `SQL Server Configuration Manager`
* Expand `SQL Server Network Configuration` in left panel
* click `Protocols for MSSQLSERVER`
* in right panel make sure that `Named Pipes` and `TCP/IP` are enabled
* click `Sql Server Services` in left panel
* for `Sql Server (MSSQLSERVER)` make sure `Log On As` is set to `LocalSystem` 
* if it is not


Ready to Pull Application Code and Get Started
----------------------------------------------

| do this | what it does  |
| ------------- |:-------------:|
| `grunt clone` | clone all necessary repositories from GitHub into `{ProjectsRoot}` |
| Copy `SpendOnLife-v15.bak` and `Tracking-v2.bak` located in `OT-Setup\DB\` to `C:\Program Files\Microsoft SQL Server\MSSQL{NUMBER}.MSSQLSERVER\MSSQL\Backup`| will be used for restoring DBs in `grunt runmefirst` step below |
| Copy `sql.build` located in `OT-Setup\` to `{ProjectsRoot}\SpendOnLife\SpendOnLife\`| will be used for restoring DBs in `grunt runmefirst` step below|
| `grunt runmefirst` | will run run-me-first.bat for all projects |
| `grunt svcinstall` | will install Windows services |
| `grunt webstart` | will start all webs |
| `grunt svcstart` | will start all Windows services |
| `grunt certs` | will install all necessary certs for development needs |

Check that all Windows Services are started
-----------------------------------------
* Open Services Window
* Check the following services are started
    * `Customer Filtering Host`
    * `Payment Service Host`
    * `Enterprise Services`
    * `One Technologies Web Api`
    * `Product Fulfillment ESB`

Setup SpendOnLife
-----------------

* login to gihub.com, go to `https://github.com/OneTechLP/SpendOnLife`, click on the Fork button, allow to finish forking
* open `gitbash` tab in `Console2`
* in the `gitbash` tab run the following git command to add a remote: 
      `git remote add origin git@github.com:{githubUsername}/SpendOnLife.git `
* Use `gitbash tab` for all git commands need to commit code for SpendOnLife Marketing Projects`

Troubleshooting Errors during Enrollment Path
---------------------------------------------
* inside Powershell tab
* `cd` to `OT-Setup\SqlReportManager`
* run -> `startIISExpressWeb.bat`
* open chrome browser and go to `http://localhost:6611`


* Use `GITLatest` Powershell tab for getting updated code for all projects, starting and stopping webs and windows services
-------

Common Scenarios for using `GITLatest`

Pull latest code and make sure latest code is running
---------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt pullmaster` | will run `git submodule update`, `git pull upstream master` for each project |
| `grunt runmefirst` | will recompile all code and rebuild databases for all projects |
| `grunt up` | will attempt to start all Windows services and webs|


Rebooted your computer and need to start everything up
--------------------------------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt up` | will attempt to start all Windows services and webs|



Full Command Reference
-----------------------
| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt pullmaster` | `git submodule update`, `git pull upstream master` for all projects |
| `grunt runmefirst` | `run-me-first.bat` |
| `grunt sql` | rebuilds Database for all projects |
| `grunt webstart` | Starts all webs|
| `grunt webstop` | Stops all webs |
| `grunt svcstart` | Starts up all necessary windows services |
| `grunt svcuninstall` | Uninstall all window services installed previously |
| `grunt svcinstall` | Install all necessary windows services |
| `grunt up` | starts all webs and window services necessary |
| `grunt certs` | installs necessary certificates needed |

To Run a Task for just one Application
--------------------------------------

Ex: 
   `grunt pullmaster --proj spl`
   `grunt pullmaster --proj pf`
   `grunt pullmaster --proj es`
   `grunt pullmaster --proj ot`
   `grunt pullmaster --proj cf`

project reference list
----------------------
      * spl - SpendOnLife
      * pf  - ProductFulfillment
      * es  - EnterpriseServices
      * ot  - OneTechnologies.Framework
      * cf  - CustomerFiltering




 



