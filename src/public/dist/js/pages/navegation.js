
//Document Ready function 
$(document).ready(function () {

    console.log('funca fele');
    fetch('https://inventario.josuetobar.com/bodega/sel')
    .then(response => response.json())
    .then(data => console.log(data));
    // https://inventario.josuetobar.com/bodega/sel?_=1611698396510
});