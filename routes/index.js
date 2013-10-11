
/*
 * GET home page.
 */

exports.index = function(req, res){
  console.log('index: %j', req.body);  
  // debugger;
  console.log('index sess: %j', req.session);  
  var failedLogin = req.session.hasOwnProperty('failedLogin') && req.session.failedLogin === true;
  delete req.session.failedLogin;
  res.render('index', { title: 'Express', failedLogin: failedLogin });
};