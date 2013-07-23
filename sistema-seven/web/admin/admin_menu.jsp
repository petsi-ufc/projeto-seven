<%-- 
    Document   : admin_menu
    Created on : 14/07/2010, 16:08:24
    Author     : fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div id="menu">
    <ul>
        <li><a href="index.jsp" title="Página Inicial">Home</a></li>
        <li><a href="../ServletCentral?comando=CmdListarEventos" title="Gerenciar Eventos">Gerenciar Eventos</a></li>
        <li><a href="manege_orgs.jsp" title="Gerenciar Organizadores">Gerenciar Organizadores</a></li>
        <li><a href="edit_senha_admin.jsp" title="Alterar Senha">Alterar Senha</a></li>
        <li><a href="../ServletCentral?comando=CmdLogout" title="Logout">Logout</a></li>
    </ul>
</div>
