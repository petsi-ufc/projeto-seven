/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.participante;

import br.ufc.pet.evento.Participante;
import br.ufc.pet.evento.Usuario;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.EventoService;
import br.ufc.pet.services.UsuarioService;
import br.ufc.pet.util.UtilSeven;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ismaily
 */
public class CmdEditarParticipante implements Comando {

    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        Participante part = (Participante) session.getAttribute("user");
        //Recuperar dados do formul?rio.
        String nome = request.getParameter("nome");
        String fone = request.getParameter("fone");
        String dataNascimentoS = request.getParameter("dt_nascimento");
        String email = request.getParameter("email");
        String sexo = request.getParameter("sexo");
        String instituicao = request.getParameter("instituicao");
        String rua = request.getParameter("rua");
        String bairro = request.getParameter("bairro");
        String numero = request.getParameter("numero");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String senha = request.getParameter("senha");
        String confSenha = request.getParameter("r-senha");

        if (nome == null || nome.trim().equals("") || email == null || email.trim().equals("")
                || senha == null || senha.trim().equals("") || confSenha == null || confSenha.trim().equals("")) {
            session.setAttribute("erro", "Preencha todos os campos obrigat?rios.");
            return "/part/part_conta.jsp";
        }

        if (!senha.trim().equals(confSenha)) {
            session.setAttribute("erro", "A senha n?o confere com a sua confirma??o.");
            return "/part/part_conta.jsp";
        }

        //Validar a inser??o
        UsuarioService us = new UsuarioService();
        Usuario temp = us.getByEmail(email);
        if (temp != null) {
            if (!temp.getId().equals(part.getUsuario().getId())) {
                session.setAttribute("erro", "E-Mail j? cadastrado.");
                return "/part/part_conta.jsp";
            }
        }


        part.getUsuario().setBairro(bairro);
        part.getUsuario().setCidade(cidade);
        part.getUsuario().setEmail(email);
        part.getUsuario().setFone(fone);
        part.getUsuario().setInstituicao(instituicao);
        part.getUsuario().setNome(nome);
        part.getUsuario().setNumero(numero);
        part.getUsuario().setRua(rua);
        part.getUsuario().setSenha(senha);
        part.getUsuario().setSexo(sexo);
        part.getUsuario().setUf(uf);
        if (dataNascimentoS != null && !dataNascimentoS.trim().isEmpty()) {
            Date dataNascimento = UtilSeven.treatToDate(dataNascimentoS);
            part.getUsuario().setDataNascimento(dataNascimento);
        }

        if (us.update(part.getUsuario())) {
            session.setAttribute("user", part);
            EventoService es = new EventoService();
            session.setAttribute("eventosAbertos", es.buscarEventosComInscricoesAbertas());
            session.setAttribute("sucesso", "Dados Editados com Sucesso.");
            return "/part/index.jsp";
        } else {
            session.setAttribute("erro", "Erro ao tentar cadastrar participante.");
            return "/part/part_conta.jsp";
        }
    }
}
