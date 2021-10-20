const dbconn = require('../dbconn');
const conn = dbconn();
module.exports = {
	clienteGet: (req, res) => {
		res.render('cliente', req.session.data);
	},
};
