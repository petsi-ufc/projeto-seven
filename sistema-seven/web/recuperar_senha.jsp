<%-- 
    Document   : recuperar_senha
    Created on : 25/08/2010, 16:23:51
    Author     : Escritorio projetos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Evento</title>
    </head>
    <body>
        <div id="container">
            <%@include file="menu_index.jsp"%>
            <br/>
            <form id="form_recuperar_senha" action="ServletCentral?comando=CmdRecuperarSenha" method="POST" class="box_destaque cadastro">
                <fieldset>
                    <label>Digite aqui o email que voce cadastrou:</label><br/><br/>
                    <input type="text" name="email" class="buscar" style="width: 350px"/><br/><br/>
                    <input type="submit" value="Enviar"  class="button"/>
                </fieldset>
            </form>
            <br/>
            <div id="footer"></div>
        </div>
    </body>
</html>

