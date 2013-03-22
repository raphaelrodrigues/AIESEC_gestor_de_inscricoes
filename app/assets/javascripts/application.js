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
  
  $('.datepicker').datepicker();
  
  
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




            // var item = ui.item;
            // var container = item.parent();
            // var reorder = [];
            // container.children('tr').each(function(i){
            //     // save the item id order in array
            //     reorder[i] = $(this).attr('id');
            //     //alert($(this).attr('id'));
            // });

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
        $.get($("#candidatos_search").attr("action"), $("#candidatos_search").serialize(), null,     "script");
        return false;
  });

  $(".sortable1").stupidtable();


  /*
  *   Mandar conteudo pra um modal 
  */ 
  $(document).on("click", ".open-AddBookDialog", function () {
     var myBookId = $(this).data('id');
     $(".modal-body #bookId").val( myBookId );
    $('#myModal').modal('show');
  });

});

