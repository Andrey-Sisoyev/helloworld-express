# Complex ICS async/defer combinations will be tried out here

fs = require 'fs'
stringify = require 'json-stringify-safe'
prettyjson = require 'prettyjson'
CircularJSON = require 'circular-json'

dbDirPath = process.env.HOME_SRC_HWE + '/db/files'

currentFile = undefined # one for all users

exports.register = (app) ->
    app.get '/file/choose-report', chooseFile

exports.extendViewLocals = (viewLocals, cb_viewLocals) ->
    if currentFile?
      await prepareFileData currentFile, defer viewLocals.currentFileData
    await getAllFileNames defer viewLocals.availFiles
    cb_viewLocals viewLocals 

chooseFile = (req, res) -> 
    currentFile = req.query.fName;
    console.log 'AJAX request chooseFile: %s', prettyjson.render JSON.parse CircularJSON.stringify req.query
    await prepareFileData req.query.fName, defer content
    res.end content

prepareFileData = (fName, cb_content) ->
    await fs.readFile dbDirPath + '/' + fName, (defer err, data)
    if err?
      cb_content ''
      # throw err # no need to kill the app if file not found
    else 
      cb_content data

getAllFileNames = (cb_files) ->
    await fs.readdir dbDirPath, (defer err, files)
    if err?
      throw err
    else 
      cb_files files

