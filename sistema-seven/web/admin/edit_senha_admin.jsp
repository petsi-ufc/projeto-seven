<%-- 
    Document   : gerencia_conta
    Created on : 02/07/2013, 10:26:01
    Author     : mardson
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.ufc.pet.evento.Participante" %>
<%@page import="br.ufc.pet.util.UtilSeven" %>
<%@page import="br.ufc.pet.evento.Administrador" %>
<%@page import="java.util.Date" %>
<%@include file="../ErroAutenticacaoUser.jsp" %>
<%
          
            Administrador admin = (Administrador) session.getAttribute("user");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="../css/estilo.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="Script.js"> </script>
        <title>Gerenciar Conta</title>
    </head>
    <body>
        <div id="container">
            <div id="top">
                <%@include file="admin_menu.jsp" %>
            </div>
            <div id="content">
                <h1 class="titulo">Alterar Senha</h1>
                <form action="../ServletCentral" method="post" class="cadastro">
                    <fieldset style="margin-top: 0px; margin-bottom: -40px;">
                        <label>Digite a senha (*):</label><br />
                       <input type="password" maxlength="50" name="senha" /><br />
                        <label>Repita a senha (*):</label><br />
                        <input type="password" maxlength="50" name="rsenha" /><br />
                        <input type="hidden" value="CmdEditAdmin" name="comando">
                        <input type="hidden" value="<%=admin.getUsuario().getId()%>" name="id">
                        <br>
                    <input type="submit" value="Atualizar" style="margin-left:0px;" class="button" onclick="return confirmarCadastrado()" />

                    </fieldset>
              
                                 
                   
                
           </form>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
