/**
 * Created by adi on 16/12/14.
 */

function login(){

    //ALMACENAMOS EN DATA LOS VALORES ESCRITOS DE LOGIN Y PASS
    var data = {};
    data['login']=document.getElementById("loginusername").value;
    data['password']=document.getElementById("loginpassword").value;

    //SETEAMOS EN EL LOCALSTORAGE EL LOGIN QUE NOS SERÁ ÚTIL PARA VARIAS FUNCIONALIDADES
    localStorage.setItem("login", document.getElementById("loginusername").value);

if(data['login']!="" && data['password']!=""){

    //SI NO HAY DATOS VACIOS LLAMAMOS AL LOGIN DEL API
    var xhr = new XMLHttpRequest()
    xhr.open("POST","/api/autentificacion/login",true);
    xhr.onreadystatechange = callback_login
    xhr.setRequestHeader("Content-type","application/json; charset=utf-8");

    //MANDAMOS LOS DATOS DE LOGUEO
    xhr.send(JSON.stringify(data));
}
else (alert("No se permiten campos vacios"))

}

function callback_login() {
    if (this.readyState == 4) {

        if (this.status == 200) {
            //SI NOS LOGUEAMOS CON EXITO RECARGAMOS PÁGINA
            document.location.reload(true)
        }
        else {
            //EN CASO CONTRARIO, BORRAMOS EL LOGIN DE LOCALSTORAGE Y MOSTRAMOS ALERTA
            alert("Login incorrecto")
            localStorage.setItem("login","")

        }
    }

}

function logout(){
    //VACIAMOS LOCALSTORAGE PRIMERO
    localStorage.setItem("login", "");

    //HACEMOS PETICION AL LOGOUT
    var xhr = new XMLHttpRequest()
    xhr.open("GET","/api/autentificacion/logout",false);
    xhr.send();
    //REDIRIGIMOS SEGÚN LA LOCALIZACIÓN
    if(location.href!="http://localhost:9292/web/mispicks.html"){
    document.location.reload(true)}
    else window.location="/web/index.html"

}