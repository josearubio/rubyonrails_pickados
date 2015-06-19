/**
 * Created by adi on 7/01/15.
 */

//El objeto representará un pick, llamamos al modelo de Backbone
var Pick = Backbone.Model.extend({
    defaults: {
        deporte: "",
        cuota: 0,
        pronostico: "",
        categoria: "",
        evento: "",
        stake: 0,
        usuario_id:0,
        comentario:""
    },

    //Boramos el pick pasandole la id como parámetro
    borrar_pick: function(id) {


        xhr = new XMLHttpRequest()

        //Llamamos al metodo borrar de la API
        xhr.open("DELETE","/api/picks/pick/" + id,true);
        var callback_borrarpick = function() {
            if (xhr.readyState==4){
                //Si se borra con éxito, mostramos alerta y recargamos página
                if (xhr.status==200) {

                    document.location.reload(true)
                    document.getElementById("alertaaccion").style.visibility = "visible"
                    document.getElementById("alertaaccion").innerHTML="Pick borrado correctamente"
                }
                else alert("No se ha podido borrar el pick")}
        }

        xhr.onreadystatechange = callback_borrarpick
        xhr.setRequestHeader("Content-type","application/json; charset=utf-8");
        xhr.send();
    }





});

/**var CrearCollection = Backbone.Collection.extend({
    model: Pick
});**/

var BorrarView = Backbone.View.extend({
    el: '#picks_todos',

    initialize : function() {
        //Inicializamos el modelo
        this.model= new Pick()
    },

    update: function(e) {

        //Con e.currentTarget obtenemos el botón que ha sido clickeado y capturamos la id
        e.preventDefault();
        var id = $(e.currentTarget).data("id");
        var div_elegido = document.getElementById("pick_"+id)
        var template = document.getElementById("template_editar").innerHTML

        var xhr = new XMLHttpRequest()

        //Petición GET que obtiene un pick a través de su id
        xhr.open("GET", "/api/picks/pick/" + id, true)

        var callback_detalles = function(){
            if (this.readyState == 4) {
                if (this.status == 200) {
                    //Obtenemos el pick en JSON
                    var data = JSON.parse(this.responseText)

                    //Asignamos al objeto backbone.model.Pick los datos obtenidos y lo pasamos al render
                    this.model = new Pick(data);
                    //Renderizamos y mostramos datos aumentados
                    var html_edit = Mustache.render(template, this.model.toJSON())
                    //AL RENDERIZAR, POR DEFECTO LOS CAMPOS TENDRÁN LOS VALORES ANTIGUOS
                    div_elegido.insertAdjacentHTML("beforeend", html_edit)
                }
            }

        }

        xhr.onreadystatechange = callback_detalles
        xhr.send()

    },
    //Si ha sido clickado el botón borrar, capturamos el id y llamamos al metodo borrar_pick del modelo
    borrar: function(e) {
        e.preventDefault();
        var id = $(e.currentTarget).data("id");
        this.model.borrar_pick(id)
    },
    actualizar: function(e) {
        e.preventDefault();
        var id = $(e.currentTarget).data("id");
        var div_elegido = document.getElementById("pick_"+id)
        //Obtenemos en data los valores de los campos a modificar
        var data = {}
        var campocuota=document.getElementById("editacuota").value;
        var campostake=document.getElementById("editastake").value;
        data['cuota']=campocuota
        data['stake']=campostake

        var xhr = new XMLHttpRequest()
        xhr.open("POST", "/api/picks/"+ id +"/modifypick", true)

        var callback_confirmar = function(){
            if (this.readyState == 4) {
                if (this.status == 200) {

                    //SI CONFIRMAMOS CAMBIOS, ACTUALIZAMOS DATA
                    data['cuota']=campocuota
                    data['stake']=campostake
                   // alert("Campos actualizados correctamente")
                    //RECARGAMOS Y MOSTRAMOS ALERTA
                    document.location.reload(true)
                    document.getElementById("alertaaccion").style.visibility = "visible"
                    document.getElementById("alertaaccion").innerHTML="Pick actualizado correctamente"
                }
            }

            }

        xhr.onreadystatechange = callback_confirmar
        xhr.setRequestHeader("Content-type","application/json; charset=utf-8");
        xhr.send(JSON.stringify(data));
    },
    //CAPTURAMOS LOS EVENTOS SEGÚN LA ACCIÓN QUE QUERAMOS LLEVAR A CABO
    events: {
        "click #btnborrar": "borrar",
        "click #btnupdate": "update",
        "click #btnconfupdate": "actualizar"
    }

});

//INCIALIZAMOS LA VISTA
var bw = new BorrarView()



