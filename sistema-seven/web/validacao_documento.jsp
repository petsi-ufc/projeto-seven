<%-- 
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page import="br.ufc.pet.evento.Atividade"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.ufc.pet.util.UtilSeven"%>
<%@page import="br.ufc.pet.evento.Evento"%>
<%@page import="br.ufc.pet.evento.Inscricao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%
    br.ufc.pet.services.EventoService es = new br.ufc.pet.services.EventoService();
    java.util.ArrayList<br.ufc.pet.evento.Evento> eventos = es.buscarEventosAbertos();

    Inscricao inscricao = (Inscricao) session.getAttribute("dados_inscricao");
    session.removeAttribute("dados_inscricao");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Evento</title>
        <script language="javascript" src="jquery/jquery-1.10.2.js"></script>
        <script language="javascript" src="jquery/jquery-ui-1.10.4.custom.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.dataTables.js"></script>
        <script type="text/javascript" src="jquery/initDataTable.js"></script>
    </head>
    <body>
        <div id="container">
            <%@include file="menu_index.jsp"%>
            <%@include file="error.jsp" %>
            <div id="content">
                <% if (inscricao == null) { %>
                <div  class="validacaoCertificado">
                    <div id="content_left">
                        <h1 class="titulo">Validação de documentos</h1>
                        <p class="caixaValidarDoc">
                            Para validar um documento gerado pelo SEVEN, Informe o código de validação, localizado na parte inferior do documento.
                        </p>
                    </div>
                    <div id="content_right">
                        <h1 class="titulo">Informe o código de validação</h1>
                        <form action="ServletCentral" method="post" class="login">
                            <input type="hidden" name="comando" value="CmdValidarDocumento" />
                            <fieldset> <!-- para quê é isso mesmo? w3c: -->
                                <label for="codigo">Código:</label>
                                <input type="text" id="codigo" name="codigo" /><br>
                                    <center><input type="submit" value="Validar Documento" class="button" style="width: 80%; height: 20px;margin-top: 5px;" /></center>
                            </fieldset>
                        </form>


                    </div>
                </div>
                <% } else {%>

                <center><h1 class="titulo">Informações do documento</h1></center>

                <div  class="validacaoCertificado">
                    <div id="content_left">
                        <h3 class="titulo">Proprietário do documento: </h3>
                        <span class="docInfo">
                            <%=inscricao.getParticipante().getUsuario().getNome()%>
                        </span>
                        <br><br>
                                <h3 class="titulo">Evento: </h3>
                                <span class="docInfo">
                                    <%=(inscricao.getEvento().getNome() + " - " + inscricao.getEvento().getSigla())%>
                                </span>
                                <br><br>
                                        <h3 class="titulo">Período do evento: </h3>
                                        <span class="docInfo">
                                            <%=(UtilSeven.treatToString(inscricao.getEvento().getInicioPeriodoEvento()) + " até " + UtilSeven.treatToString(inscricao.getEvento().getFimPeriodoEvento()))%>
                                        </span>
                                        <br><br>
                                                </div>
                                                <div id="content_right">
                                                    <center><h3  class="titulo" style="text-indent: 0px;">Atividades realizadas no evento: </h3></center>
                                                    <table id="data_table" style="margin-top: 7px;">
                                                        <thead>
                                                            <tr>
                                                                <th>Nome</th>
                                                                <th>Carga Horária</th>
                                                                <th>Local</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (Atividade a : inscricao.getAtividades()) {%>
                                                            <tr>
                                                                <td><%=a.getNome()%></td>
                                                                <td><%=a.getCargaHoraria()%></td>
                                                                <td><%=a.getLocal()%></td>
                                                            </tr>
                                                            <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                                </div>


                                                <% }%>
                                                </div>
                                                <div id="footer"></div>
                                                </div>
                                                </body>
                                                </html>
