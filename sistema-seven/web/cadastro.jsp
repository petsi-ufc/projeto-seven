<%--
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String mensagem = (String)request.getAttribute("mensagem");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="Script.js"> </script>
        <title>Cadastr SEven</title>
    </head>
    <body>
        <div id="container">
            <%@include file="menu_index.jsp"%>
            <div id="content">
                <h1 class="titulo">Cadastro</h1>
                <%if (mensagem != null) {%>
                <h3><%=mensagem%></h3><br />
                <% } %>
                <form action="ServletCentral" method="post" class="cadastro">
                    <input type="hidden" name="comando" value="CmdCadastrarParticipante" />
                    <fieldset>
                        <%@include file="error.jsp" %>
                        <label style="float: right;">* Campos obrigatórios</label><br/>
                        <label>Nome Completo (*):</label><br />
                        <input type="text" maxlength="50" name="nome" /><br />
                        <label>E.mail (*):</label><br />
                        <input type="text" maxlength="50" name="email" /><br />
                        <label>Instituição:</label><br />
                        <input type="text" maxlength="50" name="instituicao" /><br />
                        <label>Senha (*):</label><br />
                        <input type="password" maxlength="50" name="senha" /><br />
                        <label>Repita a senha (*):</label><br />
                        <input type="password" maxlength="50" name="r-senha" /><br />
                    </fieldset>
                    <input type="submit" value="Enviar" class="button" />
                    <a href="" title="" onclick="history.back(); return false;" class="voltarCadastro">Voltar</a>
                </form>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
