/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.administrador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.Organizacao;
import br.ufc.pet.evento.Organizador;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.OrganizacaoService;
import br.ufc.pet.services.OrganizadorService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ismaily
 */
public class CmdExcluirOrganizador implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();
        Evento en = (Evento) session.getAttribute("evento");
        //System.out.println("evento id: "+en.getId());
        Long id = Long.parseLong(request.getParameter("idUsuario"));
        //System.out.println("Id Usuario: "+id);
        int i = 0;
        OrganizadorService orgS = new OrganizadorService();
        Organizador org = orgS.getByUsuarioId(id);
        //System.out.println("Id Organizador: "+org.getId());
        Organizacao orga = new Organizacao();
        orga.setEvento(en);
        orga.setOrganizador(org);
        OrganizacaoService orgaS = new OrganizacaoService();
        if (org.deleteOrganizacao(en)) {
            //System.out.println("deleta a organizacacao do organizador");
            if (orgaS.delete(orga)) {

                //System.out.println("deleta a organizacacao do banco");
                if (en.deleteOrganizador(org)) {
                    //System.out.println("remove o organizador do evento");
                    session.setAttribute("evento", en);
                    session.setAttribute("sucesso", "Excluido com sucesso!");
                    return "/admin/organ_listar_movimentacao.jsp";
                }
            }
        }
        session.setAttribute("erro", "Erro ao Excluir!");
        return "/admin/organ_listar_movimentacao.jsp";

    }
}
