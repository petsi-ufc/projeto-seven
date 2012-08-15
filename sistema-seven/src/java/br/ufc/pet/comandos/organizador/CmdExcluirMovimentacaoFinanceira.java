/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.MovimentacaoFinanceira;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.MovimentacaoFinanceiraService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Franklin Barroso
 */
public class CmdExcluirMovimentacaoFinanceira implements Comando{
    public String executa(HttpServletRequest request, HttpServletResponse response){
    HttpSession session= request.getSession();
    String codigo = request.getParameter("id_mf");
    Long cod = Long.parseLong(codigo);
    MovimentacaoFinanceiraService s = new MovimentacaoFinanceiraService();
    MovimentacaoFinanceira movfinanExcluir = s.getById(cod);
    
    if(s.excluir(movfinanExcluir)){
        session.setAttribute("excluida_movimentacao_financeira","sucesso");
        session.setAttribute("estado","excluido");
    }
    else{
        session.setAttribute("excluida_movimentacao_financeira","semsucesso");
    }

    return "/ServletCentral?comando=CmdListarMovimentacaoFinanceira";
    }
}
