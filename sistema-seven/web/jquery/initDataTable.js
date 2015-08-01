$(document).ready(function () {
    
    $('#mytable').dataTable({
        "bPaginate": false,
        "bJQueryUI": true,
        "scrollY": "",
        "scrollCollapse": true,
        "paging": false,
        /*"sPaginationType" : "full_numbers",*/
        "oLanguage": {
            "sLengthMenu": "Mostrar _MENU_ registros",
            "sZeroRecords": "<b>Nenhum registro</b>",
            "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
            "sInfoEmpty": "Nenhum registro",
            "sInfoFiltered": "(filtrado de um total de _MAX_ registros)",
            "sSearch": "<span style='color: #0E464E; font-family: Verdana, Tahoma, Arial;'>Filtrar:</span>",
            "sInfoPostFix": "",
            "sUrl": "",
            "oPaginate": {
                "sFirst": "Primeira",
                "sPrevious": "Anterior",
                "sNext": "Seguinte",
                "sLast": "Última"
            }
        }
    });
        
});
