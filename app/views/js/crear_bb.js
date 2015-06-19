/**
 * Created by adi on 7/01/15.
 */

var Pick = Backbone.Model.extend({
    defaults: {
        deporte: "",
        cuota: 0,
        pronostico: "",
        categoria: "",
        evento: "",
        stake: 0
    },
    crear_pick: function() {


       xhr = new XMLHttpRequest()
        xhr.open("POST","/api/picks/newpick",true);
        var callback_crearpick = function() {
            if (xhr.readyState==4){
                if (xhr.status==200) {
                    alert("Pick publicado con éxito")
                    //REDIRIGIMOS A LA PÁGINA DE MIS PICKS
                    window.location="/web/mispicks.html"
                    //MOSTRAMOS EL AVISO DE QUE SE HA CREADO CORRECTAMENTE
                    window.document.getElementById("alertaaccion").innerHTML="Pick añadido correctamente"
                }
            else if (xhr.status==401) {alert("Debes iniciar sesión")}
        else {alert("Intentalo de nuevo")}
        }
        }

        xhr.onreadystatechange = callback_crearpick
        xhr.setRequestHeader("Content-type","application/json; charset=utf-8");
        //ENVIAMOS LOS VALORES INDICADOS EN EL FORMULARIO
        xhr.send(JSON.stringify(this));
    }
});

/**var CrearCollection = Backbone.Collection.extend({
    model: Pick
});**/

var CrearView = Backbone.View.extend({
    el: '#crear_form',

    initialize : function() {
        console.log("view init");
        this.model= new Pick()
        },

   prueba: function() {
        //COMPROBAMOS SI EL FORMULARIO ESTÁ VALIDADO. LO HACEMOS ASÍ Y NO EN EL HTML PORQUE NO HAY SUBMIT
       if (document.getElementById("cuota").checkValidity()==false || document.getElementById("deporte").checkValidity()==false
           || document.getElementById("cuota").checkValidity()==false
       || document.getElementById("pronostico").checkValidity()==false
       || document.getElementById("categoria").checkValidity()==false
       || document.getElementById("evento").checkValidity()==false
       || document.getElementById("stake").checkValidity()==false) {
           alert("Error en formato o campos vacios, vuelva a intentarlo")
       }
       else{
           //SI LOS DATOS SON CORRECTOS, ASIGNAMOS ESTOS AL MODELO Y LLAMAMOS AL METODO CREAR
       this.model.set("deporte",document.getElementById("deporte").value)
       this.model.set("cuota",document.getElementById("cuota").value)
       this.model.set("pronostico",document.getElementById("pronostico").value)
       this.model.set("categoria",document.getElementById("categoria").value)
       this.model.set("evento",document.getElementById("evento").value)
       this.model.set("stake",document.getElementById("stake").value)
       this.model.crear_pick()}
    },
    events: {
        "click #botoncrear": "prueba"
    }

});

var pw = new CrearView()


