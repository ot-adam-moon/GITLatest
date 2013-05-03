GITLatest
=========

Using Node.js async to Run in Parallel All Necessary GIT/System Bootstrap Commands to Setup Local Box for Development.

Motivation
==========
  *  I want to <code>git pull upstream master</code> or <code>git pull rebase</code> without having 5 Powershell or GIT Bash windows open.
  *  I want the command to run against all necessary projects in parallel
  *  I want the flexibility to run cmd for one project or for all projects
  *  I want a quick way to run <code>rake bootstrap</code> for all projects
  *  I don't have to be afraid to reboot my box anymore fearing things won't work.

SETUP
=====

* Install [node.js](http://nodejs.org/)
* Install [Growl for Windows](http://www.growlforwindows.com/gfw/) *Note: THIS IS OPTIONAL
* Make sure all projects are under one directory Ex: Projects\
* <code>cd Projects</code
* <code>git clone git@github.com:ot-adam-moon/GITLatest.git</code>
* run <code>npm install .</code>


