var moment = require('moment');

exports.formatDate = function(date, format_) {
    var format = format_;
    if(format === undefined)
        format = 'MM-DD-YYYY HH:mm:ss'
    return moment(date).format(format);
}    