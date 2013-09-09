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

            
            Document document = new Document();
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            
            try{
            PdfWriter.getInstance(document, baos);
            document.open();
            document.setPageSize(PageSize.A4.rotate());

            /* Imagem */
//        caminho da iamgens "http://localhost:8080/SEVEN/imagens/ufc.jpg"
            Image jpg = Image.getInstance("http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/imagens/UFC.png");
            jpg.setAlignment(Image.LEFT | Image.UNDERLYING); /* Ajusta o alinhamento da imagem. */

            /* Fontes */
            Font fonteCabecalho = new Font(Font.HELVETICA, 12, Font.BOLD); /* Será usada no cabeçalho. */

            PdfPTable cabecalho = new PdfPTable(2);
            float[] widths = {0.15f, 0.85f};
            cabecalho.setWidthPercentage(90); /* Seta a largura da tabela com relação a página. */
            cabecalho.setWidths(widths);
            cabecalho.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
            cabecalho.addCell(jpg);
            cabecalho.addCell(new Phrase("Universidade Federal do Ceará\n"
                    + "Sistema de Eventos\n", fonteCabecalho));
            document.add(cabecalho); /* Adicionando ao documento. */


            Paragraph cert = new Paragraph("Certificado", FontFactory.getFont(FontFactory.HELVETICA, 16, Font.BOLD));
            cert.setAlignment(Element.ALIGN_CENTER);
            cert.setSpacingBefore(10);
            cert.setSpacingAfter(30);
            document.add(cert);

            Paragraph p1 = new Paragraph("Certificamos que " + inscricao.getParticipante().getUsuario().getNome() + " participou do " +
                    inscricao.getEvento().getNome() + " realizado em Quixadá-Ceará, em " + UtilSeven.treatToString(inscricao.getEvento().getInicioPeriodoEvento()));
            p1.setAlignment(Element.ALIGN_JUSTIFIED);
            document.add(p1);

            

            Paragraph p3 = new Paragraph("Atividades");
            p3.setSpacingBefore(10);
            p3.setSpacingAfter(10);
            document.add(p3);

            for(Atividade a:inscricao.getAtividades()){
                Paragraph p4 = new Paragraph( a.getNome() + " - 12 horas");
                p4.setSpacingAfter(5);
            document.add(p4);
            }

            
            Image jpg2 = Image.getInstance("http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/imagens/assdig.png");
            jpg2.setAlignment(Image.ALIGN_CENTER | Image.UNDEFINED);
            jpg2.setWidthPercentage(40);
            jpg2.setSpacingBefore(10);
            jpg2.setSpacingAfter(2);
            //document.add(jpg2);
/*
            Perfil p = (Perfil) session.getAttribute("user");
            Paragraph p4 = new Paragraph(p.getUsuario().getNome());
            p4.setAlignment(Element.ALIGN_CENTER);
            p4.setSpacingBefore(20);
            document.add(p4);
             
            Paragraph p5 = new Paragraph("Coordenador do Evento");
            p5.setAlignment(Element.ALIGN_CENTER);
            p5.setSpacingBefore(20);
            document.add(p5);
*/

            Perfil p = (Perfil) session.getAttribute("user");
            PdfPTable footer = new PdfPTable(1);
            
            float[] width = {0.15f};
            footer.setWidthPercentage(40); /* Seta a largura da tabela com relação a página. */
            footer.setWidths(width);
            footer.getDefaultCell().setBorder(PdfPCell.NO_BORDER);
            footer.setSpacingBefore(new Float(30));
            
            PdfPCell coodenador = new PdfPCell(new Paragraph(p.getUsuario().getNome()));
            coodenador.setHorizontalAlignment(Paragraph.ALIGN_CENTER);
            coodenador.setBorder(PdfCell.BOTTOM);
            coodenador.setBorderWidthBottom(1.0f);
            coodenador.setBorderColorBottom(Color.BLACK);
            coodenador.setPaddingBottom(5.0f);
            footer.addCell(coodenador);

            PdfPCell nome = new PdfPCell(new Paragraph("Coordenador do Evento"));
            nome.setHorizontalAlignment(Paragraph.ALIGN_CENTER);
            nome.setBorder(PdfCell.NO_BORDER);
            footer.addCell(nome);

            document.add(footer);
            
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
