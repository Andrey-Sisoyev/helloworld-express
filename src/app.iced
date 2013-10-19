assert = require 'assert'

projHome = process.env.HOME_SRC_HWE
assert.ok typeof projHome == 'string' && projHome.length > 0

asyncTrials = require './async-trials'
asyncTrials.run()


express = require 'express'  
http    = require 'http'  
path    = require 'path'  
rack    = require 'asset-rack'  
fs      = require 'fs'  
prettyjson = require 'prettyjson'

{index} = require projHome + '/build/routes/index'  
utils   = require projHome + '/build/lib/utils'  
user    = require projHome + '/build/routes/user'  
misc    = require projHome + '/build/routes/misc'  
files   = require projHome + '/build/routes/files'  

assets = new rack.AssetRack [
    new rack.JadeAsset
        url: '/templates.js'
        dirname: projHome + '/views/tpl'
    
    new rack.DynamicAssets
        type: rack.LessAsset
        urlPrefix: '/stylesheets'
        dirname: projHome + '/public/stylesheets'
        options: paths: ['/public/stylesheets/']
      
    new rack.StaticAssets  
        dirname: projHome + '/public/images'
        urlPrefix: '/images'
] 

assets.on 'complete', ->
  
    app = express()

    # all environments
    app.set 'port', process.env.PORT || 3000
    app.set 'views', projHome + '/views'  
    app.set 'view engine', 'jade'  

    app.use express.favicon()  
    app.use express.logger 'dev'
    app.use express.cookieParser()
    app.use express.session secret: '1234567890QWERTY'
    app.use express.bodyParser()
    app.use express.methodOverride()  
    app.use assets  
    app.use app.router  
    
    # app.use express.static path.join __dirname, 'public'    

    app.locals.utils = utils 


    # development only
    if 'development' == app.get 'env'    
      app.use express.errorHandler()  
     

    app.get '/', index  
    app.get '/users', user.list  
    app.post '/login', user.login  
    app.get '/login/success', user.login.success  
    app.get '/login/failure', user.login.failure  
    app.get '/serv-time', misc.serveTime  
    files.register app
    

    http.createServer(app).listen app.get('port'), -> 
      console.log 'Express server listening on port ' + (app.get 'port')
  


