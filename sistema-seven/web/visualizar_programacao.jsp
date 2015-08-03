<%--
    Document   : part_visualizar_programacao
    Created on : 09/09/2010, 15:48:10
    Author     : Welligton Abreu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="br.ufc.pet.evento.Evento"%>
<%@page import="br.ufc.pet.util.UtilSeven"%>
<%@page import="br.ufc.pet.evento.Atividade"%>
<%@page import="br.ufc.pet.evento.Organizador"%>
<%@page import="br.ufc.pet.evento.Participante"%>
<%@page import="br.ufc.pet.evento.Administrador"%>
<%@page import="br.ufc.pet.evento.Horario"%>
<%@page import="br.ufc.pet.evento.ResponsavelAtividade"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <%
        Evento evento = (Evento) session.getAttribute("evento");

    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Centro de Controle :: Administrador</title>
        <script language="javascript" src="jquery/jquery-1.10.2.js"></script>
        <script language="javascript" src="jquery/jquery-ui-1.10.4.custom.min.js"></script>
        <script type="text/javascript" src="jquery/jquery.dataTables.js"></script>
        <script type="text/javascript" src="jquery/initDataTable.js"></script>
    </head>
    <body>
        <div id="container">
            <%@include file="menu_index.jsp"%>

            <div id="content">
                <!--<div id="content_left"></div>-->
                <h1 class="titulo">Programação</h1>
                <%                    ArrayList<Horario> horarios = br.ufc.pet.util.UtilSeven.getHorariosByEvento(evento.getId());
                    Date diaComum = new Date(0L);
                    int count = 0;
                    for (Horario h : horarios) {
                        for (Atividade a : evento.getAtividades()) {
                            if (!h.getDia().equals(diaComum)) {
                                diaComum = h.getDia();
                                if (count > 0) {%>
                <!-- Table utilizado para balancear as tabelas-->
                </table>



                <%}%>
                <h2 class="titulo"><%=UtilSeven.treatToLongString(h.getDia())%></h2>
                <table id="data_table" class="extend">
                    <thead>
                        <tr>
                            <th>Horário</th>
                            <th>Nome da Atividade</th>
                            <th>Tipo de Atividade</th>
                            <th>Local</th>
                            <th>Ministrante</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%count++;
                        }
                        if (a.temHorario(h.getId())) {%>
                        <tr>
                            <td><%=h.exibirFormatoSimples()%></td>
                            <% String nome = a.getNome();%>
                            <td><%=nome%></td>

                            <% String tipo = a.getTipo().getNome();%>
                            <td><%=tipo%></td>
                            <% String local = a.getLocal();%>
                            <td><%=local%></td>
                            <%
                                String nomePessoal = "";
                                for (ResponsavelAtividade r : a.getResponsaveis()) {
                                nomePessoal += r.getUsuario().getNome() + "<br>";
                            }%>
                            <td><%=nomePessoal%></td>
                        </tr>
                        <%             }
                            }
                        }
                        if (horarios.size() > 0) {%>
                    </tbody>
                </table>
                <%}%>
                <p><a href="" title="" onclick="history.back();
                        return false;" class="voltar">Voltar</a></p>
            </div>
            <div id="footer"></div>
        </div>

    </body>
</html>
