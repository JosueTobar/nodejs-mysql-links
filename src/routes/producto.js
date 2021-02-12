const express = require('express');
const router = express.Router();
const pool = require('../database');

const { isLoggedIn } = require('../lib/auth');

//Select menu 
router.get('/producto_list', async (req, res) => {
    const producto = await pool.query('SELECT * FROM inventario.menu;');
    res.render('producto/list', { producto });
});
//
router.get('/producto_add',  (req, res) => {
    res.render('producto/add');
});

router.get('/producto_edit', (req, res) => {
    res.render('producto/edit');
});

module.exports = router;