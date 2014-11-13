/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.comandos.organizador;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Horario;
import br.ufc.pet.evento.Inscricao;
import br.ufc.pet.evento.InscricaoAtividade;
import br.ufc.pet.evento.Perfil;
import br.ufc.pet.interfaces.Comando;
import br.ufc.pet.services.AtividadeService;
import br.ufc.pet.services.HorarioService;
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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
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
public class CmdGerarCertificado implements Comando {

    @Override
    public String executa(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession();

        String inscricao_id = request.getParameter("insc_id");

        if (inscricao_id == null || inscricao_id.trim().isEmpty()) {
            session.setAttribute("erro", "inscrição inválida!");
            return "/org/organ_gerenciar_inscricoes.jsp";
        } else {
            InscricaoService is = new InscricaoService();
            Inscricao inscricao = is.getInscricaoById(Long.parseLong(inscricao_id));

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", " attachment; filename=\"certificado_" + inscricao.getParticipante().getUsuario().getNome() + ".pdf\"");


            Document document = new Document(PageSize.LETTER.rotate());
            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            try {
                PdfWriter writer = PdfWriter.getInstance(document, baos);
                document.open();
                //document.setPageSize(PageSize.A4);
                
                
                AtividadeService as = new AtividadeService();
                ArrayList<InscricaoAtividade> ia = as.getIncricaoAtividadeByInscricao(inscricao.getId());
                ArrayList<Long> idsAtiv = CmdGerarCertificado.getIdsAtividadeCeriticadoLiberado(ia);

                for (Atividade a : inscricao.getAtividades()) {
                    
                    if(!idsAtiv.contains(a.getId())){
                        continue;
                    }    
                    
                    String path = "/SEVEN_ARQUIVOS/templates_certificados_upload/"+inscricao.getEvento().getId();
                    
                    Image jpgTemplate = Image.getInstance(path);
                       

                    PdfContentByte canvas = writer.getDirectContentUnder();
                    jpgTemplate.scaleAbsolute(document.getPageSize().getWidth(), document.getPageSize().getHeight());
                    jpgTemplate.setAbsolutePosition(0, 0);
                    canvas.addImage(jpgTemplate);


                    Paragraph cert2 = new Paragraph(" ", FontFactory.getFont(FontFactory.HELVETICA, 30, Font.BOLD));
                    cert2.setAlignment(Element.ALIGN_CENTER);
                    cert2.setSpacingBefore(10);
                    cert2.setSpacingAfter(20);
                    document.add(cert2);

                    Paragraph cert = new Paragraph(inscricao.getParticipante().getUsuario().getNome(), FontFactory.getFont(FontFactory.HELVETICA, 22, Font.BOLD));
                    cert.setAlignment(Element.ALIGN_CENTER);
                    cert.setSpacingBefore(150);
                    cert.setSpacingAfter(55);
                    document.add(cert);

                    Paragraph p1 = new Paragraph(a.getNome(), FontFactory.getFont(FontFactory.HELVETICA, 22, Font.BOLD));
                    p1.setAlignment(Element.ALIGN_CENTER);
                    document.add(p1);

                    HorarioService hs = new HorarioService();
                    ArrayList<Horario> horarios = hs.getHorariosByAtivideId(a.getId());

                    double cargaHoraria = 0;

                    for(Horario horario: horarios){
                        //Calculo da Carga horaria da aividade
                        //((HoraFinal - HoraInicial)*60(converte para minutos)) + (minFinal - MinInicial)
                        int minutos = ((horario.getHoraFinal() - horario.getHoraInicial())*60) + (horario.getMinutoFinal() - horario.getMinutoInicial());

                        cargaHoraria = cargaHoraria + minutos;

                    }

                    cargaHoraria = Math.ceil(cargaHoraria/60);
                    int ch = (int) cargaHoraria;

                    Paragraph p4 = new Paragraph("    Carga horária: " + ch + " horas.", FontFactory.getFont(FontFactory.HELVETICA, 18, Font.BOLD));
                    p4.setSpacingBefore(48);

                    document.add(p4);

                    document.newPage();

                }

                document.close();

            } catch (Exception ex) {
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
    
    private static ArrayList<Long> getIdsAtividadeCeriticadoLiberado(ArrayList<InscricaoAtividade> ias){
        ArrayList<Long> ids = new ArrayList<Long>();
        for(InscricaoAtividade ia : ias){
            if(ia.isConfirmaCertificado())
                ids.add(ia.getAtividadeId());
        }
        return ids;
    }
}
