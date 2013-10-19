moment = require 'moment'

exports.formatDate = (date, format) ->
    format ?= 'MM-DD-YYYY HH:mm:ss'
    return moment(date).format format  

exports.toStringTol = (x) ->
    if x?
         return '' + x
    else return 'undefined'
    
     