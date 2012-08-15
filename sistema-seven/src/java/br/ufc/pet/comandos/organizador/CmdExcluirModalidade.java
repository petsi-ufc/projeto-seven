/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.ModalidadeInscricao;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.ModalidadeInscricaoService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Franklin
 */
public class CmdExcluirModalidade implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        //Evento evento = (Evento) session.getAttribute("evento");
        ModalidadeInscricaoService mis = new ModalidadeInscricaoService();
        //PrecoAtividadeService pas = new PrecoAtividadeService();


        // ArrayList<TipoAtividade> tipo = UtilSeven.getTiposDeAtividadeByEventoId(evento.getId());
        //PrecoAtividade pa = new PrecoAtividade();
        ModalidadeInscricao modalidade = new ModalidadeInscricao();

        modalidade = mis.getModalidadeInscricaoById(Long.parseLong(request.getParameter("mod_id")));
        /* for(TipoAtividade t : tipo){
        pa.setModalidadeId(modalidade.getId());
        pa.setTipoAtividadeId(t.getId());
        pas.excluir(pa);

        mis.excluir(modalidade);
        }*/
        if (mis.excluir(modalidade)) {
            session.setAttribute("sucesso", "Modalidade removida com sucesso!");
        } else {
            session.setAttribute("erro", "Modalidade não pode ser removida!");
        }

        return "/ServletCentral?comando=CmdListarTipoModalidade";
    }
}
