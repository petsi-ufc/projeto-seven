<%--
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.ufc.pet.evento.Evento" %>
<%@page import="br.ufc.pet.evento.Administrador" %>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <%
                Administrador admin = (Administrador) session.getAttribute("user");
                ArrayList<Evento> eventos = admin.getEventos();
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="../css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Centro de Controle :: Administrador</title>
    </head>
    <body>
        <div id="container">
            <div id="top">
                <%-- Incluindo o Menu --%>
                <%@include file="admin_menu.jsp" %>
            </div>
            <div id="content">
                <form action="" >
                    <input type="hidden" name="comando"/>
                    <input type="hidden" name="idEvento"/>
                    <h1 class="titulo">Gerenciar Organizadores</h1>
                    <p>Escolha o evento do qual você deseja gerenciar os organizadores:</p>
                    <div id="list">
                        <%if (eventos == null || eventos.size() == 0) {%>
                        <center><label>Sem eventos no momento</label></center>
                        <%}%>
                        <h2 class="titulo">Eventos atuais:</h2>
                        <ul>
                            <%for (Evento event : admin.getEventos()) {%>
                            <li><a href="../ServletCentral?comando=CmdListarOrganizadorEventos&idEvento=<%=event.getId()%>"><%=event.getNome()%> - <%=event.getSigla() %></a></li>
                            <%}%>
                        </ul>
                    </div>
                </form>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
