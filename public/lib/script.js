$(document).ready(function() {

	/*
	* funcoes para editar tabela
	*/
    $("#sortable tbody").sortable().disableSelection();
    $(".sortable1").stupidtable();
    
    
    /*
	* Funcao que seleciona todos os checkboxes
	*/
    $('#select-all').click(function (event) {
           var selected = this.checked;
           // Iterate each checkbox
           $(':checkbox[name="select-all"]').each(function () {    
           			this.checked = selected; 
           });

    });
    
   $(document).bind('keydown', function(e) {
      if (e.ctrlKey && e.which === 78 && window.location == "http://localhost:8888/temp1/formulario_membros.html" ){
	    window.location = "http://localhost:8888/temp1/nova_pergunta.html";
	    event.preventDefault(); 
	  }
	});
	

    
});