// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-toggle-buttons
//= require_tree .


$(document).ready(function() {
  
  //$(".sortable1").stupidtable();
  var nowTemp = new Date();
  var now = new Date(nowTemp.getFullYear()-17, nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
  var startDate = new Date("1990","01", "01", 0, 0, 0, 0);
  var checkin = $('.datepicker').datepicker({
    format: 'dd/mm/yyyy',
    autoclose: true,
    onRender: function(date) {
      return date.valueOf() > now.valueOf() ? 'disabled' : '';
    }
  }).on('changeDate', function(ev) {
    if (ev.date.valueOf() > checkout.date.valueOf()) {
      var newDate = new Date(ev.date)
      newDate.setDate(newDate.getDate() + 1);
      checkout.setValue(newDate);
    }
    checkin.hide();
    $('.datepicker')[0].focus();
  }).data('datepicker');



  $(window).bind('beforeunload', function(){ 
     if (window.location == "http://localhost:3000/formulario_membros/1")
     {
        //alert("sd");
        $('#myModal').modal({show:false});
     }

  });

  /*
  * Evita que se dê um enter e ele valide o formulario
  */
  $(':input').keypress(function(e) {
    //verifica se é um input em que pode dar um enter 
    if( $(this).hasClass('allowEnter') == false )
      if(e.which == 13) 
            e.preventDefault(); // Stops from triggering the button to be clicked
  });
  
  /*
  * Funcao para que na inscricao apereca o comite respectivo  do estabelicemento de ensino
  */
  $('#cenas_comite').bind('change', function(ev) {
      var value = $(this).val();
      //alert(value);

      if (value == "null"){
          $("#btn-seguir").attr('disabled',"disabled");
      }
      else{
        $("#comite_esta_ensino").empty().html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Comite "+ value );
        $("#btn-seguir").removeAttr('disabled');
      }


   });


    var pobj = null;
    $("#sortable tbody").sortable({
      start: function (event, ui) {
            var currPos1 = ui.item.index();
             //alert(currPos1);
             $("#estado").removeClass("label-success").addClass("label-important").text("Não guardado");

      },
          //alert("ola");
            // this is the item you just draged
       update: function(event, ui){
              var itm_arr = $("#sortable tbody").sortable('toArray');
              pobj = {perguntas: itm_arr};
              //alert(itm_arr);
              
              //$.post("/formularios/1/reorder", pobj);
            }

    }).disableSelection();


     $("#guardar").click(function (event) {
          //alert("cenas");
          $("#estado").removeClass("label-important").addClass("label-sucess");
          $.ajax({
                type: "POST",
                url: "/comites/5/reorder", //sumbits it to the given url of the form
                data:  pobj
              }).success(function(data){
            });
          $("#estado").text("Guardado");
            event.preventDefault();
      });



  /*
  * Funcao que seleciona todos os checkboxes
  */
    $('#select-all').click(function (event) {

           var selected = this.checked;
           // Iterate each checkbox
           $(':checkbox[class="select-all"]').each(function () {    
                this.checked = selected; 
           });

    });

 


  /*
  * Funcao  para selecionar qual dos formularios do comite quer ver
  */
  $('#DropDownComiteMembros').bind('change', function(ev) {
     var value = $(this).val();
     //alert(value);
     document.location.href = "/formulario_membros/"+value; 
      
  });

  $('#DropDownComiteEstagios').bind('change', function(ev) {
     var value = $(this).val();
     //alert(value);
     document.location.href = "/formulario_estagios/"+value; 
      
  });

  $('#DropDownComitePerguntas').bind('change', function(ev) {
     var value = $(this).val();
     //alert(value);
     document.location.href = "/perguntas_comite/"+value; 
      
  });

  /*
  * Procura de candidatos por AJAX
  */
  $("#candidatos_search input").keyup(function() {
        //alert($("#candidatos_search").attr("action"));
        $.get($("#candidatos_search").attr("action"), $("#candidatos_search").serialize(), null,     "script");
        return false;
  });

  


  /*
  *   Mandar conteudo pra um modal 
  */ 
  $(document).on("click", ".open-AddBookDialog", function () {
     var myBookId = $(this).data('id');
     $(".modal-body #bookId").val( myBookId );
    $('#myModal').modal('show');
  });

});

