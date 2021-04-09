const express = require('express');
const router = express.Router();
const pool = require('../database');

//Select 
router.get('/testGet', (req, res) => {
        pool.query('SELECT * FROM vhistorica where IDUSUARIO =1',(err, rows, fields ) => {
        if(!err){
            res.json(rows);
        }else{
            console.log(err);
        }
    });
});

//Insert 
router.post('/bodega/ins', (req,res) => {
    const {nombre, selEstado} = req.body;
    const QInsert = "INSERT INTO BODEGA (NOMBRE,ESTADO) VALUES(?,?);";
    mysqlConnection.query(QInsert,[nombre,selEstado ],  (err, rows, fields) => {
        if(!err){
            res.redirect('/pages/bodegas.html');
         }else{
            res.redirect('/pages/bodegas.html');
            console.log(err);
         }
     });   
});
//update 
router.post('/bodega/upd', (req,res) => {
    const {idBodega,nombreupd, selEstadoupd} = req.body;
    const QInsert = "UPDATE `BODEGA` SET `NOMBRE` = ?, `ESTADO` = ? WHERE (`idBODEGA` = ?);";
    mysqlConnection.query(QInsert,[nombreupd,selEstadoupd,idBodega ],  (err, rows, fields) => {
        if(!err){
            res.redirect('/pages/bodegas.html');
         }else{
            res.redirect('/pages/bodegas.html');
            console.log(err);
         }
     });   
});
//delete
router.delete('/bodega/delete/:id', (req,res) => {
    const {id} = req.params;
    console.log(id);
    const query = "DELETE FROM `BODEGA` WHERE (`idBODEGA` = ?); ";
    console.log(query);
    mysqlConnection.query(query,[id], (err, rows, fields) => {
        if(!err){
            res.redirect('/pages/bodegas.html');
         }else{
             console.log(err); 
         }
    });
});
module.exports = router;