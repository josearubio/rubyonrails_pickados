/**
 * LOGONOUT.JS ES USADO PARA OCULTAR O MOSTRAR EL FORM DE LOGUEO Y EL CIERRE DE SESIÓN
 */
window.addEventListener('load', iflogon)

function iflogon() {
    //INICIALIZAMOS LAS VARIABLES DE LOS DIVS DE LOGUEO Y LOGOUT

    var div_form= document.getElementById("formlogin")
    var div_logon=document.getElementById("logon")
    var btnlogout=document.getElementById("botonlogout")
    var mispicksitem=document.getElementById("enlacemispicks")

    //SI ESTAMOS LOGUEADOS, ESCONDEMOS FORMULARIO LOGIN Y MOSTRAMOS LA FRASE "BIENVENIDOS {NOMBRE}" Y EL BOTON DE LOGOUT
    if(localStorage.getItem("login")==""){
        div_form.style.visibility = "visible"
        div_logon.style.visibility = "hidden"
        btnlogout.style.visibility = "hidden"
        mispicksitem.style.visibility = "hidden"
    }
    //VICEVERSA
    else {
        div_form.style.visibility = "hidden"
        div_logon.style.visibility = "visible"
        btnlogout.style.visibility = "visible"
        div_logon.insertAdjacentHTML("beforeend",localStorage.getItem("login"))
        mispicksitem.style.visibility = "visible"
    }



}