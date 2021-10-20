const dbconn = require('../dbconn');
const conn = dbconn();
module.exports = {
	loginGet: (req, res) => {
		req.session.data = { regist: null, msg: null };
		res.render('login', req.session.data);
	},
	loginPost: (req, res) => {
		const msg = 'usuario o contraseña incorrectos';
		const { email, password } = req.body;
		conn.query(
			'select * from usuario as u where u.email = ? and password = ?',
			[email, password],
			(err, rows) => {
				if (rows.length > 0) {
					rows[0].role == 1
						? ((req.session.data.regist = 'jefe'), res.redirect('/jefe'))
						: rows[0].role == 2
						? ((req.session.data.regist = 'cliente'), res.redirect('/cliente'))
						: null;
				} else {
					req.session.data.msg = msg;
					res.render('login', req.session.data);
				}
			}
		);
	},
};
