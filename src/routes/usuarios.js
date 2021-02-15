const express = require('express');
const router = express.Router();
const pool = require('../database');

const { isLoggedIn } = require('../lib/auth');

// CRUD Users 
router.get('/user_add', async (req, res) => {
    res.render('user/add');
}); 

router.get('/user_list', async (req, res) => {
    const users = await pool.query('SELECT u.idUSUARIO id, u.fullname, u.username, r.NOMBRE rol FROM users u , roles r where  r.id = u.Idroles;');
    res.render('user/list', { users });
});
 
router.get('/user_delete/:id', async (req, res) => {
    const { id } = req.params;
    await pool.query('DELETE FROM users WHERE idUSUARIO = ?', [id]);
    req.flash('success', 'Usuario Eliminado Correctamete');
    res.redirect('/user_list');
});

router.get('/user_edit/:id', async (req, res) => {
    const { id } = req.params;
    const user = await pool.query('SELECT u.idUSUARIO id, u.fullname, u.username, r.NOMBRE rol FROM users u , roles r where  r.id = u.Idroles and u.idUSUARIO = ?', [id]);
    res.render('user/edit', { user: user[0] }); 
});

router.post('/user_upd', async (req,res) => {
    const { fullname, username, idroles, idUsuario } = req.body;
    console.log(req.body);
    await pool.query('update users set fullname=?, username=?, Idroles=? where idUSUARIO = ?;', [fullname,username, idroles,idUsuario]);
    res.redirect('/user_list');
});

module.exports = router;