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
* <code>cd ProjectsFolderYouChoose</code>
* <code>git clone git@github.com:ot-adam-moon/GITLatest.git</code>
* <code>npm install .</code>

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

What if i only want to run a command for one project?
=====================================================

add an argument to your command indicating the project you want

Ex: grunt scratch:ProjectName
    grunt st:ProjectName
    
 
Command List
============

| grunt         | what it does  |
| ------------- |:-------------:|
| <code>grunt</code> | git status |
| <code>grunt default</code> | git status |
| <code>grunt st</code> | git status |
| zebra stripes | are neat      |



