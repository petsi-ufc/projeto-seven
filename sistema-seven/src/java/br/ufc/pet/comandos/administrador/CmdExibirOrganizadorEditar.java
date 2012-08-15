/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.administrador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.Organizacao;
import br.ufc.pet.evento.Organizador;
import br.ufc.pet.evento.Usuario;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.OrganizadorService;
import br.ufc.pet.services.UsuarioService;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ismaily
 */
public class CmdExibirOrganizadorEditar implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {


        Long id = Long.parseLong(request.getParameter("idUsuario"));
        Usuario u = new UsuarioService().getById(id);
        HttpSession session = request.getSession();
        Evento en = (Evento) session.getAttribute("evento");
        OrganizadorService orgS = new OrganizadorService();
        Organizador org = orgS.getByUsuarioId(id);
        if (org != null) {
            //     System.out.println("peguei org");
            ArrayList<Organizacao> array = org.getOrganizacoes();
            //      System.out.println("ver se tem organizacaoe");
            //    System.out.println(array!=null);
            for (Organizacao orga : array) {
                if (orga.getEvento().getId().equals(en.getId())) {
                    session.setAttribute("organizacao", orga);
                    //System.out.println("Já é organizador");
                }
            }

        }
        session.setAttribute("uEditar", u);
        return "/admin/editar_organ.jsp";
    }
}
