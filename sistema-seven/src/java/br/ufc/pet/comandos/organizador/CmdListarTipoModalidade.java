/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.ModalidadeInscricao;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.ModalidadeInscricaoService;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Franklin
 */
public class CmdListarTipoModalidade implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        System.out.println("passou aqui 0");
        Evento evento = (Evento) session.getAttribute("evento");
        System.out.println("passou aqui 1");
        ModalidadeInscricaoService modalidade = new ModalidadeInscricaoService();
        System.out.println("passou aqui 2");
        ArrayList<ModalidadeInscricao> modalidades = modalidade.getModalidadesInscricaoByEventoId(evento.getId());
        if (modalidades == null || modalidades.isEmpty()) {
            System.out.println("passou aqui 3");
        }
        session.setAttribute("modalidades", modalidades);

        return "/org/organ_gerenciar_modalidade.jsp";

    }
}
