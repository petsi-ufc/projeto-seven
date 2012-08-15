/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos;

import br.ufc.pet.evento.Usuario;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.UsuarioService;
import br.ufc.pet.util.SendMail;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Escritorio projetos
 */
public class CmdRecuperarSenha implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {

        String email = request.getParameter("email");
        UsuarioService us = new UsuarioService();
        Usuario usuario = us.getByEmail(email.trim());
        HttpSession session= request.getSession(true);
        String mensagem = "";
        if (usuario == null) {
            mensagem = "Caro Usuario o seu email nao esta cadastrado em nossa base de dados! Caso deseje acessar nosso sistema efetue seu cadastro! Obrigado";
        } else {
            mensagem = "Prezado(a) " + usuario.getNome() + " "
                    + "A sua senha e: " + usuario.getSenha();
        }
        try {
            SendMail.sendMail(email, "SENHA DO SEVEN!", mensagem);
            session.setAttribute("sucesso","Sua senha foi enviada com sucesso para o e-mail: "+email);

        } catch (Exception ex) {
            System.err.println("Erro ao enviar o seu email!");
        }
        return "/index.jsp";
    }
}
