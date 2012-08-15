/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.EventoService;
import br.ufc.pet.util.UtilSeven;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Franklin
 */
public class CmdAlterarPeriodoInscricaoeEvento implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();

        String inicioEvento = request.getParameter("inicioEvento");
        session.setAttribute("inicioEvento", inicioEvento);
        String fimEvento = request.getParameter("fimEvento");
        session.setAttribute("fimEvento", fimEvento);
        String inicioInscricao = request.getParameter("inicioInscricao");
        session.setAttribute("inicioInscricao", inicioInscricao);
        String fimInscricao = request.getParameter("fimInscricao");
        session.setAttribute("fimInscricao", fimInscricao);
        DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        Date date = new Date();
        Date data = UtilSeven.treatToDate(dateFormat.format(date));

        if (inicioEvento.trim().isEmpty() || inicioEvento == null || fimEvento.trim().isEmpty() || fimEvento == null
                || inicioInscricao.trim().isEmpty() || inicioInscricao == null || fimInscricao.trim().isEmpty() || fimInscricao == null) {
            session.setAttribute("erro", "Preencha todos os campos.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }

        if (!UtilSeven.validaData(inicioEvento) || !UtilSeven.validaData(fimEvento)
                || !UtilSeven.validaData(inicioInscricao) || !UtilSeven.validaData(fimInscricao)) {
            session.setAttribute("erro", "Digite as datas no seguinte formato dd/mm/aaaa");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }

        if (UtilSeven.treatToDate(inicioEvento).before(data)) {
            session.setAttribute("erro", "Data de inicio do evento anterior a data de hoje.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }
        if (UtilSeven.treatToDate(inicioEvento).after(UtilSeven.treatToDate(fimEvento))) {
            session.setAttribute("erro", "Data de inicio do evento posterior ao termino do evento.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }
        if (UtilSeven.treatToDate(inicioInscricao).before(data)) {
            session.setAttribute("erro", "Data de inicio das incrições anterior a data de hoje.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }
        if (UtilSeven.treatToDate(inicioInscricao).after(UtilSeven.treatToDate(fimEvento))) {
            session.setAttribute("erro", "Data de inicio das inscrições posterior ao termino do evento.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }
        if (UtilSeven.treatToDate(inicioInscricao).after(UtilSeven.treatToDate(inicioEvento))) {
            session.setAttribute("erro", "Data de inicio das inscrições posterior ao inicio do evento.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }
        if (UtilSeven.treatToDate(inicioInscricao).after(UtilSeven.treatToDate(fimInscricao))) {
            session.setAttribute("erro", "Data de inicio das inscrições posterior ao termino das inscrições.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }
        if (UtilSeven.treatToDate(fimInscricao).after(UtilSeven.treatToDate(inicioEvento))) {
            session.setAttribute("erro", "Data de fim das inscrições posterior ao inicio do evento.");
            return "/org/organ_periodos_inscricao_e_evento.jsp";
        }


        Evento evento = (Evento) session.getAttribute("evento");
        evento.setInicioPeriodoEvento(UtilSeven.treatToDate(inicioEvento));
        evento.setFimPeriodoEvento(UtilSeven.treatToDate(fimEvento));
        evento.setInicioPeriodoInscricao(UtilSeven.treatToDate(inicioInscricao));
        evento.setFimPeriodoInscricao(UtilSeven.treatToDate(fimInscricao));
        EventoService eventoService = new EventoService();
        if (!eventoService.atualizar(evento)) {
            session.setAttribute("erro", "Modificação sem sucesso");
        }
        session.setAttribute("sucesso", "Modificação realizada com sucesso");
        session.setAttribute("evento", evento);

        return "/org/organ_gerenciar_atividades.jsp";
    }
}
