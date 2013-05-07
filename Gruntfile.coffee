module.exports = (grunt) ->
  projects = ['ProductFulfillment','EnterpriseServices','WebClients','CustomerFiltering','SpendOnLife','OneTechnologies.Framework']
  async = require("async")
  spawn = require('child_process').spawn
  growl = require('growl')


  # Configure Grunt
  grunt.initConfig

# Make task shortcuts
  grunt.registerTask 'scratch', ['webstop','svcu','del','clone','rmf']
  grunt.registerTask 'default', ['st']
  grunt.registerTask 'sanity', ['pum','su','st','rmf']
  grunt.registerTask 'up', ['web','svc']

  grunt.registerTask 'db', 'REBUILD-DB', (project) ->
    run 'REBUILD_DB.cmd', project, this.async()
  grunt.registerTask 'certs', 'INSTALL CERTIFICATES', (project) ->
    run 'INSTALL_CERTS.cmd', project, this.async()
  grunt.registerTask 'svcu','Services Uninstall', (project) ->
    run 'SVC_UNINSTALL.cmd', project, this.async()
  grunt.registerTask 'svci', 'Services Install', (project) ->
    run 'SVC_INSTALL.cmd', project, this.async()
  grunt.registerTask 'web', (project) ->
    run 'WEBUTIL.cmd ', project, this.async()
  grunt.registerTask 'webstop', (project) ->
    run 'WEBUTIL_STOP.cmd ', project, this.async()
  grunt.registerTask 'del', (project) ->
    run 'DELETE_ALL.cmd ', project, this.async()
  grunt.registerTask 'svc', (project) ->
    run 'SVCUTIL.cmd', project, this.async()
  grunt.registerTask 'com', (project) ->
    run 'GIT_CHECKOUT_MASTER.cmd', project, this.async()
  grunt.registerTask 'clone', 'GIT CLONE', (project) ->
    run 'GIT_CLONE.cmd', project, this.async()
  grunt.registerTask 'cob', (project, branch) ->
    run 'GIT_CHECKOUT_BRANCH.cmd', project, this.async(), branch
  grunt.registerTask 'pum', (project) ->
    run 'GIT_PULL_UPSTREAM_MASTER.cmd', project, this.async()
  grunt.registerTask 'st', (project) ->
    run 'GIT_STATUS.cmd ', project, this.async()
  grunt.registerTask 'su', (project) ->
    run 'GIT_SUBMODULE_UPDATE.cmd', project, this.async()
  grunt.registerTask 'rh', (project) ->
    run 'GIT_RESET_HARD.cmd', project, this.async()
  grunt.registerTask 'rmf', (project) ->
    run 'RUN_ME_FIRST.cmd', project, this.async()
  grunt.registerTask 'rb', (project) ->
    run 'RAKE_BOOTSTRAP.cmd', project, this.async()
  grunt.registerTask 'rsql', (project) ->
    run 'RAKE_SQL.cmd', project, this.async()

  setupWork = (script, project, cb, arg2) ->
    workList = []
    i = 0
    unless typeof (project) is "undefined"
      workList.push async.apply(cmd, script, project ,cb, arg2)
    while i < projects.length
      workList.push async.apply(cmd, script, projects[i], cb, arg2)
      i++
    workList

  run = (script, project, cb, arg2) ->
    projCount = projects.length
    cnt = 0
    startTime = new Date()
    callback = (err, results) ->
              cnt = cnt + 1
              if cnt == projCount
                endTime = new Date()
                console.log script + ' COMPLETE for all projects in : ' + ((endTime-startTime)/1000).toFixed(2) + ' seconds'
                cb()
    unless typeof (project) is "undefined"
      cmd script, project, callback, arg2
    else
      workList = setupWork(script, project, callback, arg2)
      async.parallel workList,
        callback

  cmd = (script, project, callback, arg2) ->
    console.log (script + " " + project)
    args = [project]
    unless typeof (arg2) is "undefined"
      args.push arg2

    cmdProcess = spawn(script, args, () ->
    )
    cmdProcess.stdout.on "data", (data) ->
      msg = "" + data
      console.log(grunt.verbose)
      grunt.log.write msg + '\n-----------------------------------\n'

    cmdProcess.stderr.on "data", (data) ->
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
