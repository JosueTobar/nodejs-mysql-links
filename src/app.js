const express = require('express');
const morgan = require('morgan');
const multer = require('multer');             // *Subir imagenes 
const { v4: uuidv4 } = require('uuid');       // *Generar ids unicos 
const path = require('path');
const exphbs = require('express-handlebars');
const session = require('express-session');
const passport = require('passport');
const flash = require('connect-flash');
const MySQLStore = require('express-mysql-session')(session);
const bodyParser = require('body-parser');
const corss = require('corss');                // *Acceder a la api desde cualquier lugar

const { database, port } = require('./config');

// Intializations
const app = express();
require('./lib/passport');

// Settings
app.set('port', port);
app.set('views', path.join(__dirname, 'views'));
app.use(corss()); 
app.use(express.json());
app.engine('.hbs', exphbs({
  defaultLayout: 'main',
  layoutsDir: path.join(app.get('views'), 'layouts'),
  partialsDir: path.join(app.get('views'), 'partials'),
  extname: '.hbs',
  helpers: require('./lib/handlebars')
}))
app.set('view engine', '.hbs');

// Middlewares
app.use(morgan('dev'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(session({
  secret: uuidv4(),
  resave: false,
  saveUninitialized: false,
  store: new MySQLStore(database)
}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());

const storage = multer.diskStorage({
  destination: path.join(__dirname, 'public/uploads'),
  filename: (req, file, cb) => {
    cb(null, uuidv4() + path.extname(file.originalname).toLocaleLowerCase());
  }
});

app.use(multer({
  storage: storage,
  dest: path.join(__dirname, 'public/uploads'),
}).single('img'));

// Global variables
app.use((req, res, next) => {
  app.locals.message = req.flash('message');
  app.locals.success = req.flash('success');
  app.locals.user = req.user;
  next();
});

// Routes
app.use(require('./routes/index.routes'));
app.use(require('./routes/auth.routes'));
app.use(require('./routes/user.routes'));
app.use(require('./routes/menu.routes'));
app.use('/links', require('./routes/links.routes'));
app.use(require('./routes/producto'));
app.use(require('./routes/usuarios'));
app.use(require('./routes/historial'));

// Public
app.use(express.static(path.join(__dirname, 'public')));
module.exports = app;