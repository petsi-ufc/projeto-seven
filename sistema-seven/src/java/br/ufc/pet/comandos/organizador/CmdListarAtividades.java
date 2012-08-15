/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.interfaces.Comando;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Escritorio projetos
 */
public class CmdListarAtividades implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        //AtividadeService ativServ=new AtividadeService();
        //Evento eventoAtual=(Evento) session.getAttribute("evento");
        //ArrayList<Atividade> atividades=ativServ.getAtividadeByEventoId(eventoAtual.getId());
        //session.setAttribute("atividades", atividades);
        return "/org/organ_gerenciar_atividades.jsp";
    }
}
