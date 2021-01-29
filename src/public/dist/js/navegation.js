
//Document Ready function 
$(document).ready(function () {
    const user = {
      id : $("#txtIdUser").val()
    }
    console.log('funca fele');
    fetch('https://inventario.josuetobar.com/bodega/sel')
    .then(response => response.json())
    .then(data => console.log(data));
    // https://inventario.josuetobar.com/bodega/sel?_=1611698396510
});