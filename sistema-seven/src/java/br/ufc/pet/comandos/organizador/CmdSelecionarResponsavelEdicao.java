/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.ResponsavelAtividade;
import br.ufc.pet.interfaces.Comando;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Escritorio projetos
 */
public class CmdSelecionarResponsavelEdicao implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession();
        String usuarioID = request.getParameter("usuario_id");
        //UsuarioService usuarioService = new UsuarioService();
        Long id = Long.parseLong(usuarioID);
        ArrayList<ResponsavelAtividade> resps = (ArrayList<ResponsavelAtividade>) session.getAttribute("responsaveisEscolhidos");
        for (int i = 0; i < resps.size(); i++) {
            if (resps.get(i).getUsuario().getId().compareTo(id) == 0) {
                //resps.remove(i);
                session.setAttribute("responsAtual", resps.get(i));
                break;
            }
        }
        return "/org/organ_editar_responsavel.jsp";
    }
}
