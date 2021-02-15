const express = require('express');
const router = express.Router();
const pool = require('../database');
const Jimp = require('jimp');


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

router.post('/producto_add', async (req, res) => {
    const filepath = req.file.filename;
    const image = await Jimp.read(req.file.path)
    image.resize(50, 50) 
    await image.writeAsync(`uploads/${filepath}`)
    res.json({
        data: `![](http://localhost:4000/uploads/${filepath})`
    })
});
module.exports = router;