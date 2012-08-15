<%-- 
    Document   : organ_add_modalidade
    Created on : 21/09/2010, 15:27:53
    Author     : Franklin
--%>

<%@page import="br.ufc.pet.evento.PrecoAtividade"%>
<%@page import="br.ufc.pet.evento.ModalidadeInscricao"%>
<%@page import="br.ufc.pet.util.UtilSeven"%>
<%@page import="br.ufc.pet.evento.TipoAtividade"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.ufc.pet.evento.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <%@include file="../ErroAutenticacaoUser.jsp" %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="../css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Centro de Controle :: Administrador</title>
        <script type="text/javascript" src="../Script.js"> </script>
    </head>
    <body>
        <%
                    Evento e = (Evento) session.getAttribute("evento");
                    ArrayList<TipoAtividade> tipos = UtilSeven.getTiposDeAtividadeByEventoId(e.getId());
                    ModalidadeInscricao modalidade = (ModalidadeInscricao) session.getAttribute("atualiazar_modalidade");
                    session.removeAttribute("atualiazar_modalidade");
                    Double valor = 0.0;
                    String nome = "";
                    String id = "";
                    if (modalidade != null) {
                        nome = modalidade.getTipo();
                        id = modalidade.getId().toString();
                    }
        %>
        <div id="container">
            <div id="top">
                <%-- Incluindo o Menu --%>
                <%@include file="organ_menu.jsp" %>
            </div>
            <div id="content">
                <h1 class="titulo">Adicionar Modalidade</h1>
                <%@include file="/error.jsp" %>
                <form action="../ServletCentral?comando=CmdAdicionarModalidade&id_atualizar=<%=id%>" method="post" class="cadastro">
                    <fieldset>
                        <label >Modalidade:</label><br>
                        <input type="text" name="nomeModalidade" value="<%=nome%>"/><br
                    </fieldset>
                    <table border="1">
                        <tr>
                            <th>Tipo de Atividade</th>
                            <th>Preço de inscrição com esta modalidade</th>
                        </tr>
                        <%for (TipoAtividade tp : tipos) {%>
                        <tr>
                            <%if (modalidade != null) {
                                    for (PrecoAtividade p : modalidade.getPrecoAtividades()) {
                                        if (p.getTipoAtividadeId() == tp.getId()) {
                                            valor = p.getValor();
                                            break;
                                        }
                                    }
                                }%>
                            <td><%=tp.getNome()%></td>
                            <td><input type="text" name="preco_<%=tp.getId()%>" value="<%=valor%>" size="10" /></td>
                        </tr>
                        <%valor = 0.0;
                                    }%>
                    </table>
                    <input type="submit" value="Enviar" class="button" onclick="return confirm('Deseja realmente enviar esses dados?')" />
                    <a href="" title="" onclick="history.back(); return false;" class="voltarCadastro">Voltar</a>
                </form>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
