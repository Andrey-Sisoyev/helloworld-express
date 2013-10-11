var utils = require('../lib/utils');

exports.serveTime = function(req, res){
  res.end(utils.formatDate(new Date()));
};