/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.InscricaoAtividade;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.AtividadeService;
import br.ufc.pet.services.EventoService;
import br.ufc.pet.util.UtilSeven;
import java.io.IOException;
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
public class CmdConfirmarLiberacaoCertificado implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        AtividadeService ativServ = new AtividadeService();
        String valores[] = request.getParameterValues("verificaAluno");
        if(valores == null) {
            session.setAttribute("erro", "Nenhum aluno selecionado");
            return "/org/organ_gerenciar_emissao_certificados.jsp";
        } else {
            try{
                String a = (String) request.getParameter("ativ_id");
                Long idAtividade = Long.parseLong(a);
                Long ids[] = new Long[valores.length];
                for(int k=0;k<valores.length;k++){
                    ids[k] = Long.parseLong(valores[k]);
                }

                InscricaoAtividade ia = new InscricaoAtividade();
                ia.setAtividadeId(idAtividade);
                for (Long id : ids) {
                    ia.setInscricaoId(id);
                    ia.setConfirmaCertificado(true);
                    ativServ.confirmaLiberacaoCertificadoAtividade(ia);
                }
                
            } catch (NumberFormatException e){
                session.setAttribute("erro", "Erro na liberação dos certificados");
                return "/org/organ_gerenciar_emissao_certificados.jsp";
            }
        
        }

        /*Evento evento = (Evento) session.getAttribute("evento");
        evento.setInicioPeriodoEvento(UtilSeven.treatToDate(inicioEvento));
        evento.setFimPeriodoEvento(UtilSeven.treatToDate(fimEvento));
        evento.setInicioPeriodoInscricao(UtilSeven.treatToDate(inicioInscricao));
        evento.setFimPeriodoInscricao(UtilSeven.treatToDate(fimInscricao));
        EventoService eventoService = new EventoService();
        if (!eventoService.atualizar(evento)) {
            session.setAttribute("erro", "Modificação sem sucesso");
        }
        session.setAttribute("sucesso", "Modificação realizada com sucesso");
        session.setAttribute("evento", evento);*/

        return "/org/organ_gerenciar_atividades.jsp";
    }
}
