module.exports = (grunt) ->
  config = require("./projectsConfig")

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

  grunt.registerTask 'db', 'REBUILD-DB', () ->
    run 'REBUILD_DB.cmd', this.async(), config.dbProjects, true
  grunt.registerTask 'rc', 'REBUILD-CONFIG', () ->
    run 'REBUILD_CONFIG.cmd', this.async(),  config.allProjects, true
  grunt.registerTask 'certs', 'INSTALL CERTIFICATES', () ->
    run 'INSTALL_CERTS.cmd',this.async(), false
  grunt.registerTask 'svcu','Services Uninstall', () ->
    run 'SVC_UNINSTALL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'svcuninstall','Services Uninstall', () ->
    run 'SVC_UNINSTALL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'svci', 'Services Install', () ->
    run 'SVC_INSTALL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'svcinstall', 'Services Install', () ->
    run 'SVC_INSTALL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'web','WebUtil All', () ->
    run 'WEBUTIL.cmd ',this.async(), config.webProjects, false
  grunt.registerTask 'webstop', 'WebUtil Stop',() ->
    run 'WEBUTIL_STOP.cmd ',this.async(), config.webProjects, false
  grunt.registerTask 'del', () ->
    run 'DELETE_ALL.cmd ',this.async(), config.allProjects, true
  grunt.registerTask 'svc', 'SvcUtil Start', () ->
    run 'SVCUTIL.cmd',this.async(), config.svcProjects, false
  grunt.registerTask 'com', 'GIT CHECKOUT MASTER', () ->
    run 'GIT_CHECKOUT_MASTER.cmd',this.async(), true
  grunt.registerTask 'clone', 'GIT CLONE', () ->
    run 'GIT_CLONE.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'cob', 'GIT CHECKOUT --br [branchname]', () ->
    run 'GIT_CHECKOUT_BRANCH.cmd',this.async()
  grunt.registerTask 'ctb', 'GIT FETCH,GIT CHECKOUT -t [branchname]', () ->
    run 'GIT_CREATE_TRACKING_BRANCH.cmd',this.async()
  grunt.registerTask 'pum', 'GIT PULL UPSTREAM MASTER',() ->
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async(), config.allProjects
  grunt.registerTask 'pum', 'GIT PULL UPSTREAM MASTER',() ->
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pom', 'GIT PULL ORIGIN MASTER',() ->
    run 'GIT_PULL_ORIGIN_MASTER.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pub', 'GIT PULL UPSTREAM [BRANCH]',() ->
    run 'GIT_PULL_UPSTREAM_BRANCH.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pull', 'GIT PULL', () ->
    run 'GIT_PULL.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'pr', 'GIT PULL REBASE', () ->
    run 'GIT_PULL_REBASE.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'st', 'GIT STATUS', () ->
    run 'GIT_STATUS.cmd ',this.async(), config.allProjects, true
  grunt.registerTask 'su', 'GIT SUBMODULE UPDATE',() ->
    run 'GIT_SUBMODULE_UPDATE.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'rh', 'GIT RESET HEAD --HARD', () ->
    run 'GIT_RESET_HARD.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'resethard', 'GIT RESET HEAD --HARD', () ->
    run 'GIT_RESET_HARD.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'rmf', 'RUN_ME_FIRST.BAT',() ->
    run 'RUN_ME_FIRST.cmd',this.async(), config.parallelProjects, false
  grunt.registerTask 'rb', 'RAKE BOOTSTRAP',() ->
    run 'RAKE_BOOTSTRAP.cmd',this.async(), config.parallelProjects, false
  grunt.registerTask 'rakebootstrap', 'RAKE BOOTSTRAP',() ->
    run 'RAKE_BOOTSTRAP.cmd',this.async(), config.allProjects, true
  grunt.registerTask 'gui', 'GIT GUI',() ->
    run 'GIT_GUI.cmd',this.async(), config.allProjects
  grunt.registerTask 'rsql', 'RAKE SQL', () ->
    run 'RAKE_SQL.cmd',this.async(), config.parallelProjects, true
  grunt.registerTask 'rakesql', 'RAKE SQL', () ->
    run 'RAKE_SQL.cmd',this.async(), config.parallelProjects, true
  grunt.registerTask 'stash', 'RAKE SQL', () ->
    run 'GIT_STASH.cmd',this.async(), config.parallelProjects, true
  grunt.registerTask 'stashpop', 'RAKE SQL', () ->
    run 'GIT_STASH_POP.cmd',this.async(), config.parallelProjects, true
  grunt.registerTask 'pf', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for ProductFulfillment", () ->
    proj = 'ProductFulfillment'
    grunt.task.run('rb')

  # Make task shortcuts
  grunt.registerTask 'fromscratch', ['webstop','svcu','del','clone','rmf','pf','certs']
  grunt.registerTask 'default', ['pum']
  grunt.registerTask 'update', ['pum','rmf','pf','certs']
  grunt.registerTask 'up', ['web','svc']

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
      console.log (script + " " + project + " " + branch)
    else
      console.log (script + " " + project)
    args = [project]
    unless typeof (branch) is "undefined"
      args.push branch

    cmdProcess = spawn script, args, {detached: detached}

    cmdProcess.proj = project

    cmdProcess.stdout.on "data", (data) ->
      console.log data + '\n-----------------------------------\n'

    cmdProcess.stderr.on "error", (error) ->
      console.log '\n' + error + '\n-----------------------------------\n'

    cmdProcess.stderr.on 'data', (data) ->
      console.log('\n' + data + '\n-----------------------------------\n')

    cmdProcess.stdin.on "data", (chunk) ->
      cmdProcess.stdout.write "\ndata: " + chunk

    cmdProcess.on "exit", (code) ->
      msg = '\n' + this.proj + " " + script + " " + 'COMPLETED\n-----------------------------------\n'
      grunt.log.write msg
      growlMsg(msg)
      callback(null, "")

  growlMsg = (msg) ->
    unless typeof (growl) is "undefined"
      growl msg,
        title: "GITLatest STATUS UPDATE",
        priority: 1
