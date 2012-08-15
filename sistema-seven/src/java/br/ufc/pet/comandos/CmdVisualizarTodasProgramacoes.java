/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.pet.comandos;

import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.EventoService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Welligton
 */
public class CmdVisualizarTodasProgramacoes implements Comando{

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        EventoService es = new EventoService();
        session.setAttribute("visualizarEventosAbertos", es.buscarEventosAbertos());
        return "/programacao.jsp";
    }

}
