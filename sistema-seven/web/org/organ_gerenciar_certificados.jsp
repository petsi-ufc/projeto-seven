<%--
    Document   : index
    Created on : 23/07/2014, 16:35:48
    Author     : Junior
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
                <h1 class="titulo">Gerenciar emissão de certificados <%=e.getNome()%></h1>

                <table>
                    <tr>

                        <td><form action="../ServletCentral?comando=CmdAlterarPeriodoInscricaoeEvento" method="POST" class="cadastro">
                         <label>Upload do template do certificado: </label><br/>
                         <input type="text" name="inicioEvento" maxlength="10" value="" onkeypress="return formataData(this,event)"><br/>
                         <input type="submit" value="Enviar" class="button" onclick="return confirm('Deseja realmente executar essa modificação?')" />
                         <a href="" title="" onclick="history.back(); return false;" class="voltarCadastro">Voltar</a><br />
                        </form>
                         </td>
                         <td>
                            <br>
                             <p style="text-align: left">
                             <b>Deve ser feito o upload de um template seguindo os passos abaixo:</b><br>
                             1º Faça o download do template de exemplo<a href="#">Aqui</a>.<br>
                             2º Abra com o Power Point<br>
                             3º Edite o modelo de certificado ao seu gosto, porém deixe as ciaxas pretas como estão.)<br>
                             4º Depois apague as caixas pretas. (O sistema irá preencher esses espaços com informações do participante)<br>
                             5º Salve o tempate em formato .jpg<br>
                             6º Faça o upload do template.<br>

                             </p>
                             <br>
                         </td>
                    </tr>
                </table>
                
            </div>
            <div id="footer"></div>
        </div>
    </body>
</html>
