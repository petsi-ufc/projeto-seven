/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Evento;
import br.ufc.pet.interfaces.Comando;
import java.util.Collections;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Escritorio projetos
 */
public class CmdVisualizarAtividade implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
    HttpSession session=request.getSession(true);


       String ativ_id = request.getParameter("ativ_id");
        Long id = Long.parseLong(ativ_id);
        //Atividade atividade=atividadeService.getAtividadeById(id);
        Evento eventoSessao = (Evento) session.getAttribute("evento");
        Atividade atividade = eventoSessao.recuperarAtividadeCadastrada(id);
        Collections.sort(atividade.getHorarios());
        session.setAttribute("atividade", atividade);
        //session.setAttribute("atividades", atividades);
        return "/org/organ_visualizar_atividade.jsp";    }

}
