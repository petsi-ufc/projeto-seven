<%--
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.ufc.pet.evento.Evento" %>
<%@page import=" br.ufc.pet.util.UtilSeven" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<%@include file="../ErroAutenticacaoUser.jsp" %>

<%

            Evento evento = (Evento) session.getAttribute("evento");
            session.removeAttribute("evento");
            String men = (String) session.getAttribute("men");
            session.removeAttribute("men");
            String comando = "Adicionar";

            String sigla = (String)session.getAttribute("siglaEvento");
            session.removeAttribute("siglaEvento");
            if(sigla==null)
                sigla="";

            String nome = (String)session.getAttribute("nomeEvento");
            session.removeAttribute("nomeEvento");
            if(nome==null)
                nome="";

            String tema = (String)session.getAttribute("tema");
            session.removeAttribute("tema");
            if(tema == null)
                tema="";
 
            String inicioIn = (String)session.getAttribute("inicioInscricao");
            session.removeAttribute("inicioInscricao");
            if(inicioIn == null)
                inicioIn="";

            String fimIn = (String)session.getAttribute("fimInscricao");
            session.removeAttribute("fimInscricao");
            if(fimIn == null)
                fimIn="";

            String descricao = (String)session.getAttribute("descricao");
            session.removeAttribute("descricao");
            if(descricao == null)
                descricao="";

            String limiteDeAtividadesPorParticipante = (String)session.getAttribute("limiteDeAtividadesPorParticipante");
            session.removeAttribute("limiteDeAtividadesPorParticipante");
            if(limiteDeAtividadesPorParticipante == null)
                limiteDeAtividadesPorParticipante="";

            String inicioEvento = (String)session.getAttribute("inicioEvento");
            session.removeAttribute("inicioEvento");
            if(inicioEvento == null)
                inicioEvento="";
            
            String fimEvento = (String)session.getAttribute("fimEvento");
            session.removeAttribute("inicioEvento");
            if(fimEvento == null)
                fimEvento="";

            if (evento != null) {
                comando = "Visualizar/Alterar";
                sigla = evento.getSigla();
                nome = evento.getNome();
                tema = evento.getTema();
                inicioIn = UtilSeven.treatToString(evento.getInicioPeriodoInscricao());
                fimIn = UtilSeven.treatToString(evento.getFimPeriodoInscricao());
                limiteDeAtividadesPorParticipante = evento.getLimiteAtividadePorParticipante()+"";
                descricao = evento.getDescricao();
                inicioEvento = UtilSeven.treatToString(evento.getInicioPeriodoEvento());
                fimEvento = UtilSeven.treatToString(evento.getFimPeriodoEvento());
            }
%>
<html>
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
                <h1 class="titulo"> <%=comando%> Evento</h1>
                <%@include file="/error.jsp" %>
                <%if (men != null) {%>
                <center style="color: red"><label><%=men%></label></center>
                <%}%>
                <form action="../ServletCentral?comando=CmdAdicionarEvento&operacao_evento=<%=evento == null ? 0 : evento.getId()%>" method="post" class="cadastro">
                    <fieldset>
                        <h2 class="titulo">Dados do evento</h2>
                        <label>Nome:</label><br />
                        <input type="text" name="nome_evento" value="<%=nome%>" /><br />
                        <label>Sigla:</label><br />
                        <input type="text" name="sigla_evento" value="<%=sigla%>" /><br />
                        <label>Tema:</label><br />
                        <input type="text" name="tema_evento" value="<%=tema%>"/><br />
                        <label>Inicio do Evento:</label><br />
                        <input type="text" name="inicio_evento" value="<%=inicioEvento%>" maxlength="10" onkeypress="return formataData(this,event)"/><br />
                        <label>Fim do Evento:</label><br />
                        <input type="text" name="fim_evento" value="<%=fimEvento%>" maxlength="10" onkeypress="return formataData(this,event)"/><br />
                        <label>Inicio do Periodo de Inscrição:</label><br />
                        <input type="text" name="inicio_periodo_inscricao" value="<%=inicioIn%>" maxlength="10" onkeypress="return formataData(this,event)"/><br />
                        <label>Fim do Periodo de Inscrição:</label><br />
                        <input type="text" name="fim_periodo_inscricao" value="<%=fimIn%>" maxlength="10" onkeypress="return formataData(this,event)"/><br />
                        <label>Maximo de atividades por participante (Digite 0 (zero) para ilimitado):</label><br />
                        <input type="text" name="limite_de_atividades_por_participante" value="<%=limiteDeAtividadesPorParticipante%>" onkeypress="return validaNumerosSilencioso(event)"/><br />
                        <label>O evento é gratuito?</label><br />
                        <input type="radio" name="gratuito" value="true" class="radio"/>
                        <label style="float: left">Sim</label><br />
                        <input type="radio" name="gratuito" value="false" class="radio" checked />
                        <label style="float: left">Não</label><br />
                        <label>Descrição:</label><br />
                        <textarea cols="1" rows="10" name="descricao"><%=descricao%></textarea>
                    </fieldset>
                    <input type="submit" value="Enviar" class="button" onclick="return confirmarCadastrado()" />
                    <a href="" title="" onclick="history.back(); return false;" class="voltarCadastro">Voltar</a><br />
                </form>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
