/**
 * Created by adi on 2/12/14.
 */
window.addEventListener('load', pedir_all)





//MUESTRA TODOS LOS PICKS, LLAMAMA A LA PETICION, USAMOS AJAX COMO EN TODO
function pedir_all() {
    var xhr = new XMLHttpRequest()
    xhr.open("GET", "/api/picks/picks", true)
    xhr.onreadystatechange = callback_todos
    xhr.send()
}

function callback_todos() {
    if (this.readyState == 4) {
        if (this.status == 200) {
            var lista = JSON.parse(this.responseText)
            mostrar_todos(lista)

        }
    }

}

function mostrar_todos(lista) {
    var div_todos = document.getElementById("picks_todos")
    //obtenemos el texto de la template de Mustache
    var template = document.getElementById("template_todos").innerHTML

    var html_proyecto = Mustache.render(template, lista)
    //insertamos el HTML en su sitio
    div_todos.insertAdjacentHTML("beforeend", html_proyecto)
}

//MAESTRO/DETALLE , PASANDO ID COMO PARAMETRO Y LLAMANDO A LA PETICION
window.ver_detalles = function ver_detalles(id) {
    var xhr = new XMLHttpRequest()
    xhr.open("GET", "/api/picks/pick/" + id, true)
    xhr.onreadystatechange = callback_detalles
    xhr.send()
}

//AÑADIMOS EN EL DIV LOS DETALLES DE AMPLIACIÓN RENDERIZANDO OTRO TEMPLATE
function callback_detalles() {
    if (this.readyState == 4) {
        if (this.status == 200) {
            var pick = JSON.parse(this.responseText)
            mostrar_detalles(pick)


        }
    }
}


function mostrar_detalles(pick) {

    var item = document.getElementById("pick_" + pick.id)
    var template = document.getElementById("template_detalles").innerHTML
    var btn = document.getElementById("btnverdetalles_" + pick.id)
    //OCULTAMOS EL BOTON PARA QUE NO LO PODAMOS CLICKAR OTRA VEZ
    btn.style.visibility = "hidden"
    //RENDERIZAMOS
    item.insertAdjacentHTML("beforeend", Mustache.render(template, pick))
}