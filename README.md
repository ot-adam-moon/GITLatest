GITLatest
=========

Using Node.js async to Run in Parallel All Necessary GIT/System Bootstrap Commands to Setup & Maintain Local Box for Development.

Motivation
==========
  *  setup a box for development from scratch with one script
  *  <code>git pull upstream master</code> or <code>git pull rebase</code> without having 5 Powershell or GIT Bash windows open.
  *  command to run against all necessary projects in parallel
  *  flexibility to run cmd for one project or for all projects
  *  a quick way to run <code>rake bootstrap</code> for all projects in parallel
  *  don't want to be afraid to reboot my box anymore fearing things won't work.

Setup
=====

* Install [node.js](http://nodejs.org/)
* Install [Growl for Windows](http://www.growlforwindows.com/gfw/) *Note: THIS IS OPTIONAL
* Make sure all projects are under one directory Ex: Projects\
* `cd ProjectsFolderYouChoose`
* `git clone git@github.com:ot-adam-moon/GITLatest.git`
* `npm install .`
* `grunt`  *NOTE: this will run `git status` for all projects

How do I control the project list?
----------------------------------

* Open gruntfile.coffee
* 2nd line <code>projects = [...]</code>
* edit array to control the Project List

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

Build Projects from Scratch
---------------------------

* create a new directory where you want all projects to be under
* <code>cd directoryYouChose</code>
* <code>grunt scratch</code>
<br/>
What does this do?
 * stops all current webs running
 * uninstall all services installed for the projects listed
 * delete all folders that match each project name
 * <code>git clone</code> for all projects
 * runs run_me_first.bat for each project

 
Command List
------------

| grunt command | what it does  |
| ------------- |:-------------:|
| `grunt` | `git submodule update, git pull upstream master` |
| `grunt default` | `git pull upstream master` |
| `grunt st` | `git status` |
| `grunt gui` | `git gui` |
| `grunt pum` | `git submodule update`, `git pull upstream master` |
| `grunt pom` | `git submodule update`, `git pull origin master` |
| `grunt pom` | `git submodule update`, `git pull origin master` |
| `grunt pub --br {branchname}` | `git submodule update`, `git pull upstream master`,`git pull upstream {branchname}`
| `grunt pr` | `git submodule update`, `git pull rebase` |
| `grunt clone` | `git clone` |
| `grunt clean` | `git clean -f` |
| `grunt com` | `git checkout master` |
| `grunt cob --br {branchname}` | `git checkout --br [branchname]` |
| `grunt ctb --br {branchname}` | `git fetch, git checkout -t {branchname}` |
| `grunt su` | `git submodule update` |
| `grunt stash` | `git stash` |
| `grunt stashp` | `git stash pop` |
| `grunt rh` | `git reset head --hard` |
| `grunt rmf` | `run-me-first.bat` |
| `grunt rb` | `rake bootstrap` |
| `grunt rsql` | `rake sql` |
| `grunt db` | `rebuild-db.bat` |
| `grunt rc` | `rebuild-config.bat` |
| `grunt web` | `webutil.bat all` |
| `grunt webstop` | `webutil.bat stop` |
| `grunt svc` | `svcutil.bat start` |
| `grunt svcu` | `svcutil.bat u` |
| `grunt svci` | `svcutil.bat i` |
| `grunt up` | `webutil.bat all`, `svcutil.bat start` |
| `grunt sanity` | `git submodule update`, `git pull upstream master`, `run-me-first.bat` |
| `grunt certs` | `installs necessary certs with INSTALL_CERTS.cmd` |
| `grunt scratch` | `webutil.bat stop`, `svcutil.bat u`, `RD "%project%" /S /Q`, `git clone, run-me-first.bat` |
