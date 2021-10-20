const express = require('express');
const router = express.Router();
//controllers
const { loginGet, loginPost } = require('../controllers/login.controller');
//rutas
router.get('/', loginGet);
router.post('/', loginPost);

module.exports = router;
