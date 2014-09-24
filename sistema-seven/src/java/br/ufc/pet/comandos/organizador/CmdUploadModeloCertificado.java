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
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author salomao
 */
public class CmdUploadModeloCertificado implements Comando {

    @Override
    public String executa(HttpServletRequest request, HttpServletResponse response) {
        
        HttpSession session = request.getSession(true);
        
        String idEvento = request.getParameter("id_evento");

        
        String path = "/SEVEN_ARQUIVOS/templates_certificados_upload/"+idEvento;

        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        if (!isMultipart) {
             session.setAttribute("erro", "Nenhum arquivo selecionado!");
            return "/org/organ_gerenciar_atividades.jsp";
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();

        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            List<FileItem> items = upload.parseRequest(request);

            Iterator<FileItem> iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = iter.next();
                if (!item.isFormField()) {

                    File uploadedFile = new File(path);
                    item.write(uploadedFile);
                }
            }
           
        } catch (Exception e) {
            session.setAttribute("erro", "Erro ao fazer upload do arquivo!");
            return "/org/organ_gerenciar_upload_certificados.jsp";
        }
        session.setAttribute("sucesso", "Upload feito com sucesso!");
        return "/org/organ_gerenciar_atividades.jsp";
    }

        
}
