const dbconn = require('../dbconn');
const conn = dbconn();
module.exports = {
	jefeGet: (req, res) => {
		res.render('jefe', req.session.data);
	},
};
