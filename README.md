OT Development Environment Setup
============================

* Create root projects directory. Example c:\projects\
* Provided is an `OT-Setup.zip` file
* unzip `OT-Setup` files in {Projects Directory}
      

git setup
---------
* [Setup Git] (https://help.github.com/articles/set-up-git)
* [Generate SSH Keys for git] https://help.github.com/articles/generating-ssh-keys

Install Nodejs
--------------
* Install [node.js](http://nodejs.org/) or copy install file from `nodejs` folder in `OT-Setup` folder and execute installer

Install Ruby
------------
[Ruby for Windows](http://rubyinstaller.org/) or copy install file from `ruby` folder in `OT-Setup` folder and execute installer

* During the installer select the checkbox to add bin directory to PATH Environment Variable
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
* Run Command -> `Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Confirm`

Install posh-git
----------------
* in same `Powershell` tab in `Console2`
* `cd` to `posh-git` folder in `OT-Setup` folder
* run `.\install.ps1` 

Initial Setup
-------------
* Copy`certs` directory from OT-Setup folder and paste into {ProjectsDirectory}

Setup GITLatest
-------------
* `cd {ProjectDirectory}`
* Run `git clone git@github.com:ot-adam-moon/GITLatest.git`
* Run `npm install`

Ready to Pull Application Code and Get Started
----------------------------------------------

| do this | what it does  |
| ------------- |:-------------:|
| `grunt clone` | clone all necessary repositories from GitHub into `{Projects Directory}` |
| Copy `SpendOnLife-v15.bak` and `Tracking-v2.bak` located in `OT-Setup\DB\` to `C:\Program Files\Microsoft SQL Server\MSSQL{NUMBER}.MSSQLSERVER\MSSQL\Backup`| will be used for restoring DBs in `grunt runmefirst` step below |
| Copy `sql.build` located in `OT-Setup\` to `{ProjectsRoot}\SpendOnLife\SpendOnLife\`| will be used for restoring DBs in `grunt runmefirst` step below|
| `grunt runmefirst` | will run run-me-first.bat for all projects |
| `grunt svcstart` | will start all Windows services |
| `grunt webstart` | will start all webs you need |
| `grunt certs` | will install all necessary certs for development needs |


Setup Personal Git Remote for SpendOnLife
-----------------

* open Powershell tab inside `Console2`, `cd` to `GITLatest` directory `Use for getting updated code for all projects, manages starting and stopping webs and windows services`
* open `git bash` tab in `Console2 `, `cd` to `SpendOnLife` directory `Use for all git commands for SpendOnLife`
* login to gihub.com, go to `https://github.com/OneTechLP/SpendOnLife`, click on the Fork button, allow to finish forking
* in the git bash tab run the following git command to add a remote: `git remote add origin git@github.com:{githubUsername}/SpendOnLife.git `

Troubleshooting Errors during Enrollment Path
---------------------------------------------
* inside Powershell tab
* `cd` to `OT-Setup\SqlReportManager`
* run -> `startIISExpressWeb.bat`
* open chrome browser and go to `http://localhost:6611`



   
Want to make sure you are running latest code
---------------------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt update` | pulls latest from master for each repository, refreshes services, webs, and database, reinstalls certificates |

You just want to pull latest code
---------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt pullmaster` | will run `git submodule update`, `git pull upstream master` for each project |

You rebooted your computer and you want to start everything up
--------------------------------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt up` | `webutil.bat all`, `svcutil.bat start` for each project|



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




 



