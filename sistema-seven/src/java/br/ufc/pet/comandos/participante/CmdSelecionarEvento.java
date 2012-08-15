package br.ufc.pet.comandos.participante;

import br.ufc.pet.evento.Evento;
import br.ufc.pet.evento.Inscricao;
import br.ufc.pet.evento.ModalidadeInscricao;
import br.ufc.pet.evento.Participante;
import br.ufc.pet.evento.TipoAtividade;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.EventoService;
import br.ufc.pet.services.InscricaoService;
import br.ufc.pet.services.ModalidadeInscricaoService;
import br.ufc.pet.services.TipoAtividadeService;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Caio
 */
public class CmdSelecionarEvento implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        Participante p = (Participante) session.getAttribute("user");

        EventoService es = new EventoService();
        Evento ev = es.getEventoById(Long.parseLong(request.getParameter("id")));

        InscricaoService is = new InscricaoService();
        ArrayList<Inscricao> inscricoesPart = is.getAllInscricaoByParticipanteId(p.getId());

        ModalidadeInscricaoService ms = new ModalidadeInscricaoService();
        ArrayList<ModalidadeInscricao> modalidades = ms.getModalidadesInscricaoByEventoId(ev.getId());

        TipoAtividadeService ts = new TipoAtividadeService();
        ArrayList<TipoAtividade> arrayDeTipos= ts.getTiposDeAtividadesByEventoId(ev.getId());
       
        //limpagem da montagem anterior, caso essa pagina tenha vindo de um "voltar"
        if (session.getAttribute("inscricao") != null) {
            session.removeAttribute("inscricao");
        }
        if (session.getAttribute("selecionadas") != null) {
            session.removeAttribute("selecionadas");
        }

        for(Inscricao i : inscricoesPart){
            if(i.getEvento().getId().equals(ev.getId())){
                session.setAttribute("erro", "Seleção inválida, você já se inscreveu neste evento.");
                return "/part/part_buscar_evento.jsp";
            }
        }
        session.setAttribute("arrayDeTipos", arrayDeTipos);
        session.setAttribute("eventoSelecionado", ev);
        session.setAttribute("modalidades", modalidades);

        return "/part/part_fazer_inscricao.jsp";
    }
}
