utils = require process.env.HOME_SRC_HWE + '/build/lib/utils'

exports.serveTime = (req, res) ->
  res.end utils.formatDate new Date()   
