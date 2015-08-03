<%--
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : ismaily
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.ufc.pet.evento.Atividade" %>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <%

                ArrayList<Atividade> ats = (ArrayList<Atividade>) session.getAttribute("atividades");


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
                <%@include file="organ_menu.jsp" %>
            </div>
            <div id="content">
                <h1 class="titulo">Atividades</h1>
                <div id="list">
                    <form action="" >
                        <input type="hidden" name="comando"/>
                        <input type="hidden" name="idAtv"/>

                        <%@include file="/error.jsp"%>

                        <%if (ats == null || ats.size() == 0) {%>
                        <label><center>Sem Atividades no momento</center></label><br />
                        <%} else {%>
                        <%
                            for (Atividade at : ats) {%>
                        <ul>
                            <li><a href="../ServletCentral?comando=CmdGerarFrequenciaAtividade&idAtv=<%=at.getId()%>"title=""><%=at.getNome()%> (Relatório em PDF)</a></li>
                            <!--Criar um comando para recuperar a atividade  -->
                            <li><a href="../ServletCentral?comando=CmdGerarFrequenciaAtividadeDownloadHtml&idAtvDw=<%=at.getId()%>"title=""><%=at.getNome()%> (Relatório em HTML)</a></li>
                        </ul>
                        <%}
                                    }%>
                    </form>
                </div>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
