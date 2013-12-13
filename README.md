OT Development Environment Setup
============================

* Create root projects directory. Example c:\projects\
* Provided is a OT-Setup.zip file
* unzip OT-Setup files in {Projects Directory}
      

git setup
---------
* [Setup Git] (https://help.github.com/articles/set-up-git)
* [Generate SSH Keys for git] https://help.github.com/articles/generating-ssh-keys

Install Nodejs
--------------
* Install [node.js](http://nodejs.org/) or copy install file from nodejs folder in OT-Setup folder

Install Ruby
------------
[Ruby for Windows](http://rubyinstaller.org/) or copy install file from ruby folder in OT-Setup folder

* During the installer select the checkbox to add bin directory to PATH Environment Variable
* After installing Ruby make sure to reopen powershell window because PATH Environment change

REBOOT BOX AT THIS POINT
------------------------

Install Console2
----------------

[Console2 download] (http://sourceforge.net/projects/console/files/)

* Copy Console2 folder from OT-Setup folder to c:\Program Files\
* Open Console2.exe as Administrator
* Click Edit > Settings ... in Menu
* Make sure under the tab settings you have a tab created for powershell.exe and gitbash

Powershell
-----------------------------
   NOTE: If you edit the PATH Environment Variable in the task below, you will need to restart 

* Open 
* Run `Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Confirm`

Install posh-git
----------------
* from `posh-git` folder in `OT-Setup` run `install.ps1` 

Initial Pre Setup
-------------
* Inside {ProjectsRoot} Directory create a directory called `certs`
* Copy`certs` directory from OT-Setup folder
* Copy `SpendOnLife-v15.bak` and `Tracking-v2.bak` to `C:\Program Files\Microsoft SQL Server\MSSQL{NUMBER}.MSSQLSERVER\MSSQL\Backup`


GITLatest
-------------
* `cd ProjectsRootDirectoryYouChose`
* Run `git clone git@github.com:ot-adam-moon/GITLatest.git`
* `npm install`

Starting from scratch
---------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt clone` | clone all necessary repositories from GitHub into {Projects Directory} |
| `grunt runmefirst` | will run run-me-first.bat for all projects |
| `grunt up` | will make sure all webs and Windows services are started, run `grunt webstart` and `grunt svcstart`|
| `grunt certs` | will install all necessary certs for development needs |
   
Have all the code but want to make sure you are running latest code
-------------------------------------------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt update` | pulls latest from master for each repository, refreshes services, webs, and database, reinstalls certificates |

You just want to pull latest code
---------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt pullmaster` | will run `git submodule update`, `git pull upstream master` for each project |

You rebooted you box and you want to start everything up
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
spl - SpendOnLife
pf  - ProductFulfillment
es  - EnterpriseServices
ot  - OneTechnologies.Framework
cf  - CustomerFiltering


SpendOnLife
-----------

Steps to take for new Marketing Project

* open Powershell tab inside `Console2`, `cd` to `GITLatest` directory `Use for getting updated code for all projects, manages starting and stopping webs and windows services`
* open `git bash` tab in `Console2 `, `cd` to `SpendOnLife` directory `Use for all git commands for SpendOnLife`


 



