// Generated by IcedCoffeeScript 1.6.3-g
(function() {
  var utils;



  utils = require(process.env.HOME_SRC_HWE + '/build/lib/utils');

  exports.serveTime = function(req, res) {
    return res.end(utils.formatDate(new Date()));
  };

}).call(this);