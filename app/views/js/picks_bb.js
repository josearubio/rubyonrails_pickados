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
        stake: 0,
        usuario_id:0,
        comentario:""
    }
});
var ListarView = Backbone.View.extend({
    el: '#picks_todos',

    initialize : function() {
        //INICIALIZAMOS MODELO Y RENDERIZAMOS PARA MOSTRAR LOS PICKS PRIMERO
        this.model= new Pick()
        this.render();
    },

    //ESTE RENDER SE UTILIZARÁ PARA MOSTRAR TODOS LOS PICKS, CON SEMEJANTES MÉTODOS
    render: function() {
        var xhr = new XMLHttpRequest()
        xhr.open("GET", "/api/picks/picks", true)



        var callback_todos= function() {
            if (this.readyState == 4) {
                if (this.status == 200) {
                    var lista = JSON.parse(this.responseText)
                    mostrar_todos(lista)

                }
            }

        }


        var mostrar_todos= function(lista){
            var div_todos = document.getElementById("picks_todos")
            var template = document.getElementById("template_todos").innerHTML

            var html_proyecto = Mustache.render(template, lista)

            div_todos.insertAdjacentHTML("beforeend", html_proyecto)
        }

//
        xhr.onreadystatechange = callback_todos
        xhr.send()

    },
    verdetalle: function(e) {
        e.preventDefault();
        var id = $(e.currentTarget).data("id");
        var div_elegido = document.getElementById("pick_"+id)
        var template = document.getElementById("template_detallesbb").innerHTML
        var btn = document.getElementById("btnverdetallesbb_"+ id)

        var xhr = new XMLHttpRequest()
        xhr.open("GET", "/api/picks/pick/" + id, true)

        var callback_detalles= function() {
            if (this.readyState == 4) {
                if (this.status == 200) {
                    var data = JSON.parse(this.responseText)

                    //Asignamos al objeto backbone.model.Pick los datos obtenidos y lo pasamos al render
                    this.model = new Pick(data);
                    var html_edit = Mustache.render(template, this.model.toJSON())

                    //ESCONDEMOS EL BOTON VER DETALLE SI YA LE HEMOS CLICKADO
                    btn.style.visibility = "hidden"
                    div_elegido.insertAdjacentHTML("beforeend", html_edit)

                }
            }
        }

        xhr.onreadystatechange = callback_detalles
        xhr.send()

    },

    events: {
        "click button": "verdetalle"
    }

});

var lv = new ListarView()


