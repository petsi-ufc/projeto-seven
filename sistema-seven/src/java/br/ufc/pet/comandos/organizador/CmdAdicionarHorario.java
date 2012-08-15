/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.Horario;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.HorarioService;
import br.ufc.pet.util.UtilSeven;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Escritorio projetos
 */
public class CmdAdicionarHorario implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String hi = request.getParameter("hora_inicial");
        String mi = request.getParameter("min_inicial");
        String hf = request.getParameter("hora_final");
        String mf = request.getParameter("min_final");
        String dia = request.getParameter("dia");
        HorarioService hs = new HorarioService();
        Horario novoH = new Horario();
        Horario horEdit = (Horario) session.getAttribute("horario");
        session.removeAttribute("horario");

        if (hi == null || mi == null || hi.trim().equals("") || mi.trim().equals("") || hf == null || hf.equals("") || mf == null || mf.equals("") || dia == null || dia.equals("")) {
            session.setAttribute("erro", "Preencha todos os campos obrigatórios.");
            return "/org/organ_add_horario.jsp";
        } else {
            if (horEdit == null) {
                try {
                    novoH.setHoraInicial(Integer.parseInt(hi));
                    novoH.setMinutoInicial(Integer.parseInt(mi));
                    novoH.setHoraFinal(Integer.parseInt(hf));
                    novoH.setMinutoFinal(Integer.parseInt(mf));

                } catch (Exception ex) {
                    session.setAttribute("erro", "Digite numeros inteiros nos campos para hora e minuto!");
                    return "/org/organ_add_horario.jsp";
                }
                if (UtilSeven.validaData(dia) != true) {
                    session.setAttribute("erro", "Data Inválida, digite no formato dd/mm/aaaa");
                    return "/org/organ_add_horario.jsp";
                } else {
                    novoH.setDia(UtilSeven.treatToDate(dia));
                }
                Evento evento = (Evento) session.getAttribute("evento");
                novoH.setEventoId(evento.getId());
                hs.adicionar(novoH);
                ArrayList<Horario> hors = (ArrayList<Horario>) session.getAttribute("horarios");
                hors.add(novoH);
                session.setAttribute("sucesso", "Horário adicionado com sucesso!");

            } else {
                try {
                    horEdit.setHoraInicial(Integer.parseInt(hi));
                    horEdit.setMinutoInicial(Integer.parseInt(mi));
                    horEdit.setHoraFinal(Integer.parseInt(hf));
                    horEdit.setMinutoFinal(Integer.parseInt(mf));

                } catch (Exception ex) {
                    session.setAttribute("erro", "Digite numeros inteiros nos campos para hora e minuto!");
                    return "/org/organ_add_horario.jsp";
                }
                if (UtilSeven.validaData(dia) != true) {
                    session.setAttribute("erro", "A data deve estar no formato dd/mm/aaaa, por exemplo 01/01/1900!");
                    return "/org/organ_add_horario.jsp";
                } else {
                    horEdit.setDia(UtilSeven.treatToDate(dia));
                }
                //Evento evento = (Evento) session.getAttribute("evento");
                //horEdit.setEventoId(evento.getId());
                //hs.novoH);
                if (hs.atualizar(horEdit)) {
                    session.setAttribute("sucesso", "Horário atualizado com sucesso!");
                } else {
                    session.setAttribute("erro", "Falha na atualização!");
                }
            }
        }
        return "/org/organ_gerenciar_horario.jsp";
    }
}
