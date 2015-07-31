/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos;

import br.ufc.pet.evento.Administrador;
import br.ufc.pet.evento.Organizador;
import br.ufc.pet.evento.Participante;
import br.ufc.pet.evento.Perfil;
import br.ufc.pet.evento.Usuario;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.EventoService;
import br.ufc.pet.services.UsuarioService;
import br.ufc.pet.util.UtilSeven;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Escritorio projetos
 */
public class CmdLogin implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String conta = request.getParameter("conta");
        /*String capt = request.getParameter("captcha");
        String captcha = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);

        if (!captcha.equals(capt)) {
            session.setAttribute("erro", "Código da imagem incorreto.");
            return "/index.jsp";
        }*/


        if (senha == null || email == null || conta == null || senha.trim().isEmpty()
                || email.trim().isEmpty() || conta.trim().isEmpty()) {
            session.setAttribute("erro", "Preencha todos os campos.");
        } else {
            Usuario user = new Usuario();
            user.setEmail(email);
            user.setSenha(UtilSeven.criptografar(senha));
            //System.out.println("email: "+email);
            //System.out.println("senha: "+senha);

            UsuarioService userService = new UsuarioService();
            Perfil perfil = userService.validaUsuario(user, conta);

            if (perfil == null) {
                //System.out.println("Perfil nulo");
                session.setAttribute("erro", "Usuario e senha não conferem.");
            } else if (perfil instanceof Participante) {
                //System.out.println("Participante id " + perfil.getId());
                session.setAttribute("user", perfil);
                EventoService es = new EventoService();
                session.setAttribute("eventosAbertos", es.buscarEventosComInscricoesAbertas());
                return "/part/index.jsp";
            } else if (perfil instanceof Organizador) {
                //System.out.println("Organizador id " + perfil.getId());
                session.setAttribute("user", perfil);
                return "/org/index.jsp";
            } else if (perfil instanceof Administrador) {
                System.out.println("Administrador IDDDDDDDDDDDDDDDDDDDDDDD: " + perfil.getId());
                session.setAttribute("user", perfil);
                return "/admin/index.jsp";
            }
        }

        return "/index.jsp";


        /*if (senha != null && email != null && conta != null && !senha.trim().isEmpty() && !email.trim().isEmpty() && !conta.trim().isEmpty()) {
        Usuario usuario = null;
        UsuarioDAO uDao;
        try {
        uDao = new UsuarioDAO();
        // usuario = uDao.buscarUsuario(email, senha);
        usuario = uDao.getByEmail(email);
        System.out.print("-->" + usuario.getNome());
        if (usuario != null) {
        if (usuario.validaSenha(senha)) {
        if (conta.equals("Participante")) {
        System.out.print("Participante... !");
        Participante participante = null;
        ParticipanteDAO pDAO = new ParticipanteDAO();
        participante = pDAO.getById(usuario.getId());
        session.setAttribute("participante", participante);
        //debug
        System.out.println(participante.getUsuario().getNome() + " " + participante.getDataCriacao() + " " + participante.isStatus());
        return "/part/index.jsp";
        } else if (conta.equals("Organizador")) {
        System.out.println("Organizador...");
        Organizador org = null;
        OrganizadorDAO oDao = new OrganizadorDAO();
        System.out.println(usuario.getId());
        org = oDao.getById(usuario.getId());
        session.setAttribute("organizador", org);
        //debug
        System.out.println(org.getUsuario().getNome());


        return "/org/index.jsp";

        } else if (conta.equals("Administrador")) {
        System.out.println("Administrador...");
        Administrador admin = null;
        AdministradorDAO aDao = new AdministradorDAO();
        admin = aDao.getById(usuario.getId());
        session.setAttribute("administrador", admin);
        //debug
        System.out.println(admin.getUsuario().getNome());
        return "/admin/index.jsp";
        }
        } else {
        System.out.print("Senha Invalida!");
        }
        } else {
        }
        } catch (Exception ex) {
        ex.printStackTrace();
        System.err.print("Falha na autenticacao!");
        }
        }
        return "/index.jsp";*/
    }
}
