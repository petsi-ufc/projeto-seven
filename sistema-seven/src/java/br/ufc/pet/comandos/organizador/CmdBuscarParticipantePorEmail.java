/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.Inscricao;
import br.ufc.pet.evento.Participante;
import br.ufc.pet.evento.Usuario;
import br.ufc.pet.evento.Utility;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.InscricaoService;
import br.ufc.pet.services.ParticipanteService;
import br.ufc.pet.services.UsuarioService;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mardson
 */
public class CmdBuscarParticipantePorEmail implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        //ArrayList<Inscricao> inscricoesdoevento = new ArrayList<Inscricao>();
        Inscricao inscricoesdoevento = new Inscricao();


        if (session.getAttribute("pago") == null) {

            //String participante = (String) session.getAttribute("participantebuscar");
            String email = request.getParameter("email");
            String evento = request.getParameter("evento_id");

            if (email.equals("") || email == null || email.trim().isEmpty() == true) {
                session.setAttribute("mensagem", "vazio");
                return "/org/organ_listar_pagamento_part.jsp";
            }else if (evento.equals("") || evento == null || evento.trim().isEmpty() == true) {
                session.setAttribute("mensagem", "vazio");
                return "/org/organ_listar_pagamento_part.jsp";
            }
            
            
            UsuarioService us = new UsuarioService();
            Usuario user = us.getByEmail(email);


            ParticipanteService ps = new ParticipanteService();
            Participante part = ps.getByUsuarioId(user.getId());


            InscricaoService inscricaoservice = new InscricaoService();
            Utility u = new Utility();
            u.setEvent_id(Long.parseLong(evento));
            u.setPart_id(part.getId());
            
            inscricoesdoevento = inscricaoservice.getInscricaoParticipanteEvento(u);
            
        } else {
            inscricoesdoevento = (Inscricao) session.getAttribute("pago");
            session.removeAttribute("pago");
            System.out.println("PASSEIIIIIII " + inscricoesdoevento.getId());
        }
        Evento evento = (Evento) session.getAttribute("evento");


        if (inscricoesdoevento != null) {
            if (inscricoesdoevento.getEvento().getId().compareTo(evento.getId()) == 0) {
                session.setAttribute("inscricoesdoevento", inscricoesdoevento);
            } else {

                inscricoesdoevento = null;
                session.setAttribute("mensagem", "naoencontrado");
            }
        } else {
            session.setAttribute("mensagem", "naoencontrado");
        }
        return "/org/organ_listar_pagamento_part.jsp";
    }
}
