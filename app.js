
/**
 * Module dependencies.
 */

var express = require('express');
var index = require('./routes/index');

var utils = require('./lib/utils');
var user = require('./routes/user');
var misc = require('./routes/misc');
var http = require('http');
var path = require('path');
var rack = require('asset-rack');

var assets = new rack.AssetRack([
    new rack.JadeAsset({
        url: '/templates.js'
      , dirname: __dirname + '/views/tpl'
    })
  , new rack.DynamicAssets({
        type: rack.LessAsset
      , urlPrefix: '/stylesheets'
      , dirname: './public/stylesheets'
      , options: {paths: ['/public/stylesheets/']}
    })
  , new rack.StaticAssets({
        dirname: './public/images'
      , urlPrefix: '/images'
    })
]);

assets.on('complete', function() {
  
    var app = express();

    // all environments
    app.set('port', process.env.PORT || 3000);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');

    app.use(express.favicon());
    app.use(express.logger('dev'));
    app.use(express.cookieParser());
    app.use(express.session({secret: '1234567890QWERTY'}));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(assets);
    app.use(app.router);
    
    // app.use(express.static(path.join(__dirname, 'public')));

    app.locals.utils = utils;


    // development only
    if ('development' == app.get('env')) {
      app.use(express.errorHandler());
    }

    app.get('/', index.index);
    app.get('/users', user.list);
    app.post('/login', user.login);
    app.get('/login/success', user.login.success);
    app.get('/login/failure', user.login.failure);
    app.get('/serv-time', misc.serveTime);

    http.createServer(app).listen(app.get('port'), function(){
      console.log('Express server listening on port ' + app.get('port'));
    });

  
});

