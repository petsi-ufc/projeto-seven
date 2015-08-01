<%-- 
    Document   : index
    Created on : 26/03/2010, 16:35:48
    Author     : fernando
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%
    br.ufc.pet.services.EventoService es = new br.ufc.pet.services.EventoService();
    java.util.ArrayList<br.ufc.pet.evento.Evento> eventos = es.buscarEventosAbertos();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css" />
        <title>Evento</title>
        <%@include file="jquery/jquery.jsp" %>
    </head>
    <body>
        <div id="container">
            <%@include file="menu_index.jsp"%>
            <div id="content">
                <div id="content_left">
                    <h1 class="titulo">Sistema de Eventos</h1>

                    <h2 class="titulo" style="margin-bottom: 1px;">Eventos Abertos para Inscrições</h2>

                    <%if (eventos == null || eventos.size() == 0) {%>
                    <br/><label>Nenhum Evento disponível no momento.</label>
                    <%} else {%>
                    <table id="mytable">
                        <thead>
                            <tr>
                                <th>Evento</th>
                                <th>Sigla</th>
                                <th>Programação</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (br.ufc.pet.evento.Evento e : eventos) {%>
                            <tr>
                                <td> <%= e.getNome()%>  </td>
                                <td> <%= e.getSigla()%> </td>
                                <td> <a href="ServletCentral?comando=CmdVisualizarProgramacao&id=<%=e.getId()%>" title="Programacao" > Visualizar</a> </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                    <% }%>

                </div>
                <div id="content_right">
                    <h1 class="titulo">Login</h1>
                    <center>
                        <form action="ServletCentral" method="post" class="login">
                            <input type="hidden" name="comando" value="CmdLogin" />
                            <fieldset> <!-- para quê é isso mesmo? w3c: -->
                                <legend class="nodisplay">Formulário de Login</legend>
                                <label for="email">E-mail:</label>
                                <input type="text" id="email" name="email" /><br />
                                <label for="senha">Senha:</label>
                                <input type="password" id="senha" name="senha" /><br />                                
                                <label for="conta">Conta:</label>
                                <select name="conta" id="conta">
                                    <option value="null">Escolha uma opção</option>
                                    <option value="participante">Participante</option>
                                    <option value="organizador">Organizador</option>
                                    <option value="administrador">Administrador</option>
                                </select><br /><br />
                                <input type="submit" value="enviar" class="button" /><br />
                                <%@include file="error.jsp" %>
                            </fieldset>
                            <p><a href="recuperar_senha.jsp">Esqueceu sua senha?</a></p>
                        </form>
                    </center>
                    <p>Ainda não possui cadastro? <br /><a href="cadastro.jsp">Cadastre-se aqui!</a></p>
                </div>
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
