var app = require('./app');
var http = require('http');
var nconf = require('nconf');
var port = process.env.PORT || nconf.get('port') || 8000;

app.set('port', port);

var server = http.createServer(app);
server.listen(port);
