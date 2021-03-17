const express = require('express');
const router = express.Router();
const pool = require('../database');
const Jimp = require('jimp');
const { isLoggedIn } = require('../lib/auth');

//Select menu 
router.get('/historialGeneral_list', async (req, res) => {
    if(req.user.Idroles === 1 ){  //distincion entre usuario administrador y usuario estandar 
        const data = await pool.query('SELECT * FROM inventario.vhistorica');
        res.render('general/general_list', { data });
    }
    else{
        const data = await pool.query('SELECT * FROM inventario.vhistorica where IDUSUARIO =?;',[req.user.idUSUARIO]);
        res.render('general/general_list', { data });
    }   
    
});

//Busquedas 
router.post('/busqueda_historial_general', async (req, res) => {
    const { tipofiltro, filtro, fchinicial,fchfinal  } = req.body;
    if(req.user.Idroles === 1 ){  //distincion entre usuario administrador y usuario estandar 
        if(tipofiltro === 'TODOS'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where  fchtransaccion BETWEEN ? AND ?;",[fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
       
        }else if (tipofiltro === 'ENTRADA'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where  transaccion ='ENTRADA'and fchtransaccion BETWEEN ? AND ?;",[ fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
    
        }else if (tipofiltro === 'SALIDA'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where transaccion ='SALIDA' and fchtransaccion BETWEEN ? AND ?;",[fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
    
        }else if (tipofiltro === 'NOMBRE'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where NOMBRE like  CONCAT ('%',?, '%')   and fchtransaccion BETWEEN ? AND ?;",[filtro ,fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
    
        }else if (tipofiltro === 'CODIGO'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where CODIGO like  CONCAT ('%',?, '%')  and fchtransaccion BETWEEN ? AND ?;",[ filtro ,fchinicial , fchfinal ]);
            res.render('general/general_list', { data });0
        }
    }
    else{
        if(tipofiltro === 'TODOS'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where IDUSUARIO =? and fchtransaccion BETWEEN ? AND ?;",[req.user.idUSUARIO, fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
       
        }else if (tipofiltro === 'ENTRADA'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where IDUSUARIO =? and transaccion ='ENTRADA'and fchtransaccion BETWEEN ? AND ?;",[req.user.idUSUARIO , fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
    
        }else if (tipofiltro === 'SALIDA'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where IDUSUARIO =? and transaccion ='SALIDA' and fchtransaccion BETWEEN ? AND ?;",[req.user.idUSUARIO, fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
    
        }else if (tipofiltro === 'NOMBRE'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where IDUSUARIO =? and  NOMBRE like  CONCAT ('%',?, '%')   and fchtransaccion BETWEEN ? AND ?;",[req.user.idUSUARIO, filtro ,fchinicial , fchfinal ]);
            res.render('general/general_list', { data });
    
        }else if (tipofiltro === 'CODIGO'){
            const data = await pool.query( "SELECT * FROM inventario.vhistorica where IDUSUARIO =? and CODIGO like  CONCAT ('%',?, '%')  and fchtransaccion BETWEEN ? AND ?;",[req.user.idUSUARIO, filtro ,fchinicial , fchfinal ]);
            res.render('general/general_list', { data });0
        }
    }   
});
module.exports = router;