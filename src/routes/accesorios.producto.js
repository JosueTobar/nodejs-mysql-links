const express = require('express');
const router = express.Router();
const pool = require('../database');
const Jimp = require('jimp');
const { isLoggedIn } = require('../lib/auth');

router.get('/accesorio_add', (req, res) => {
    res.render('Accesorios/accesorio_add');
});

router.get('/accesorio_edit/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await pool.query('SELECT * FROM vproductos where idPRODUCTO = ?', [id]);
    res.render('general/producto/edit', { producto: producto[0] });
});

router.get('/accesorio_list', async (req, res) => {
    if (req.user.Idroles === 1) {  //distincion entre usuario administrador y usuario estandar 
        console.log('Ingresado con la mandera de los dioses ');
        const producto = await pool.query('SELECT * FROM vproductos');
        res.render('general/producto/list', { producto });
    }
    else {
        const producto = await pool.query('SELECT * FROM vproductos where IDUSUARIO =?;', [req.user.idUSUARIO]);
        console.log(req.user);
        res.render('general/producto/list', { producto });
    }
});

router.get('/producto_transaccion/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await pool.query('SELECT * FROM vproductos where idPRODUCTO = ?', [id]);
    res.render('general/producto/transaccion', { producto: producto[0] });
});

router.get('/producto_delete/:id', async (req, res) => {
    const { id } = req.params;
    const producto = await pool.query('SELECT * FROM vproductos where idPRODUCTO = ?', [id]);
    res.render('general/producto/transaccion', { producto: producto[0] });
});

router.post('/producto_add', async (req, res) => {
    var idproducto = null;
    const { codigo, nombre, descripcion, tipounidad, minimo, pesoneto, pesobruto, cantidad, color, origen } = req.body;
    try {
        //Evaluar si biene el archivo en la peticion. 
        if (req.file) {
            const filepath = req.file.filename;
            console.log(req.body);
            const result = await pool.query('INSERT INTO `producto` (`CODIGO`, `NOMBRE`, `DESCRIPCION`, `TIPOUNIDAD`, `STOKMINIMO`, `PESONETO`, `PESOBRUTO`, `IDUSUARIO`, `IMG` , `COLOR` , `ORIGEN`) VALUES (?,?,?,?,?,?,?,?,?,?,?); ', [codigo, nombre, descripcion, tipounidad, minimo, pesoneto, pesobruto, req.user.idUSUARIO, req.file.filename, color, origen]);
            idproducto = result.insertId;
            await pool.query('INSERT INTO `historica` (`TRANSACCION`, `CANTIDAD`, `DESCRIPCION`, `ENTRADAS`, `SALIDAS`, `idPRODUCTO`, `idUSUARIO`) VALUES (?,?,?,?,?,?,?);', ['ENTRADA', cantidad, descripcion, cantidad, 0, idproducto, req.user.idUSUARIO]);
            req.flash('success', 'Producto Guardado');
            res.redirect('/producto_list');
        } else {//Sin Archivo
            const result = await pool.query('INSERT INTO `producto` (`CODIGO`, `NOMBRE`, `DESCRIPCION`, `TIPOUNIDAD`, `STOKMINIMO`, `PESONETO`, `PESOBRUTO`, `IDUSUARIO` , `COLOR` , `ORIGEN`) VALUES (?,?,?,?,?,?,?,?,?,?); ', [codigo, nombre, descripcion, tipounidad, minimo, pesoneto, pesobruto, req.user.idUSUARIO, color, origen]);
            idproducto = result.insertId;
            await pool.query('INSERT INTO `historica` (`TRANSACCION`, `CANTIDAD`, `DESCRIPCION`, `ENTRADAS`, `SALIDAS`, `idPRODUCTO`, `idUSUARIO`) VALUES (?,?,?,?,?,?,?);', ['ENTRADA', cantidad, descripcion, cantidad, 0, idproducto, req.user.idUSUARIO]);
            req.flash('success', 'Producto Guardado');
            res.redirect('/producto_list');
        }
    }
    catch (e) {
        console.log("entering catch block");
        console.log(e);
        console.log("leaving catch block");
    }
});

router.post('/producto_Update/:id', async (req, res) => {
    const { id } = req.params;
    const { nombre, descripcion, tipounidad, minimo, pesoneto, pesobruto, color, origen } = req.body;
    try {
        //Evaluar si biene el archivo en la peticion. 
        if (req.file) {
            const filepath = req.file.filename;
            const producto = await pool.query("UPDATE producto SET `NOMBRE` = ?, `IMG` = ?, `DESCRIPCION` = ?, `TIPOUNIDAD` = ? , `STOKMINIMO` = ?, `PESONETO` = ?, `PESOBRUTO` = ?, `COLOR` = ?, `ORIGEN` = ? WHERE (`idPRODUCTO` = ?)", [nombre, filepath, descripcion, tipounidad, minimo, pesoneto, pesobruto, color, origen, id]);
            res.redirect('/producto_list');
        } else {//Sin Archivo
            const producto = await pool.query("UPDATE producto SET `NOMBRE` = ?, `DESCRIPCION` = ?, `TIPOUNIDAD` = ? , `STOKMINIMO` = ?, `PESONETO` = ?, `PESOBRUTO` = ?,  `COLOR` = ?, `ORIGEN` = ? WHERE (`idPRODUCTO` = ?)", [nombre, descripcion, tipounidad, minimo, pesoneto, pesobruto, color, origen, id]);
            res.redirect('/producto_list');
        }
    }
    catch (e) {
        console.log("entering catch block");
        console.log(e);
        console.log("leaving catch block");
    }
});

router.post('/producto_transaccion', async (req, res) => {
    const { descripcion, tipo, destinatario, cantidad, idproducto, entradas, salidas } = req.body;
    if (tipo === 'ENTRADA') {
        const result = await pool.query("INSERT INTO historica (TRANSACCION, CANTIDAD, DESTINATARIO, DESCRIPCION, ENTRADAS, SALIDAS, idPRODUCTO, idUSUARIO) VALUES (?, ?, ?, ?, ?, ?, ?, ?);", [tipo, cantidad, destinatario, descripcion, cantidad, 0, idproducto, req.user.idUSUARIO]);
        req.flash('success', 'Entrada Guardada');
    } else if (tipo === 'SALIDA') {
        const result = await pool.query("INSERT INTO historica (TRANSACCION, CANTIDAD, DESTINATARIO, DESCRIPCION, ENTRADAS, SALIDAS, idPRODUCTO, idUSUARIO) VALUES (?, ?, ?, ?, ?, ?, ?, ?);", [tipo, cantidad, destinatario, descripcion, 0, cantidad, idproducto, req.user.idUSUARIO]);
        req.flash('success', 'Salida Guardada');
    }
    res.redirect('/producto_list');
});
module.exports = router;