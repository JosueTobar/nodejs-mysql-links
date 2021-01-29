const express = require('express');
const router = express.Router();

const { isLoggedIn } = require('../lib/auth');

const { renderMenu, renderSubMenu } = require('../controllers/menu.controller')

// Authorization
router.use(isLoggedIn);

// Routes
router.get('/menu', renderMenu);
router.get('/submenu:id', renderMenu);
// router.post('/edit/:id', editLink);

module.exports = router;