const express = require('express');
const router = express.Router();
const pool = require('../database');

const { isLoggedIn } = require('../lib/auth');

//Select menu 
router.get('/menu_list', async (req, res) => {
    const menu = await pool.query('SELECT * FROM inventario.menu;');
    res.res.json(menu);
});

module.exports = router;