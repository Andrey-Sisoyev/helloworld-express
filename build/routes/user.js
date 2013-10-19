// Generated by IcedCoffeeScript 1.6.3-g
(function() {
  var files, iced, __iced_k, __iced_k_noop;

  iced = require('iced-coffee-script').iced;
  __iced_k = __iced_k_noop = function() {};

  files = require(process.env.HOME_SRC_HWE + '/build/routes/files');

  exports.list = function(req, res) {
    return res.send("respond with a resource");
  };

  exports.login = function(req, res) {
    var pass, user;
    user = req.body.user;
    pass = req.body.pass;
    console.log('login: %j', req.body);
    if (user.length === pass.length + 1) {
      req.session.user = user;
      req.session.authed = new Date();
      return res.redirect('/login/success');
    } else {
      return res.redirect('/login/failure');
    }
  };

  exports.login.success = function(req, res) {
    var viewLocals, ___iced_passed_deferral, __iced_deferrals, __iced_k,
      _this = this;
    __iced_k = __iced_k_noop;
    ___iced_passed_deferral = iced.findDeferral(arguments);
    console.log('success: %j', req.body);
    viewLocals = {
      user: req.session.user,
      authed: req.session.authed
    };
    (function(__iced_k) {
      __iced_deferrals = new iced.Deferrals(__iced_k, {
        parent: ___iced_passed_deferral,
        filename: "src/routes/user.iced",
        funcname: "success"
      });
      files.extendViewLocals(viewLocals, __iced_deferrals.defer({
        assign_fn: (function() {
          return function() {
            return viewLocals = arguments[0];
          };
        })(),
        lineno: 24
      }));
      __iced_deferrals._fulfill();
    })(function() {
      console.log('Locals: %j', viewLocals);
      return res.render('welcome-authed', viewLocals);
    });
  };

  exports.login.failure = function(req, res) {
    req.session.failedLogin = true;
    return res.redirect('/');
  };

}).call(this);
