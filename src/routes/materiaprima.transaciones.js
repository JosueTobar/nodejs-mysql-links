//materiaprima_transaccion

const express = require('express');
const router = express.Router();
const pool = require('../database');
const Jimp = require('jimp');
const { isLoggedIn } = require('../lib/auth');

router.get('/materiaprima_transaccion', (req, res) => {
    res.render('materiaprima/transaccion');
});


module.exports = router;