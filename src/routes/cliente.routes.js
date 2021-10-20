const express = require('express');
const router = express.Router();
//controllers
const { clienteGet } = require('../controllers/cliente.controller');
//rutas
router.get('/cliente', clienteGet);

module.exports = router;
