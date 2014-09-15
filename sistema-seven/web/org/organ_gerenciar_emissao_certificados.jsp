<%--
    Document   : index
    Created on : 27/08/2014
    Author     : Anderson
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="br.ufc.pet.evento.Atividade,br.ufc.pet.evento.Organizador,br.ufc.pet.evento.Organizacao,br.ufc.pet.evento.ResponsavelAtividade" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <head>      
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="../css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Centro de Controle :: Organizador</title>
    </head>
    <body>
        <%
                    br.ufc.pet.evento.Evento e = (br.ufc.pet.evento.Evento) session.getAttribute("evento");
                    Organizador organizador = (Organizador) session.getAttribute("user");
                    ArrayList<Atividade> ats = e.getAtividades();
        %>
        <div id="container">
            <div id="top">
                <%-- Incluindo o Menu --%>
                <%@include file="organ_menu.jsp"%>
            </div>
            <div id="content">
                <h1 class="titulo">Gerenciar Emissão de Certificados por Atividades do evento <%=e.getNome()%></h1>
                <%@include file="/error.jsp" %>
                <% if (organizador.recuperarOrganizaçãoByEvendoId(e.getId()).getManterAtividade()) {%>
                
                
                <%}%>
                <%if (ats == null || ats.size() == 0) {%>
                <center><label>Sem atividades no momento</label></center>
                <%} else {%>
                <table>
                    <tr>
                        <th>Nome</th>
                        <th>Tipo</th>
                        <th>Capacidade</th>
                        <th>Local</th>
                        <th>Responsável</th>
                        <th>Liberar Certificados</th>
                    </tr>
                    <%for (Atividade a : ats) {%>
                    <tr>
                        <td><%=a.getNome()%></td>
                        <td><%=a.getTipo().getNome() %></td>
                        <td><%=a.getVagas()%></td>
                        <td><%=a.getLocal()%></td>
                        <% java.lang.StringBuffer sb = new java.lang.StringBuffer("");
                            for (ResponsavelAtividade ra : a.getResponsaveis()) {
                                sb.append(ra.getUsuario().getNome());
                                sb.append("<br>");
                            }%>
                        <td><%=sb.toString()%></td>
                        <td><a href="../ServletCentral?comando=CmdGerenciarLiberacaoCertificadoAtividade&ativ_id=
                               <%=a.getId()%>" title="Liberar Certificados">Liberar</a></td>
                    </tr>
                    <%}%>
                </table>
                <% }%>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
