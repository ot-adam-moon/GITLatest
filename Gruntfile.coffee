module.exports = (grunt) ->
  projects = ['ProductFulfillment','EnterpriseServices','WebClients','CustomerFiltering','SpendOnLife','OneTechnologies.Framework','AffiliateManager', 'ProductCatalog']
  projectsDB = ['EnterpriseServices','WebClients','CustomerFiltering','SpendOnLife','OneTechnologies.Framework']
  projRef = { 'pf': 'ProductFulfillment', 'es' : 'EnterpriseServices' , 'wc' : 'WebClients', 'cf': 'CustomerFiltering','spl': 'SpendOnLife', 'otf':'OneTechnologies.Framework','am': 'AffiliateManager','pc': 'ProductCatalog'}
  async = require("async")
  spawn = require('child_process').spawn
  growl = require('growl')

  proj = ""
  unless typeof (projRef[grunt.option('proj')]) is "undefined"
    proj = projRef[grunt.option('proj')]
  else
    proj = grunt.option('proj')

  br = grunt.option('br')

  # Configure Grunt
  grunt.initConfig

  grunt.registerTask 'db', 'REBUILD-DB', () ->
    run 'REBUILD_DB.cmd', this.async()
  grunt.registerTask 'rc', 'REBUILD-CONFIG', () ->
    run 'REBUILD_CONFIG.cmd', this.async()
  grunt.registerTask 'certs', 'INSTALL CERTIFICATES', () ->
    run 'INSTALL_CERTS.cmd',this.async()
  grunt.registerTask 'svcu','Services Uninstall', () ->
    run 'SVC_UNINSTALL.cmd',this.async()
  grunt.registerTask 'svci', 'Services Install', () ->
    run 'SVC_INSTALL.cmd',this.async()
  grunt.registerTask 'web','WebUtil All', () ->
    run 'WEBUTIL.cmd ',this.async()
  grunt.registerTask 'webstop', 'WebUtil Stop',() ->
    run 'WEBUTIL_STOP.cmd ',this.async()
  grunt.registerTask 'del', () ->
    run 'DELETE_ALL.cmd ',this.async()
  grunt.registerTask 'svc', 'SvcUtil Start', () ->
    run 'SVCUTIL.cmd',this.async()
  grunt.registerTask 'com', 'GIT CHECKOUT MASTER', () ->
    run 'GIT_CHECKOUT_MASTER.cmd',this.async()
  grunt.registerTask 'clone', 'GIT CLONE', () ->
    run 'GIT_CLONE.cmd',this.async()
  grunt.registerTask 'cob', 'GIT CHECKOUT --br [branchname]', () ->
    run 'GIT_CHECKOUT_BRANCH.cmd',this.async()
  grunt.registerTask 'ctb', 'GIT FETCH,GIT CHECKOUT -t [branchname]', () ->
    run 'GIT_CREATE_TRACKING_BRANCH.cmd',this.async()
  grunt.registerTask 'pum', 'GIT PULL UPSTREAM MASTER',() ->
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async()
  grunt.registerTask 'pom', 'GIT PULL ORIGIN MASTER',() ->
     run 'GIT_PULL_ORIGIN_MASTER.cmd',this.async()
  grunt.registerTask 'pub', 'GIT PULL UPSTREAM [BRANCH]',() ->
    run 'GIT_PULL_UPSTREAM_BRANCH.cmd',this.async()
  grunt.registerTask 'pull', 'GIT PULL', () ->
     run 'GIT_PULL.cmd',this.async()
  grunt.registerTask 'pr', 'GIT PULL REBASE', () ->
    run 'GIT_PULL_REBASE.cmd',this.async()
  grunt.registerTask 'st', 'GIT STATUS', () ->
    run 'GIT_STATUS.cmd ',this.async()
  grunt.registerTask 'su', 'GIT SUBMODULE UPDATE',() ->
    run 'GIT_SUBMODULE_UPDATE.cmd',this.async()
  grunt.registerTask 'rh', 'GIT RESET HEAD --HARD', () ->
    run 'GIT_RESET_HARD.cmd',this.async()
  grunt.registerTask 'rmf', 'RUN_ME_FIRST.BAT',() ->
    run 'RUN_ME_FIRST.cmd',this.async()
  grunt.registerTask 'rb', 'RAKE BOOTSTRAP',() ->
    run 'RAKE_BOOTSTRAP.cmd',this.async()
  grunt.registerTask 'gui', 'GIT GUI',() ->
    run 'GIT_GUI.cmd',this.async()
  grunt.registerTask 'rsql', 'RAKE SQL', () ->
    run 'RAKE_SQL.cmd',this.async()
  grunt.registerTask 'stash', 'RAKE SQL', () ->
    run 'GIT_STASH.cmd',this.async()
  grunt.registerTask 'stashpop', 'RAKE SQL', () ->
    run 'GIT_STASH_POP.cmd',this.async()
  grunt.registerTask 'pf', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for ProductFulfillment", () ->
    proj = 'ProductFulfillment'
    grunt.task.run('r')
  grunt.registerTask 'es', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for EnterpriseServices", () ->
    proj = 'EnterpriseServices'
    grunt.task.run('r')
  grunt.registerTask 'spl', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for SpendOnLife", () ->
    proj = 'SpendOnLife'
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async()
    run 'GIT_PULL_REBASE.cmd',this.async()
    run 'RUN_ME_FIRST.cmd',this.async()
  grunt.registerTask 'wc', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for WebClients", () ->
    proj = 'WebClients'
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async()
    run 'GIT_PULL_REBASE.cmd',this.async()
    run 'RUN_ME_FIRST.cmd',this.async()
  grunt.registerTask 'cf', "GIT PULL UPSTREAM MASTER, GIT PULL --REBASE, RUN ME FIRST for CustomerFilitering", () ->
    proj = 'CreditFulfillment'
    run 'GIT_PULL_UPSTREAM_MASTER.cmd',this.async()
    run 'GIT_PULL_REBASE.cmd',this.async()
    run 'RUN_ME_FIRST.cmd',this.async()

  # Make task shortcuts
  grunt.registerTask 'scratch', ['webstop','svcu','del','clone','rmf','pf']
  grunt.registerTask 'default', ['pum']
  grunt.registerTask 'fr', ['pum','pr','rmf','pf']
  grunt.registerTask 'r', ['stash','pum','pr','rmf','stashpop']
  grunt.registerTask 'up', ['web','svc']

  setupWork = (script, cb, branch) ->
    workList = []
    i = 0
    unless script is "RUN_ME_FIRST.cmd" or script is "REBUILD_DB.cmd"
      while i < projects.length
        workList.push async.apply(cmd, script, projects[i], cb, branch)
        i++
    else
      while i < projectsDB.length
        workList.push async.apply(cmd, script, projectsDB[i], cb, branch)
        i++
    workList

  run = (script, cb) ->
    projCount = projects.length
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
      workList = setupWork(script, callback)
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

    cmdProcess = spawn(script, args, () ->
    )
    cmdProcess.stdout.on "data", (data) ->
      msg = "" + data
      grunt.log.write msg + '\n-----------------------------------\n'

    cmdProcess.stderr.on "error", (data) ->
      msg = "" + data
      grunt.log.write msg

    cmdProcess.on "exit", (code) ->
      msg = script + " "
      msg = msg.replace(/\_/g, ' ').replace(/\.cmd/, '').toLowerCase() + project + ' COMPLETED\n-----------------------------------\n'
      grunt.log.write msg
      growlMsg(msg)
      callback(null, "")

  growlMsg = (msg) ->
    unless typeof (growl) is "undefined"
      growl msg,
        title: "GITLatest STATUS UPDATE",
        priority: 1
