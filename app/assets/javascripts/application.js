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
//= require highcharts
//= require_tree .


$(document).ready(function() {
      

        // ==================================================== //
      //                 STUPID TABLE SORT                //
      // ==================================================== //
      var date_from_string = function(str){
          var months = ["jan","feb","mar","apr","may","jun","jul",
          "aug","sep","oct","nov","dec"];
          var pattern = "^([a-zA-Z]{3})\\s*(\\d{2}),\\s*(\\d{4})$";

          var pattern = "^([a-zA-Z]{3})\\s*(\\d{2})$";

          var re = new RegExp(pattern);
          
          
          var DateParts = re.exec(str).slice(0);


          var Year = "2012";
          var Month = $.inArray(DateParts[1].toLowerCase(), months);
          var Day = DateParts[0];
          return new Date(Year,Month,Day);
      }


      var table = $(".sortable1").stupidtable({
        // Sort functions here
        "date":function(a,b){
            // Get these into date objects for comparison.
            aDate = date_from_string(a);
            bDate = date_from_string(b);

            return aDate - bDate;
        }
      });

      table.bind('aftertablesort', function (event, data) {
          // data.column - the index of the column sorted after a click
          // data.direction - the sorting direction (either asc or desc)

          var th = $(this).find("th");
          th.find(".arrow").remove();
          var arrow = data.direction === "asc" ? "↑" : "↓";
          th.eq(data.column).append('<span class="arrow">' + arrow +'</span>');
      });
      //$(".sortable1").stupidtable();
      $('form:first *:input[type!=hidden]:first').focus();
      //$('#search').focus();

      var pobj = null;
      var checkValues = [];
      var saved = 1;
       // ==================================================== //
      //                 Modal functions                //
      // ==================================================== //

      $("#mail").click(function(event){

         var n_chbx = checkTheBox( $(this).attr('value') )
         if (n_chbx == 0)
         {
            $("#askDialog1222").modal('show');
            //alert("Tens de seleccionar pelo menos um candidato");
            event.preventDefault;
            return false;
         }

         $('#askDialogBody').empty();
          $("#askDialogPrompt").html("Emails Candidatos Selecionados");
          checkValues = [];
          //verifica quais as checkboxes selecionadas
           $('input[class=select-all]:checked').each(function() {
             var email = "email".concat($(this).val());
             var email_cand = document.getElementById(email).textContent;
             checkValues.push(email_cand+"<br>");
          });
          
          $('#askDialogBody').html(checkValues);

          $("#askDialog").modal('show');
      });


      $("#telemovel").click(function(event){

         var n_chbx = checkTheBox( $(this).attr('value') )
         if (n_chbx == 0)
         {
           
            $("#askDialog1222").modal('show');
            event.preventDefault;
            return false;
         }


         $('#askDialogBody').empty();
          $("#askDialogPrompt").html("Telemoveis Candidatos Selecionados");
          checkValues = [];
          //verifica quais as checkboxes selecionadas
           $('input[class=select-all]:checked').each(function() {
             var tel = "tel".concat($(this).val());
             var tel_cand = document.getElementById(tel).textContent;
             checkValues.push(tel_cand+"<br>");
          });
          
          $('#askDialogBody').html(checkValues);

          $("#askDialog").modal('show');
      });




      // ==================================================== //
      //                 formularios functions                //
      // ==================================================== //

      $("#form_candidatos").submit(function() {

          n = 0;
          $('input[class=select-all]:checked').each(function() {
               n = n + 1;
          });

          if (n == 0)
          {
            alert('Handler for .submit() called.');
            return false;
          }
          else
            return true;

      });

      // ==================================================== //
      //                 DATE PICKER functions                //
      // ==================================================== //
      
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
            if (!saved)
              confirm("os dados não estou guardados!!");
              //$('#myModal').modal('show');
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
      

        
        $("#sortable tbody").sortable({
          start: function (event, ui) {
                var currPos1 = ui.item.index();
                 //alert(currPos1);
                 saved = 0;
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

         $("#sortableEstados tbody").sortable({
          start: function (event, ui) {
                var currPos1 = ui.item.index();

          },
              //alert("ola");
                // this is the item you just draged
           update: function(event, ui){
                  var itm_arr = $("#sortableEstados tbody").sortable('toArray');
                  var pobj1 = {estados: itm_arr};
                  $.ajax({
                    type: "POST",
                    url: "/comites/5/reorderEstados", //sumbits it to the given url of the form
                    data:  pobj1
                  }).success(function(data){
                    
                });
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
                saved = 1;
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


      $("input[type='text'][id='estado_nome']").hide();
      $('#estado_nome').on('change', function() {
          if (this.value == "Outro")
          {
           $("input[type='text'][id='estado_nome']").show();
           $("input[type='text'][id='estado_nome']").val("");
         }
         else
         {
           $("input[type='text'][id='estado_nome']").hide();
           $("input[type='text'][id='estado_nome']").val(this.value);
         }
      });


      $('.disabled').click(function(e) {
          alert("Não é possivel efectuar esta acção!!");
          e.preventDefault();
          return false;
          //do other stuff when a click happens
      });

      /*
      * Carregar info do modal dos estado
      */
      // $('.show').click(function(e) {
          
      //     var id = $(this).attr('id');
      //     $.ajax({
      //         type: 'GET',
      //         url: '/estados/' + id,
      //         success: function(data){
      //             alert(data);
      //         },
      //         dataType: 'html'
      //     });
      //     $("#modal-bodyEstado").html("sdsd");   
      //     $("#myModalEstadoPrevis").modal('show');
      // });

 });
  
  /*
  *   funcao que copia para o clipboard texto
  */
  function copyToClipboard(text)
  {
      if (window.clipboardData) // Internet Explorer
      {  
          window.clipboardData.setData("Text", text);
      }
      else
      {  
          unsafeWindow.netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");  
          const clipboardHelper = Components.classes["@mozilla.org/widget/clipboardhelper;1"].getService(Components.interfaces.nsIClipboardHelper);  
          clipboardHelper.copyString(text);
      }
  }
  /*
  *   funcao que devolve numero de checkbox selecionadas
  */
    function checkTheBox(x)
    {
        var allInputs = document.getElementsByName(x);
        //alert(allInputs.length)
        var flag = 0;
        for (var i = 0, max = allInputs.length; i < max; i++) 
        {
            if (allInputs[i].type == 'checkbox')
              if (allInputs[i].checked == true)
                  flag++;
        }
        return flag;
    }


// $(function () {
//         $('#container').highcharts({
//             chart: {
//                 plotBackgroundColor: null,
//                 plotBorderWidth: null,
//                 plotShadow: false
//             },
//             title: {
//                 text: 'TExto qualquer'
//             },
//             tooltip: {
//               pointFormat: '{series.name}: <b>{point.percentage}%</b>',
//               percentageDecimals: 1
//             },
//             plotOptions: {
//                 pie: {
//                     allowPointSelect: true,
//                     cursor: 'pointer',
//                     dataLabels: {
//                         enabled: true,
//                         color: '#000000',
//                         connectorColor: '#000000',
//                         formatter: function() {
//                             return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
//                         }
//                     }
//                 }
//             },
//             series: [{
//                 type: 'pie',
//                 name: 'Browser share',
//                 data: [
//                     ['Firefox',   45.0],
//                     ['IE',       26.8],
//                     {
//                         name: 'Chrome',
//                         y: 12.8,
//                         sliced: true,
//                         selected: true
//                     },
//                     ['Safari',    8.5],
//                     ['Opera',     6.2],
//                     ['Others',   0.7]
//                 ]
//             }],
//             exporting: {
//           enabled: true
//         }
//         });
//     });


$(function () {
        $('#colunas_graf').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Monthly Average Rainfall'
            },
            subtitle: {
                text: 'Source: WorldClimate.com'
            },
            xAxis: {
                categories: [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Rainfall (mm)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: 'Tokyo',
                data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
    
            }, {
                name: 'New York',
                data: [83.6, 78.8, 98.5, 93.4, 106.0, 84.5, 105.0, 104.3, 91.2, 83.5, 106.6, 92.3]
    
            }, {
                name: 'London',
                data: [48.9, 38.8, 39.3, 41.4, 47.0, 48.3, 59.0, 59.6, 52.4, 65.2, 59.3, 51.2]
    
            }, {
                name: 'Berlin',
                data: [42.4, 33.2, 34.5, 39.7, 52.6, 75.5, 57.4, 60.4, 47.6, 39.1, 46.8, 51.1]
    
            }]
        });
    });
    


