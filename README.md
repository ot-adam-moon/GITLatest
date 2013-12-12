OT Development Environment Setup
============================

* Create root projects directory. Example c:\projects\

git setup
---------
* [Setup Git] (https://help.github.com/articles/set-up-git)
* [Generate SSH Keys for git] https://help.github.com/articles/generating-ssh-keys

Install Nodejs
--------------
* Install [node.js](http://nodejs.org/)

Install Ruby
------------
[Ruby for Windows](http://rubyinstaller.org/)

* During the installer select the checkbox to add bin directory to PATH Environment Variable
* After installing Ruby make sure to reopen powershell window because PATH Environment change

REBOOT BOX AT THIS POINT
------------------------

Install Console2
----------------

[Console2 download] (http://sourceforge.net/projects/console/files/)

* Unzip download to your choice directory
* Open Console2.exe as Administrator
* Pin Console2 to TaskBar
* 

Powershell
-----------------------------
   NOTE: If you edit the PATH Environment Variable in the task below, you will need to restart 

* Open PowerShell
* Run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`


Initial Pre Setup
-------------
* Inside {ProjectsRoot} Directory create a directory called `certs`
* Copy certificate files from certs.zip provided into `certs` directory
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
| `grunt rmf` | will run run-me-first.bat for all projects |
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
| `grunt pum` | will run `git submodule update`, `git pull upstream master` for each project |

You rebooted you box and you want to start everything up
--------------------------------------------------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt up` | `webutil.bat all`, `svcutil.bat start` for each project|





| `grunt pum` | `git submodule update`, `git pull upstream master` |
| `grunt rmf` | `run-me-first.bat` |
| `grunt rb` | `rake bootstrap` |
| `grunt rakebootstrap` | `rake bootstrap` |
| `grunt rsql` | `rake sql` |
| `grunt rakesql` | `rake sql` |
| `grunt sql` | `rebuild-db.bat` |
| `grunt webstart` | `webutil.bat all` |
| `grunt webstop` | `webutil.bat stop` |
| `grunt svcStart` | Starts up all necessary windows services |
| `grunt svcUninstall` | Uninstall all window services installed previously |
| `grunt svcInstall` | Install all necessary windows services |
| `grunt up` | starts all webs and window services necessary |
| `grunt certs` | installs necessary certificates needed |






SpendOnLife
-----------

Steps to take for new Marketing Project

* have Powershell tab open from Console2 to `GITLatest` directory
* open second Powershell window and `cd SpendOnLife`

 



