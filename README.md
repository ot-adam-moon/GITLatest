GITLatest
=========

Using Node.js async to Run in Parallel All Necessary GIT/System Bootstrap Commands to Setup Local Box for Development.

Motivation
==========
  *  I want to setup a box for development from scratch with one script
  *  I want to <code>git pull upstream master</code> or <code>git pull rebase</code> without having 5 Powershell or GIT Bash windows open.
  *  I want the command to run against all necessary projects in parallel
  *  I want the flexibility to run cmd for one project or for all projects
  *  I want a quick way to run <code>rake bootstrap</code> for all projects in parallel
  *  I don't want to be afraid to reboot my box anymore fearing things won't work.

Setup
=====

* Install [node.js](http://nodejs.org/)
* Install [Growl for Windows](http://www.growlforwindows.com/gfw/) *Note: THIS IS OPTIONAL
* Make sure all projects are under one directory Ex: Projects\
* 'cd ProjectsFolderYouChoose'
* 'git clone git@github.com:ot-adam-moon/GITLatest.git'
* 'npm install .'
* `grunt`  *NOTE: this will run `git status` for all projects

How do I control the project list?
==================================

* Open gruntfile.coffee
* 2nd line <code>projects = [...]</code>
* edit array to control the Project List


Build Projects from Scratch
===========================

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

What if I only want to run a command for one project?
=====================================================

add an argument to your command indicating the project you want

Ex: <code>grunt scratch:ProjectName</code>
    <code>grunt st:ProjectName</code>
 
Command List
============

| grunt         | what it does  |
| ------------- |:-------------:|
| `grunt` | `git status` |
| `grunt default` | `git status` |
| <code>grunt st</code> | `git status` |
| <code>grunt pum</code> | `git submodule update`, `git pull upstream master` |
| <code>grunt clone</code> | `git clone` |
| <code>grunt clean</code> | `git clean` |
| <code>grunt com</code> | `git checkout master` |
| <code>grunt su</code> | `git submodule update` |
| <code>grunt rh</code> | `git reset head --hard` |
| <code>grunt rmf</code> | `run-me-first.bat` |
| <code>grunt rboot</code> | `rake bootstrap` |
| <code>grunt rsql</code> | `rake sql` |
| <code>grunt db</code> | `rebuild-db.bat` |
| <code>grunt web</code> | `webutil.bat all` |
| <code>grunt webstop</code> | `webutil.bat stop` |
| <code>grunt svc</code> | `svcutil.bat start` |
| <code>grunt svcu</code> | `svcutil.bat u` |
| <code>grunt svc</code> | `svcutil.bat i` |
| <code>grunt up</code> | `webutil.bat all`, `svcutil.bat start` |
| <code>grunt sanity</code> | `git submodule update`, `git pull upstream master`, `run-me-first.bat` |
| `grunt scratch` | `webutil.bat stop`, `svcutil.bat u`, `RD "%project%" /S /Q`, `git clone, run-me-first.bat` |



