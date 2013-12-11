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

Install Growl
-------------
* Install [Growl for Windows](http://www.growlforwindows.com/gfw/) *Note: THIS IS OPTIONAL

REBOOT BOX AT THIS POINT
------------------------

Install Console2
----------------

[Console2 download] (http://sourceforge.net/projects/console/files/)

* Unzip download to your choice directory
* Open Console2.exe as Administrator
* Pin Console2 to TaskBar
* In Console2 window, click Edit > Settings...
* ![Add tab for Powershell][logo]

[logo]: https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 2"


Powershell & posh-git
-----------------------------
   NOTE: If you edit the PATH Environment Variable in the task below, you will need to restart 

* Open PowerShell
* Run `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`.
* Verify that `git` can be run from PowerShell.
   If the command is not found, you will need to add a git alias or add `%ProgramFiles(x86)%\Git\cmd`
   (or `%ProgramFiles%\Git\cmd` if you're still on 32-bit) to your PATH environment variable.
* If you updated the PATH environment variable, close current Powershell window and reopen.
* Run `git clone https://github.com/dahlbyk/posh-git`
* `cd posh-git`
* Run `.\install.ps1`.


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
* The Following commands will all be run from the GITLatest Directory

   * If you haven't cloned the code from github yet
     `grunt clone` - Will clone all necessary repositories from GitHub into {Projects Directory} 
        
   * 
   
Command List
------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt` | `git submodule update, git pull upstream master` |

| `grunt update` | pulls latest from master for each repository, refreshes services, webs, and database, reinstalls certificates |
| `grunt pum` | `git submodule update`, `git pull upstream master` |
| `grunt rmf` | `run-me-first.bat` |
| `grunt rb` | `rake bootstrap` |
| `grunt rakebootstrap` | `rake bootstrap` |
| `grunt rsql` | `rake sql` |
| `grunt rakesql` | `rake sql` |
| `grunt db` | `rebuild-db.bat` |
| `grunt web` | `webutil.bat all` |
| `grunt webstop` | `webutil.bat stop` |
| `grunt svc` | `svcutil.bat start` |
| `grunt svcu` | `svcutil.bat u` |
| `grunt svci` | `svcutil.bat i` |
| `grunt up` | `webutil.bat all`, `svcutil.bat start` |
| `grunt certs` | `installs necessary certs with INSTALL_CERTS.cmd` |


Run a task for all projects and current branch
----------------------------------------------

 grunt {task}

Run a task for one project and current branch
---------------------------------------------

 grunt {task} --proj {projectName}

Run a task for all projects but for custom branch
-------------------------------------------------

 grunt {task} --br ReleaseXXXXX

Run a task for one project and custom branch
--------------------------------------------

 grunt {task} --proj {projectName} --br ReleaseXXXXX


Rebooted my box and want everything started up
----------------------------------------------
* cd Projects\GITLatest
* grunt up


SpendOnLife
-----------

Steps to take for new Marketing Project

* have Powershell tab open from Console2 to `GITLatest` directory
* open second Powershell window and `cd SpendOnLife`

 



