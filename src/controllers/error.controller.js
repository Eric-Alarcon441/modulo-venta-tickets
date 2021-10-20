module.exports = {
	serverError: (err, req, res, next) => {
		res.status(401).render('error', { regist: null });
	},
};
