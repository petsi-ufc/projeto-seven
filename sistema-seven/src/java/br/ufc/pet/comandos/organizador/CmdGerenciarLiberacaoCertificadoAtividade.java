/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Participante;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.AtividadeService;
import br.ufc.pet.services.ParticipanteService;
import br.ufc.pet.util.UtilSeven;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Anderson
 */
public class CmdGerenciarLiberacaoCertificadoAtividade implements Comando {

    @SuppressWarnings("static-access")
    public String executa(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        String temp = request.getParameter("ativ_id");
        //System.out.println("erro aqui: "+temp);
        temp = temp.replace(" ", "");
        Long idAtividade = Long.parseLong(temp);
        
        Atividade at = new AtividadeService().getAtividadeById(idAtividade); //pega a atividade pelo idAtividade
        //System.out.println(at == null);
        ParticipanteService partS = new ParticipanteService();
        ArrayList<Participante> parts = partS.getParticipanteByAtividadeIdQuites(idAtividade);
        if (parts == null || parts.isEmpty()) {
            session.setAttribute("erro", "Atividade sem participantes quites no momento");
            return "/org/organ_gerenciar_emissao_certificados.jsp";
        } else {
            session.setAttribute("participantes", parts);
            session.setAttribute("ativ_id", idAtividade);
            
            return "/org/organ_gerenciar_liberacao_certificados.jsp";
        }
        
    }

    
}
