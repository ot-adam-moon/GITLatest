OT Development Environment Setup
============================

* Create root projects directory. Example c:\projects\

git setup
------------
* [Setup Git] (https://help.github.com/articles/set-up-git)
* [Generate SSH Keys for git] https://help.github.com/articles/generating-ssh-keys

Powershell & posh-git
-----------------------------
* Open PowerShell 2.0
* Verify execution of scripts is allowed with `Get-ExecutionPolicy` (should be `RemoteSigned` or `Unrestricted`). If scripts are not enabled, run PowerShell as Administrator and call `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm`.
* Verify that `git` can be run from PowerShell.
   If the command is not found, you will need to add a git alias or add `%ProgramFiles(x86)%\Git\cmd`
   (or `%ProgramFiles%\Git\cmd` if you're still on 32-bit) to your PATH environment variable.
* If you updated the PATH environment variable, close current Powershell window and reopen.
* Run `git clone https://github.com/dahlbyk/posh-git`
* `cd posh-git`
* Run `.\install.ps1`.

Nodejs
----------
* Install [node.js](http://nodejs.org/)

Ruby
----
[Ruby for Windows](http://rubyinstaller.org/)

* During the installer select the checkbox to add bin directory to PATH Environment Variable
* After installing Ruby make sure to reopen powershell window because PATH Environment change

Growl
--------
* Install [Growl for Windows](http://www.growlforwindows.com/gfw/) *Note: THIS IS OPTIONAL

GITLatest
-------------
* `cd ProjectsRootDirectoryYouChose`
* Run `git clone git@github.com:ot-adam-moon/GITLatest.git`
* `npm install`


   starting from scratch
   ---------------------
   
   `grunt fromscratch`
   
   
Command List
------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt` | `git submodule update, git pull upstream master` |
| `grunt fromscratch` | rebuilds all repositories from scratch and sets up each repositories services,webs, and database |
| `grunt refresh` | pulls latest from master for each repository, refreshes services, webs, and database |
| `grunt pum` | `git submodule update`, `git pull upstream master` |
| `grunt rmf` | `run-me-first.bat` |
| `grunt rb` | `rake bootstrap` |
| `grunt rakebootstrap` | `rake bootstrap` |
| `grunt rsql` | `rake sql` |
| `grunt rakesql` | `rake sql` |
| `grunt db` | `rebuild-db.bat` |
| `grunt rc` | `rebuild-config.bat` |
| `grunt web` | `webutil.bat all` |
| `grunt webstop` | `webutil.bat stop` |
| `grunt svc` | `svcutil.bat start` |
| `grunt svcu` | `svcutil.bat u` |
| `grunt svci` | `svcutil.bat i` |
| `grunt up` | `webutil.bat all`, `svcutil.bat start` |
| `grunt certs` | `installs necessary certs with INSTALL_CERTS.cmd` |
| `grunt scratch` | `webutil.bat stop`, `svcutil.bat u`, `RD "%project%" /S /Q`, `git clone, run-me-first.bat` |

   

How do I control the project list?
----------------------------------

Project lists can be configured in `projectsConfig.coffee`


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

 



