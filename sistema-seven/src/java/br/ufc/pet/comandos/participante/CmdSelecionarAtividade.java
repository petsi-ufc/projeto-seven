/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.participante;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Inscricao;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.AtividadeService;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Caio
 */
public class CmdSelecionarAtividade implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        AtividadeService AtividadeS = new AtividadeService();
        HttpSession session = request.getSession();
        //este comando copia uma atividade da oferta para o array de selecionadas pelo participante

        ArrayList<Atividade> arrayDeSelecionadas = new ArrayList();// guardará as atividades selecionadas anteriormente
        ArrayList<Atividade> arrayDeConflitantes = new ArrayList();// guardará as atividades em conflito
        Inscricao anterior;

        if (session.getAttribute("inscricao") != null) {
            anterior = (Inscricao) session.getAttribute("inscricao");
            arrayDeSelecionadas.addAll(anterior.getAtividades());
        } else {
            anterior = new Inscricao();
        }
        //reconhecimento da atividade pelo ID, que esta na url como 'ativ'
        Atividade selecionada = AtividadeS.getAtividadeById(Long.parseLong(request.getParameter("ativ")));

        Atividade a;
        //verificação de conflitos de horarios, todas as conflitantes com a atualmente selecionada serão removidas.
        for (int i = 0; i < arrayDeSelecionadas.size(); i++) {
            a = arrayDeSelecionadas.get(i);
            if (a.getId().equals(selecionada.getId())) {//atividade ja foi selecionada anteriormente
                return "/part/part_fazer_inscricao.jsp";//nada a fazer
            }
            if (AtividadeS.conflitam(a, selecionada)) {
                arrayDeConflitantes.add(a);             //conflito detectado
            }
        }

        if (arrayDeConflitantes.isEmpty()) {// não há conflitos
            arrayDeSelecionadas.add(selecionada);
            anterior.setAtividades(arrayDeSelecionadas);

            session.setAttribute("inscricao", anterior);
        } else {//existem conflitos, uma mensagem de erro será gerada.
            String nomesConflitantes = new String();
            for (Atividade at : arrayDeConflitantes) {
                nomesConflitantes += at.getNome() + ", ";
            }
            int tam = nomesConflitantes.length();
            nomesConflitantes = nomesConflitantes.substring(0, tam - 2); //retira a ultima virgula, desnecessária.
            session.setAttribute("erro", "Atenção: A atividade " + selecionada.getNome() + " conflita com as seguintes atividades: " + nomesConflitantes + ". Para selecioná-la, você deve retirar primeiramente as conflitantes da seleção.");
        }
        return "/part/part_fazer_inscricao.jsp";
    }
}
