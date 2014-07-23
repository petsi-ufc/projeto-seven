/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Inscricao;
import br.ufc.pet.evento.Perfil;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.InscricaoService;
import br.ufc.pet.util.UtilSeven;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.CMYKColor;
import com.lowagie.text.pdf.PdfCell;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfTable;
import com.lowagie.text.pdf.PdfWriter;
import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 *
 * @author mardson
 */
public class CmdGerarCertificado implements Comando{

    @Override
    public String executa(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();

        String inscricao_id = request.getParameter("insc_id");

        if(inscricao_id.trim().isEmpty() || inscricao_id == null){
            session.setAttribute("erro", "inscrição inválida!");
            return "/org/organ_gerenciar_inscricoes.jsp";
        }else{
            InscricaoService is = new InscricaoService();
            Inscricao inscricao = is.getInscricaoById(Long.parseLong(inscricao_id));

             response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", " attachment; filename=\"relatorio_" + inscricao.getParticipante().getUsuario().getNome() + ".pdf\"");

            
            Document document = new Document(PageSize.LETTER.rotate());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            
            try{
            PdfWriter writer = PdfWriter.getInstance(document, baos);
            document.open();
            //document.setPageSize(PageSize.A4);

            
            for(Atividade a:inscricao.getAtividades()){
                
            

            Image jpgTemplate = Image.getInstance("http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/imagens/template.jpg");
            
            
            PdfContentByte canvas = writer.getDirectContentUnder();
            jpgTemplate.scaleAbsolute(document.getPageSize().getWidth(), document.getPageSize().getHeight());
            jpgTemplate.setAbsolutePosition(0, 0);
            canvas.addImage(jpgTemplate);
                        

            Paragraph cert2 = new Paragraph(" ", FontFactory.getFont(FontFactory.HELVETICA, 30, Font.BOLD));
            cert2.setAlignment(Element.ALIGN_CENTER);
            cert2.setSpacingBefore(10);
            cert2.setSpacingAfter(15);
            document.add(cert2);

            Paragraph cert = new Paragraph(inscricao.getParticipante().getUsuario().getNome(), FontFactory.getFont(FontFactory.HELVETICA, 27, Font.BOLD));
            cert.setAlignment(Element.ALIGN_CENTER);
            cert.setSpacingBefore(150);
            cert.setSpacingAfter(45);
            document.add(cert);

            Paragraph p1 = new Paragraph(a.getNome(), FontFactory.getFont(FontFactory.HELVETICA, 27, Font.BOLD));
            p1.setAlignment(Element.ALIGN_CENTER);
            document.add(p1);


           
            Paragraph p4 = new Paragraph("    Carga horária: " + a.getCargaHoraria() + " horas", FontFactory.getFont(FontFactory.HELVETICA, 18, Font.BOLD));
            p4.setSpacingBefore(52);
            
            document.add(p4);
            
            document.newPage();

            }

            document.close();

            }catch(Exception ex){
              ex.printStackTrace();
                session.setAttribute("erro", "Erro " + ex.getMessage());
                return "/org/organ_gerenciar_inscricoes.jsp";
            }



            // escreve o pdf no servlet
            response.setContentLength(baos.size());
            ServletOutputStream out = null;
            try {
                out = response.getOutputStream();
            } catch (IOException ex) {
                ex.printStackTrace();
                session.setAttribute("erro", "Erro " + ex.getMessage());
                return "/org/organ_gerenciar_inscricoes.jsp";
            }
            try {
                baos.writeTo(out);
                out.flush();
            } catch (Exception ex) {
                ex.printStackTrace();
                session.setAttribute("erro", "Erro " + ex.getMessage());
                return "/org/organ_gerenciar_inscricoes.jsp";
            }
        }

        return "/org/organ_gerenciar_inscricoes.jsp";
}
    

}
