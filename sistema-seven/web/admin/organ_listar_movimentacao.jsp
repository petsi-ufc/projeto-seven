<%--
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.ufc.pet.evento.Evento" %>
<%@page import="br.ufc.pet.services.EventoService"%>
<%@page import="br.ufc.pet.evento.Organizador"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <%
                Evento event = (Evento) session.getAttribute("evento");
                ArrayList<Organizador> orgs = event.getOrganizadores();
    %>
    <head>
        <script type="text/javascript"  language="javascript" src="../Script.js"></script>
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
                <h1 class="titulo">Gerenciar organizadores do evento <%=event.getNome()%></h1>
                <a style="font-size: medium;" href="admin_buscar_organ.jsp" title="Adicionar Organizador">Adicionar um organizador</a>
                <form action="" >
                    <input type="hidden" name="idUsuario"/>
                    <input type="hidden" name="idEvento"/>
                    <table style="margin-top: 15px;">
                        <%@include file="/error.jsp"%>
                        <%if (orgs == null || orgs.size() == 0) {%>
                        <label><center>Evento sem Organizadores no momento</center></label><br />
                        <%} else {%>
                        <h2 class="titulo">Atuais organizadores deste evento:</h2>
                        <tr>
                            <th>Nome</th>
                            <th>Alterar / Excluir</th>
                        </tr>
                        <%for (Organizador org : orgs) {%>
                        <tr>
                            <td><%=org.getUsuario().getNome()%></td>
                            <td><a href="../ServletCentral?comando=CmdExibirOrganizadorEditar&idUsuario=<%=org.getUsuario().getId()%>" title="Alterar Eventos">Alterar</a> |
                                <a href="../ServletCentral?comando=CmdExcluirOrganizador&idUsuario=<%=org.getUsuario().getId()%>" title="Excluir Eventos" onclick="return confirmarExclucao()">Excluir</a></td>
                        </tr>
                        <%}%>
                        <%}%>
                    </table>
                </form>
                <p><a href="" title="" onclick="history.back(); return false;" class="voltar">Voltar</a></p>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
