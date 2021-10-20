const express = require('express');
const session = require('express-session');
const morgan = require('morgan');
const app = express();
const port = process.env.PORT || 3000;
const path = require('path');
//controller
const { serverError } = require('./controllers/error.controller');
//configuraciones
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
//middlewares
app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(
	session({
		secret: 'mySecret',
		resave: false,
		saveUninitialized: true,
	})
);
//rutas
app.use(require('./routes/login.routes'));
app.use(require('./routes/cliente.routes'));
app.use(require('./routes/jefe.routes'));
//app.use(serverError);
//ruta default
app.get('*', (req, res) => res.redirect('/'));
//listen
app.listen(port, () => console.log(`listening on http://localhost:${port}`));
