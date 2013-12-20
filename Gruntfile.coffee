module.exports = (grunt) ->
  config = require("./projectsConfig")
  gitScripts = '.\\scripts\\git\\'
  otScripts = '.\\scripts\\ot\\'
  fs = require("fs")
  async = require("async")
  spawn = require('child_process').spawn
  growl = require('growl')

  proj = ""
  unless typeof (config.projShortcuts[grunt.option('proj')]) is "undefined"
    proj = config.projShortcuts[grunt.option('proj')]
  else
    proj = grunt.option('proj')

  br = grunt.option('br')

  # Configure Grunt
  grunt.initConfig

  grunt.registerTask 'sql', 'REBUILD-DB', () ->
    run otScripts + 'REBUILD_DB.cmd', this.async(), config.dbProjects, true
  grunt.registerTask 'config', 'REBUILD-CONFIG', () ->
    run otScripts + 'REBUILD_CONFIG.cmd', this.async(),  config.allProjects, true
  grunt.registerTask 'certs', 'INSTALL CERTIFICATES', () ->
    run otScripts + 'INSTALL_CERTS.cmd',this.async(), false
  grunt.registerTask 'svcu','Services Uninstall', () ->
    run otScripts + 'SVC_UNINSTALL.cmd',this.async(), config.svcProjects, true
  grunt.registerTask 'svcuninstall','Services Uninstall', () ->
    run otScripts + 'SVC_UNINSTALL.cmd',this.async(), config.svcProjects, true
  grunt.registerTask 'svci', 'Services Install', () ->
    run otScripts + 'SVC_INSTALL.cmd',this.async(), config.svcProjects, true
  grunt.registerTask 'svcinstall', 'Services Install', () ->
    run otScripts + 'SVC_INSTALL.cmd',this.async(), config.svcProjects, true
  grunt.registerTask 'web','WebUtil All', () ->
    run otScripts + 'WEBUTIL.cmd',this.async(), config.webProjects, false
  grunt.registerTask 'webstart','WebUtil All', () ->
    run otScripts + 'WEBUTIL.cmd',this.async(), config.webProjects, false
  grunt.registerTask 'webstop', 'WebUtil Stop',() ->
    run otScripts + 'WEBUTIL_STOP.cmd',this.async(), config.webProjects, false
  grunt.registerTask 'del', () ->
    run otScripts + 'DELETE_ALL.cmd ',this.async(), config.allProjects, true
  grunt.registerTask 'svc', 'SvcUtil Start', () ->
    run otScripts + 'SVCUTIL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'svcstart', 'SvcUtil Start', () ->
    run otScripts + 'SVCUTIL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'svcstop', 'SvcUtil Stop', () ->
    run otScripts + 'SVCUTIL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'com', 'GIT CHECKOUT MASTER', () ->
    run gitScripts + 'GIT_CHECKOUT_MASTER.cmd',this.async(), true
  grunt.registerTask 'clone', 'GIT CLONE', () ->
    run gitScripts+ 'GIT_CLONE.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'cob', 'GIT CHECKOUT --br [branchname]', () ->
    run gitScripts + 'GIT_CHECKOUT_BRANCH.cmd',this.async()
  grunt.registerTask 'ctb', 'GIT FETCH,GIT CHECKOUT -t [branchname]', () ->
    run gitScripts + 'GIT_CREATE_TRACKING_BRANCH.cmd',this.async()
  grunt.registerTask 'pum', 'GIT PULL UPSTREAM MASTER',() ->
    run gitScripts + 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pullmaster', 'GIT PULL UPSTREAM MASTER',() ->
    run gitScripts + 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pom', 'GIT PULL ORIGIN MASTER',() ->
    run gitScripts + 'GIT_PULL_ORIGIN_MASTER.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pub', 'GIT PULL UPSTREAM [BRANCH]',() ->
    run gitScripts + 'GIT_PULL_UPSTREAM_BRANCH.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pull', 'GIT PULL', () ->
    run gitScripts + 'GIT_PULL.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pr', 'GIT PULL REBASE', () ->
    run gitScripts + 'GIT_PULL_REBASE.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'st', 'GIT STATUS', () ->
    run gitScripts + 'GIT_STATUS.cmd ',this.async(), config.allProjects, true
  grunt.registerTask 'su', 'GIT SUBMODULE UPDATE',() ->
    run gitScripts + 'GIT_SUBMODULE_UPDATE.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'rh', 'GIT RESET HEAD --HARD', () ->
    run gitScripts + 'GIT_RESET_HARD.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'resethard', 'GIT RESET HEAD --HARD', () ->
    run gitScripts + 'GIT_RESET_HARD.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'rmf', 'RUN_ME_FIRST.BAT',() ->
    run otScripts + 'RUN_ME_FIRST.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'runmefirst', 'RUN_ME_FIRST.BAT',() ->
    run otScripts + 'RUN_ME_FIRST.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'rb', 'RAKE BOOTSTRAP',() ->
    run otScripts + 'RAKE_BOOTSTRAP.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'rakebootstrap', 'RAKE BOOTSTRAP',() ->
    run otScripts + 'RAKE_BOOTSTRAP.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'gui', 'GIT GUI',() ->
    run gitScripts + 'GIT_GUI.cmd',this.async(), config.allProjects
  grunt.registerTask 'rsql', 'RAKE SQL', () ->
    run otScripts + 'RAKE_SQL.cmd',this.async(), config.dbProjects, true
  grunt.registerTask 'rakesql', 'RAKE SQL', () ->
    run otScripts + 'RAKE_SQL.cmd',this.async(), config.dbProjects, true
  grunt.registerTask 'pf', "RUN ME FIRST for Product Fulfilmment", () ->
    proj = 'ProductFulfillment'
    grunt.task.run('rb')
  grunt.registerTask 'otf', "RUN ME FIRST for OneTechnologies.Framework", () ->
     proj = 'Onetechnologies.Framework'
     grunt.task.run('rb')

  # Make task shortcuts
  grunt.registerTask 'fromscratch', ['webstop','svcu','del','clone','rmf','certs']
  grunt.registerTask 'default', ['pum']
  grunt.registerTask 'ot', ['ot']
  grunt.registerTask 'runmefirst', ['rmf','pf']
  grunt.registerTask 'update', ['pum','rmf','pf','certs']
  grunt.registerTask 'up', ['web','svc']
  grunt.registerTask 'stop', ['webstop','svcstop']

  setupWork = (script, cb, projList, detached) ->
    workList = []
    i = 0

    if projList
      while i < projList.length
        workList.push async.apply(cmd, script, projList[i], cb, br, detached)
        i++
    else
      workList.push async.apply(cmd, script, undefined, cb, br, detached)

    workList

  run = (script, cb, projList, detached) ->
    projCount = 0

    if projList
      projCount = projList.length

    cnt = 0
    startTime = Date.now()
    callback = (err, results) ->
              cnt = cnt + 1
              if cnt == projCount
                endTime = Date.now()
                console.log script + ' COMPLETED for all projects in : ' + ((endTime-startTime)/1000).toFixed(3).toString() + ' seconds'
                cb()
    unless typeof (proj) is "undefined"
      cmd script, proj, callback, detached
    else
      workList = setupWork(script, callback, projList, detached)
      async.parallel workList,
        callback

  cmd = (script, project, callback, branch, detached) ->
    unless typeof (branch) is "undefined"
      console.log ('\n'+script + " " + project + " " + branch)
    else
      console.log ('\n'+script + " " + project)
    args = [project]
    unless typeof (branch) is "undefined"
      args.push branch

    fs = require('fs')
    logFile = './logs/' + script.replace('.cmd','').replace('.\\scripts\\ot\\','').replace('.\\scripts\\git\\','') + '.' + project + '.log'
    errorFile = './logs/' + script.replace('.cmd','').replace('.\\scripts\\ot\\','').replace('.\\scripts\\git\\','') + '.' + project + '.log'

    console.log logFile
    out = fs.openSync(logFile, 'w')
    err = fs.openSync(errorFile, 'w')

    cmdProcess = spawn script, args, {detached: false, stdio: [ 'pipe', out, err ]}
#    cmdProcess.unref()
    cmdProcess.proj = project
    that = cmdProcess

    cmdProcess.on "exit", (code) ->
      if !that.proj
        that.proj = ''
      msg = '\n' +  that.proj + " " + script.replace(otScripts,'').replace(gitScripts,'') + ' COMPLETED\n-----------------------------------\n'
      grunt.log.write msg
      growlMsg(msg)

      callback(null, "")

  growlMsg = (msg) ->
    unless typeof (growl) is "undefined"
      growl msg,
        title: "GITLatest STATUS UPDATE",
        priority: 1
