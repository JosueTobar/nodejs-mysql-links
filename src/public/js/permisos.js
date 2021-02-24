$(document).ready( function () {

console.log("Funcionado ... "); 
if( $('#userRol').val() != ""){
    var userRol = $('#userRol').val();

    switch (userRol){
        case "1" :
        break;
        case "2" :
            $('#moduloUsuarios').remove();
            $('#bodegaAccesorios').remove();
        break;
        case "3" :
            $('#bodegaGeneral').remove();
            $('#moduloUsuarios').remove();
        break;
        case "4" :
            $('#bodegaGeneral').remove();
            $('#moduloUsuarios').remove();
            $('#bodegaAccesorios').remove();
        break;
    }
}

});