const express = require('express');
const router = express.Router();
//controllers
const { jefeGet } = require('../controllers/jefe.controller');

//rutas
router.get('/jefe', jefeGet);

module.exports = router;
