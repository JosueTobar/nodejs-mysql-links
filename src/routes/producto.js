const express = require('express');
const router = express.Router();
const pool = require('../database');
const Jimp = require('jimp');
const { isLoggedIn } = require('../lib/auth');

//
router.get('/producto_add',  (req, res) => {
    res.render('producto/add');
});

router.get('/producto_edit/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await pool.query('SELECT * FROM vproductos where idPRODUCTO = ?', [id]);
    res.render('producto/edit', { producto: producto[0] }); 
});

router.post('/producto_Update/:id', async (req, res) => {
    const { id } = req.params;
    const { nombre, descripcion, tipounidad, minimo, pesoneto,pesobruto } = req.body;
    const producto = await pool.query("UPDATE `inventario`.`producto` SET `NOMBRE` = ?, `IMG` = ?, `DESCRIPCION` = ?, `TIPOUNIDAD` = ? , `STOKMINIMO` = ?, `PESONETO` = ?, `PESOBRUTO` = ? WHERE (`idPRODUCTO` = ?)" , [nombre, req.file.filename, descripcion, tipounidad, minimo, pesoneto,pesobruto, id]);
    res.redirect('/producto_list');
});

router.get('/producto_list', async (req, res) => {
    if(req.user.Idroles === 1 ){  //distincion entre usuario administrador y usuario estandar 
        console.log('Ingresado con la mandera de los dioses ');
        const producto = await pool.query('SELECT * FROM vproductos');
        res.render('producto/list', { producto });
    }
    else{
        const producto = await pool.query('SELECT * FROM vproductos where IDUSUARIO =?;',[req.user.idUSUARIO]);
        res.render('producto/list', { producto });
    }   
});

router.get('/producto_transaccion/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await pool.query('SELECT * FROM vproductos where idPRODUCTO = ?', [id]);
    res.render('producto/transaccion', { producto: producto[0] }); 
});

router.get('/producto_delete/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await pool.query('SELECT * FROM vproductos where idPRODUCTO = ?', [id]);
    res.render('producto/transaccion', { producto: producto[0] }); 
});


router.post('/producto_add', async (req, res) => {
    const filepath = req.file.filename;
  
    const { codigo, nombre, descripcion, tipounidad,minimo, pesoneto,pesobruto,cantidad } = req.body;
    const result =  await pool.query('INSERT INTO `producto` (`CODIGO`, `NOMBRE`, `DESCRIPCION`, `TIPOUNIDAD`, `STOKMINIMO`, `PESONETO`, `PESOBRUTO`, `IDUSUARIO`, `IMG`) VALUES (?,?,?,?,?,?,?,?,?); ', [codigo,nombre,descripcion, tipounidad ,minimo,pesoneto,pesobruto,req.user.idUSUARIO, req.file.filename]);
    var idproducto = result.insertId;
    await pool.query('INSERT INTO `historica` (`TRANSACCION`, `CANTIDAD`, `DESCRIPCION`, `ENTRADAS`, `SALIDAS`, `idPRODUCTO`, `idUSUARIO`) VALUES (?,?,?,?,?,?,?);',['ENTRADA',cantidad, descripcion,cantidad,0,idproducto,req.user.idUSUARIO]);
    req.flash('success', 'Producto Guardado');
    res.redirect('/producto_list');
});

router.post('/producto_transaccion', async (req, res) => {
    const { descripcion, tipo, destinatario,cantidad , idproducto, entradas, salidas} = req.body;
    if(tipo === 'ENTRADA'){
        const result = await pool.query( "INSERT INTO historica (TRANSACCION, CANTIDAD, DESTINATARIO, DESCRIPCION, ENTRADAS, SALIDAS, idPRODUCTO, idUSUARIO) VALUES (?, ?, ?, ?, ?, ?, ?, ?);",[tipo,cantidad,destinatario, descripcion,cantidad,0,idproducto,req.user.idUSUARIO]);
        req.flash('success', 'Entrada Guardada' );
    }else if (tipo === 'SALIDA'){
        const result = await pool.query( "INSERT INTO historica (TRANSACCION, CANTIDAD, DESTINATARIO, DESCRIPCION, ENTRADAS, SALIDAS, idPRODUCTO, idUSUARIO) VALUES (?, ?, ?, ?, ?, ?, ?, ?);",[tipo,cantidad,destinatario, descripcion,0,cantidad,idproducto,req.user.idUSUARIO]);
        req.flash('success', 'Salida Guardada' );
    }
    res.redirect('/producto_list');
});
module.exports = router;