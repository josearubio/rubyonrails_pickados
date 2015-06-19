/**
 * Created by adi on 2/12/14.
 */
window.addEventListener('load', pedir_mispicks)

//OBTIENE LOS PICKS DEL USUARIO LOGUEADO
function pedir_mispicks() {
   if(localStorage.getItem("login")!=""){
    //SI HAY SESIÓN, LLAMAMOS A LA PETICIÓN
    var xhr = new XMLHttpRequest()
    xhr.open("GET", "/api/picks/mypicks", true)
    xhr.onreadystatechange = callback_mispicks
    xhr.send()
   }
    //SI NO, MOSTRAMOS ALERTA
    else {alert("Debes estar logueado")}
}

function callback_mispicks() {
    if (this.readyState == 4) {

        if (this.status == 200) {
            //OBTENEMOS LOS DATOS Y LLAMAMOS A LA FUNCION QUE LOS MUESTRA EN PANTALLA
            var lista = JSON.parse(this.responseText)
            mostrar_mios(lista)

        }

    }

}

function mostrar_mios(lista) {

    //RENDERIZAMOS TEMPLATE Y MOSTRAMOS LOS PICKS
    var div_mios = document.getElementById("picks_todos")
    //obtenemos el texto de la template de Mustache
    var template = document.getElementById("template_todos").innerHTML

    var html_proyecto = Mustache.render(template, lista)
    //insertamos el HTML en su sitio
    div_mios.insertAdjacentHTML("beforeend", html_proyecto)
}