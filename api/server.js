var express    = require('express');
var app        = express();
var bodyParser = require('body-parser');
var mongoose   = require('mongoose');
var mailer     = require('express-mailer');



mongoose.set('debug', true);

mailer.extend(app, {
  from: 'no-reply@example.com',
  host: 'smtp.gmail.com', // hostname
  secureConnection: true, // use SSL
  port: 465, // port for secure SMTP
  transportMethod: 'SMTP', // default is SMTP. Accepts anything that nodemailer accepts
  auth: {
    user: 'travelptest@gmail.com',
    pass: 'Spider123'
  }
});

app.set('views', __dirname + '/app/views');
app.set('view engine', 'jade');

app.use(function (req, res, next) {
          res.setHeader('Access-Control-Allow-Origin', '*');
          res.setHeader('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
          res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
          res.setHeader('Access-Control-Allow-Credentials', true);

          next();
      });
app.use(bodyParser.json({ extended: true }));
app.use(bodyParser.json());


mongoose.connect('mongodb://localhost:27017/ETNAsupply', function(err) {
  if (err) {
    console.log('connection error', err);
  } else {
    console.log('connection successful');
  }
});

var port = process.env.PORT || 3000;

// routes
var router = express.Router();

////////////////////////////////////////////////////////////////////////////////////////////// routes //////////////////////////////
require('./app/routes/materialRoute')(router);
require('./app/routes/userRoute')(router);
require('./app/routes/userListRoute')(router, app);
/////////////////////////////////////////////////////////////////////////////////// end of routes //////////////////////////////////////////////

// instance route

app.use('/api', router);

// start server
app.listen(port);
console.log('magic happens on port : ' + port);
