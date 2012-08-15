<%-- 
    Document   : programacao
    Created on : 07/03/2011, 20:58:05
    Author     : Welligton
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            br.ufc.pet.services.EventoService es = new br.ufc.pet.services.EventoService();
            java.util.ArrayList<br.ufc.pet.evento.Evento> eventos = es.buscarEventosAbertos();
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Evento</title>
    </head>
    <body>

        <div id="container">
            <%@include file="menu_index.jsp"%>
        </div>

        <div id="content">
            <center>
                <label style="color:navy;">Eventos Abertos para Inscrições</label>
            </center><br/>
            <table>
                <tr>
                    <th>Evento</th>
                    <th>Sigla</th>
                    <th>Programação</th>
                </tr>
                <%if (eventos != null) {%>
                <% for (br.ufc.pet.evento.Evento e : eventos) {%>
                <tr>
                    <td> <%= e.getNome()%>  </td>
                    <td> <%= e.getSigla()%> </td>
                    <td> <a href="ServletCentral?comando=CmdVisualizarProgramacao&id=<%=e.getId()%>" title="Programacao" > Visualizar</a> </td>
                </tr>
                <% }%>
                <% }%>
            </table>
        </div><br/><br/><br/><br/><br/>
        <div id="footer"></div>
    </body>
</html>
