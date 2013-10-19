# GET home page.

exports.index = (req, res) ->
  console.log 'index: %j', req.body
  console.log 'index sess: %j', req.session
  
  if req.session.user? # logged in
    res.redirect '/login/success'  
  
  failedLogin = 
    (req.session.hasOwnProperty 'failedLogin') && 
    (req.session.failedLogin == true)
  delete req.session.failedLogin
  
  res.render 'index', {title: 'Express', failedLogin: failedLogin} # bez {} ploho chitaetsa    
