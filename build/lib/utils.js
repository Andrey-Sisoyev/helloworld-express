// Generated by IcedCoffeeScript 1.6.3-g
(function() {
  var moment;



  moment = require('moment');

  exports.formatDate = function(date, format) {
    if (format == null) {
      format = 'MM-DD-YYYY HH:mm:ss';
    }
    return moment(date).format(format);
  };

  exports.toStringTol = function(x) {
    if (x != null) {
      return '' + x;
    } else {
      return 'undefined';
    }
  };

}).call(this);