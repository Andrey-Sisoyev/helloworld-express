moment = require 'moment'

exports.formatDate = (date, format) ->
    format ?= 'MM-DD-YYYY HH:mm:ss'
    return moment(date).format format  

exports.toStringTol = (x) ->
    if x?
         return '' + x
    else return 'undefined'

exports.setTimeout_ = (to, cb) ->
	setTimeout cb, to
    
exports.setTimeout0 = (cb) ->
	setTimeout cb, 0

exports.getRandomInt = (min, max) ->
	return Math.floor (Math.random() * (max - min + 1)) + min;

	
     