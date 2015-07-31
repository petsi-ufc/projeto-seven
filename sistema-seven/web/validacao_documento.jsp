<%-- 
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%
            br.ufc.pet.services.EventoService es = new br.ufc.pet.services.EventoService();
            java.util.ArrayList<br.ufc.pet.evento.Evento> eventos = es.buscarEventosAbertos();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Evento</title>
    </head>
    <body>
        <div id="container">
            <%@include file="menu_index.jsp"%>
            <div id="content">
                <div  class="validacaoCertificado">
                    <div id="content_left">
                        <h1 class="titulo">Validação de documentos</h1>
                        <p class="caixaValidarDoc">
                            Para validar um documento gerado pelo SEVEN, Informe o código de validação, localizado na parte inferior do documento.
                        </p>
                    </div>
                    <div id="content_right">
                        <h1 class="titulo">Informe o código de validação</h1>
                        <form action="ServletCentral" method="post" class="login">
                            <input type="hidden" name="comando" value="CmdValidarDocumento" />
                            <fieldset> <!-- para quê é isso mesmo? w3c: -->
                                <label for="codigo">Código:</label>
                                <input type="text" id="codigo" name="codigo" /><br>
                                    <center><input type="submit" value="Validar Documento" class="button" style="width: 80%; height: 20px;margin-top: 5px;" /></center><br>
                                
                            </fieldset>
                        </form>
                            
                            
                    </div>
                </div>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
