module.exports = (grunt) ->
  config = require("./projectsConfig")

#  projects = ['ProductFulfillment','EnterpriseServices','WebClients','CustomerFiltering','SpendOnLife','OneTechnologies.Framework','AffiliateManager', 'ProductCatalog']
#  projectsDB = ['EnterpriseServices','WebClients','CustomerFiltering','SpendOnLife','OneTechnologies.Framework']
#  projRef = { 'pf': 'ProductFulfillment', 'es' : 'EnterpriseServices' , 'wc' : 'WebClients', 'cf': 'CustomerFiltering','spl': 'SpendOnLife', 'otf':'OneTechnologies.Framework','am': 'AffiliateManager','pc': 'ProductCatalog'}
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
    run 'REBUILD_DB.cmd', this.async(), config.parallelProjects
  grunt.registerTask 'rc', 'REBUILD-CONFIG', () ->
    run 'REBUILD_CONFIG.cmd', this.async(),  config.allProjects
  grunt.registerTask 'certs', 'INSTALL CERTIFICATES', () ->
    run 'INSTALL_CERTS.cmd',this.async()
  grunt.registerTask 'svcu','Services Uninstall', () ->
    run 'SVC_UNINSTALL.cmd',this.async(), config.svcProjects
  grunt.registerTask 'svcuninstall','Services Uninstall', () ->
    run 'SVC_UNINSTALL.cmd',this.async(), config.svcProjects
  grunt.registerTask 'svci', 'Services Install', () ->
    run 'SVC_INSTALL.cmd',this.async(), config.svcProjects
  grunt.registerTask 'svcinstall', 'Services Install', () ->
    run 'SVC_INSTALL.cmd',this.async(), config.svcProjects
  grunt.registerTask 'web','WebUtil All', () ->
    run 'WEBUTIL.cmd ',this.async(), config.webProjects
  grunt.registerTask 'webstop', 'WebUtil Stop',() ->
    run 'WEBUTIL_STOP.cmd ',this.async(), config.webProjects
  grunt.registerTask 'del', () ->
    run 'DELETE_ALL.cmd ',this.async(), config.allProjects
  grunt.registerTask 'svc', 'SvcUtil Start', () ->
    run 'SVCUTIL.cmd',this.async(), config.svcProjects
  grunt.registerTask 'com', 'GIT CHECKOUT MASTER', () ->
    run 'GIT_CHECKOUT_MASTER.cmd',this.async()
  grunt.registerTask 'clone', 'GIT CLONE', () ->
    run 'GIT_CLONE.cmd',this.async(), config.allProjects
  grunt.registerTask 'cob', 'GIT CHECKOUT --br [branchname]', () ->
    run 'GIT_CHECKOUT_BRANCH.cmd',this.async()
  grunt.registerTask 'ctb', 'GIT FETCH,GIT CHECKOUT -t [branchname]', () ->
    run 'GIT_CREATE_TRACKING_BRANCH.cmd',this.async()
  grunt.registerTask 'pum', 'GIT PULL UPSTREAM MASTER',() ->
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async(), config.allProjects
  grunt.registerTask 'pum', 'GIT PULL UPSTREAM MASTER',() ->
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async(), config.allProjects
  grunt.registerTask 'pom', 'GIT PULL ORIGIN MASTER',() ->
    run 'GIT_PULL_ORIGIN_MASTER.cmd',this.async(), config.allProjects
  grunt.registerTask 'pub', 'GIT PULL UPSTREAM [BRANCH]',() ->
    run 'GIT_PULL_UPSTREAM_BRANCH.cmd',this.async(), config.allProjects
  grunt.registerTask 'pull', 'GIT PULL', () ->
    run 'GIT_PULL.cmd',this.async(), config.allProjects
  grunt.registerTask 'pr', 'GIT PULL REBASE', () ->
    run 'GIT_PULL_REBASE.cmd',this.async(), config.allProjects
  grunt.registerTask 'st', 'GIT STATUS', () ->
    run 'GIT_STATUS.cmd ',this.async(), config.allProjects
  grunt.registerTask 'su', 'GIT SUBMODULE UPDATE',() ->
    run 'GIT_SUBMODULE_UPDATE.cmd',this.async(), config.allProjects
  grunt.registerTask 'rh', 'GIT RESET HEAD --HARD', () ->
    run 'GIT_RESET_HARD.cmd',this.async(), config.allProjects
  grunt.registerTask 'resethard', 'GIT RESET HEAD --HARD', () ->
    run 'GIT_RESET_HARD.cmd',this.async(), config.allProjects
  grunt.registerTask 'rmf', 'RUN_ME_FIRST.BAT',() ->
    run 'RUN_ME_FIRST.cmd',this.async(), config.allProjects
  grunt.registerTask 'rb', 'RAKE BOOTSTRAP',() ->
    run 'RAKE_BOOTSTRAP.cmd',this.async(), config.allProjects
  grunt.registerTask 'rakebootstrap', 'RAKE BOOTSTRAP',() ->
    run 'RAKE_BOOTSTRAP.cmd',this.async(), config.allProjects
  grunt.registerTask 'gui', 'GIT GUI',() ->
    run 'GIT_GUI.cmd',this.async(), config.allProjects
  grunt.registerTask 'rsql', 'RAKE SQL', () ->
    run 'RAKE_SQL.cmd',this.async(), config.parallelProjects
  grunt.registerTask 'rakesql', 'RAKE SQL', () ->
    run 'RAKE_SQL.cmd',this.async(), config.parallelProjects
  grunt.registerTask 'stash', 'RAKE SQL', () ->
    run 'GIT_STASH.cmd',this.async(), config.parallelProjects
  grunt.registerTask 'stashpop', 'RAKE SQL', () ->
    run 'GIT_STASH_POP.cmd',this.async(), config.parallelProjects
  grunt.registerTask 'pf', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for ProductFulfillment", () ->
    proj = 'ProductFulfillment'
    grunt.task.run('r')

  # Make task shortcuts
  grunt.registerTask 'fromscratch', ['webstop','svcu','del','clone','rmf','pf']
  grunt.registerTask 'default', ['pum']
  grunt.registerTask 'up', ['web','svc']

  setupWork = (script, cb, projList) ->
    workList = []
    i = 0

    if projList
      while i < projList.length
        workList.push async.apply(cmd, script, projList[i], cb)
        i++
    else
      workList.push async.apply(cmd, script, undefined, cb)

    workList

  run = (script, cb, projList) ->
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
      cmd script, proj, callback, br
    else
      workList = setupWork(script, callback, projList)
      async.parallel workList,
        callback

  cmd = (script, project, callback, branch) ->
    unless typeof (branch) is "undefined"
      console.log (script + " " + project + " " + branch)
    else
      console.log (script + " " + project)
    args = [project]
    unless typeof (branch) is "undefined"
      args.push branch

    cmdProcess = spawn script, args, {detached: true}

    cmdProcess.stdout.on "data", (data) ->
      console.log data + '\n-----------------------------------\n'

    cmdProcess.stderr.on "error", (error) ->
      console.log error

    cmdProcess.stderr.on 'data', (data) ->
      console.log('ERROR:  ' + data + '\n-----------------------------------\n')

    cmdProcess.stdin.on "data", (chunk) ->
      cmdProcess.stdout.write "data: " + chunk

    cmdProcess.on "exit", (code) ->
      msg = script + " "
      msg = msg.replace(/\_/g, ' ').replace(/\.cmd/, '').toLowerCase() +  if project then project else '' + ' COMPLETED\n-----------------------------------\n'
      grunt.log.write msg
      growlMsg(msg)
      callback(null, "")

  growlMsg = (msg) ->
    unless typeof (growl) is "undefined"
      growl msg,
        title: "GITLatest STATUS UPDATE",
        priority: 1
