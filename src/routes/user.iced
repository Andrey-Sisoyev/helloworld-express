# user logics
files  = require process.env.HOME_SRC_HWE + '/build/routes/files'
# {iced} = require 'iced-coffee-script'

exports.list = (req, res) ->
  res.send "respond with a resource"  

exports.login = (req, res) ->
  user = req.body.user 
  pass = req.body.pass 
  console.log 'login: %j', req.body  
  
  if user.length == pass.length + 1
    req.session.user = user
    req.session.authed = new Date()
    res.redirect '/login/success'  
  else  
    res.redirect '/login/failure'  
  
exports.login.success = (req, res) ->
  console.log 'success: %j', req.body 
  viewLocals = 
    user:   req.session.user 
    authed: req.session.authed 
  await files.extendViewLocals viewLocals, defer viewLocals  
  console.log 'Locals: %j', viewLocals
  res.render 'welcome-authed', viewLocals 

exports.login.failure = (req, res) ->
  req.session.failedLogin = true   
  res.redirect '/'  
