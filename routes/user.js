
/*
 * GET users listing.
 */

exports.list = function(req, res){
  res.send("respond with a resource");
};

exports.login = function(req, res){
  var user = req.body.user;
  var pass = req.body.pass;
  console.log('login: %j', req.body);  
  // debugger;
  if(user.length === pass.length + 1) {
    req.session.user = user;
    res.redirect('/login/success');
  } else {
    res.redirect('/login/failure');
  }
};

exports.login.success = function(req, res){
  var user = req.session.user;
  console.log('success: %j', req.body);  
  res.render('welcome-authed', { user: user, authed: new Date() });
};

exports.login.failure = function(req, res){
  req.session.failedLogin = true;  
  res.redirect('/');
};