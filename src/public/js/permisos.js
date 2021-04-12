$(document).ready( function () {

console.log("Funcionado ... "); 
if( $('#userRol').val() != ""){
    var userRol = $('#userRol').val();

    switch (userRol){
        case "1" :
        break;
        // Bodega de Materia prima
        case "2" :
            $('#moduloUsuarios').remove();
            $('#bodegaAccesorios').remove();
            $('#moduloConfiguracion').remove();
        break;
        //Bodega de accesorios 
        case "3" :
            $('#bodegaGeneral').remove();
            $('#moduloUsuarios').remove();
            $('#moduloUsuarios').remove();
            $('#moduloConfiguracion').remove();
        break;
        //Bodega General
        case "4" :
            $('#bodegaGeneral').remove();
            $('#moduloUsuarios').remove();
            $('#bodegaAccesorios').remove();
            $('#moduloConfiguracion').remove();
        break;
    }
}

});