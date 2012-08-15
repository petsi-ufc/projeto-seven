<%-- 
    Document   : organ_gerenciar_modalidade
    Created on : 14/09/2010, 15:57:09
    Author     : Franklin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="br.ufc.pet.evento.ModalidadeInscricao"%>
<%@page import="br.ufc.pet.evento.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="../css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Centro de Controle :: Organizador</title>
    </head>
    <body>
        <%
                    Evento e = (Evento) session.getAttribute("evento");
                    ArrayList<ModalidadeInscricao> modalidades = (ArrayList<ModalidadeInscricao>) session.getAttribute("modalidades");
        %>
        <div id="container">
            <div id="top">
                <%-- Incluindo o Menu --%>
                <%@include file="organ_menu.jsp"%>
            </div>
            <div id="content">
                <h1 class="titulo">Gerenciar Modalidades de Inscriçao do evento <%= e.getNome() %></h1>
                <%@include file="/error.jsp"%>
                <p><a href="organ_add_modalidade.jsp" title="Adicionar Modalidade">Adicionar Modalidade</a></p>
                <table>
                    <%if (modalidades == null || modalidades.size() == 0) {%>
                    <center><label>Sem Modalidades Cadastradas no momento</label></center>
                    <%} else {%>
                    <tr>
                        <th>Nome</th>
                        <th>Alterar | Excluir</th>
                    </tr>                   
                    <%for (ModalidadeInscricao modalidade : modalidades) {%>
                    <tr>
                        <td ><label><%=modalidade.getTipo()%></label></td>
                        <td><a href="../ServletCentral?comando=CmdAtualizarModalidade&mod_id=<%=modalidade.getId()%>" title="Alterar Tipo Modalidade">Alterar</a> |
                            <a href="../ServletCentral?comando=CmdExcluirModalidade&mod_id=<%=modalidade.getId()%>" title="Excluir Tipo Modalidade" onclick="return confirm('Tem certeza que deseja excluir essa de Modalidade?')">Excluir</a></td>
                    </tr>
                    <%}
                                }%>
                </table>
                <p><a href="" title="" onclick="history.back(); return false;" class="voltar">Voltar</a></p>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
