const express = require('express');
const router = express.Router();
const pool = require('../database');
const Jimp = require('jimp');


const { isLoggedIn } = require('../lib/auth');

//Select menu 
router.get('/producto_list', async (req, res) => {
    const producto = await pool.query('SELECT * FROM producto where IDUSUARIO = ?;',[req.user.idUSUARIO]);
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
    const { codigo, nombre, descripcion, tipounidad,minimo, pesoneto,pesobruto,cantidad } = req.body;
    const result =  await pool.query('INSERT INTO `producto` (`CODIGO`, `NOMBRE`, `DESCRIPCION`, `TIPOUNIDAD`, `STOKMINIMO`, `PESONETO`, `PESOBRUTO`, `IDUSUARIO`, `IMG`) VALUES (?,?,?,?,?,?,?,?,?); ', [codigo,nombre,descripcion, tipounidad ,minimo,pesoneto,pesobruto,req.user.idUSUARIO, req.file.filename]);
    var idproducto = result.insertId;
    await pool.query('INSERT INTO `historica` (`TRANSACCION`, `TIPOUNIDAD`, `CANTIDAD`, `NOMBRE`, `CODIGO`, `DESCRIPCION`, `ENTRADAS`, `SALIDAS`, `idPRODUCTO`, `idUSUARIO`, `IMG`) VALUES (?,?,?,?,?,?,?,?,?,?,?);',['ENTRADA',tipounidad,cantidad,nombre, codigo, descripcion,cantidad,0,idproducto,req.user.idUSUARIO, req.file.filename]);
    req.flash('success', 'Producto Guardado');
    res.redirect('/producto_list');
});


module.exports = router;