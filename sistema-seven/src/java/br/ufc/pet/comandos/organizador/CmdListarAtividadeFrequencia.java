/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Evento;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.AtividadeService;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ismaily
 */
public class CmdListarAtividadeFrequencia implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        Evento en= (Evento)session.getAttribute("evento");
        AtividadeService ats = new AtividadeService();
        System.out.println(en.getId()+"--------------------------------------");
        ArrayList<Atividade> ativis = ats.getAtividadeByEventoId(en.getId());
        session.setAttribute("atividades", ativis);
        return "/org/organ_listar_atividades_frequencia.jsp";
    }
}
