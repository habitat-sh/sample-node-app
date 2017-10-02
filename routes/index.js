var express = require('express');
var router = express.Router();

const nconf_file = process.env.APP_CONFIG || './default_config.json';

var nconf = require('nconf');
//nconf.file({ file: process.env.APP_CONFIG });

nconf.file({ file: nconf_file });

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', {
    title: nconf.get('message'),
    title_tag: nconf.get('title_tag')
  });
});

module.exports = router;
