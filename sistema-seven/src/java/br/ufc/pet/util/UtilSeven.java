package br.ufc.pet.util;

import br.ufc.pet.evento.Atividade;
import br.ufc.pet.evento.Horario;
import br.ufc.pet.evento.ModalidadeInscricao;
import br.ufc.pet.evento.PrecoAtividade;
import br.ufc.pet.evento.TipoAtividade;
import br.ufc.pet.services.ModalidadeInscricaoService;
import br.ufc.pet.services.TipoAtividadeService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;

/**
 *
 * @author Caio
 */
public class UtilSeven {

    public static Date treatToDate(String param) {
        if (param != null && param.trim().length() > 0) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            try {
                Date result = sdf.parse(param);
                return result;
            } catch (Exception ex) {
                return null;
            }
        }
        return null;
    }

    public static String treatToString(Date param) {
        if (param != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            String result = sdf.format(param);
            return result;
        }
        return "";
    }

    public static String treatToLongString(Date param) {
        if (param != null) {
            SimpleDateFormat formatter = new SimpleDateFormat("EEEE, dd 'de' MMMM 'de' yyyy");
            String data = formatter.format(param);
            return data;
        }
        return "";
    }

    public static ArrayList<TipoAtividade> getTiposDeAtividade() {
        TipoAtividadeService ts = new TipoAtividadeService();
        return ts.getTiposDeAtividades();
    }

    public static TipoAtividade getTiposDeAtividadeById(Long id) {
        TipoAtividadeService ts = new TipoAtividadeService();
        return ts.getTipoDeAtividadeById(id);
    }
 public static ArrayList<TipoAtividade> getTiposDeAtividadeByEventoId(Long id) {
        TipoAtividadeService ts = new TipoAtividadeService();
        return ts.getTiposDeAtividadesByEventoId(id);
    }
    public static ArrayList<Horario> getHorarios() {
        br.ufc.pet.services.HorarioService hs = new br.ufc.pet.services.HorarioService();
        return hs.getAllHorarios();
    }

    public static ArrayList<Horario> getHorariosByEvento(Long idEvento) {
        br.ufc.pet.services.HorarioService hs = new br.ufc.pet.services.HorarioService();
        ArrayList<Horario> horarios=hs.getHorariosByEventoId(idEvento);
        Collections.sort(horarios);
        return horarios;
    }
    public static ArrayList<ModalidadeInscricao> getModalidadeByEvento(Long idEvento) {
        br.ufc.pet.services.ModalidadeInscricaoService mis = new br.ufc.pet.services.ModalidadeInscricaoService();
        return mis.getModalidadesInscricaoByEventoId(idEvento);
    }

    public static boolean validaData(String data) {


        if (data.length() != 10) {
            //      System.out.println("vai false");
            return false;

        }

        for (int i = 0; i < data.length(); i++) {

            System.out.println(data.charAt(i));
            if (i != 2 && i != 5) {
                if (isNumeber(data.charAt(i)) != true) {
                    //        System.out.println("vai false");
                    return false;
                }

            }
            if ((i == 2 || i == 5) && data.charAt(i) != '/') {
                //      System.out.println("vai false");
                return false;
            }
        }
        //System.out.println("vai true");
        return true;
    }

    private static boolean isNumeber(char a) {

        if (a == '0' || a == '1' || a == '2' || a == '3' || a == '4' || a == '5'
                || a == '6' || a == '7' || a == '8' || a == '9') {
            return true;
        }
        return false;
    }

    public static String precoFormater(double preco) {
        java.text.DecimalFormat df = new java.text.DecimalFormat("R$ ###,###,##0.00");
        return df.format(preco);
    }

    public static double getPrecoAtividades(ArrayList<Atividade> array, Long idModalidade) {
        ModalidadeInscricaoService mis = new ModalidadeInscricaoService();
        ModalidadeInscricao m = mis.getModalidadeInscricaoById(idModalidade);

        if (m == null) {
            return 0;
        }

        double preco = 0;
        for (PrecoAtividade p : m.getPrecoAtividades()) {
            for (Atividade a : array) {
                if (a.getTipo().getId().equals(p.getTipoAtividadeId())) {
                    preco += p.getValor();
                }
            }
        }
        return preco;
    }

    public static double getPrecoTipo(TipoAtividade t, ModalidadeInscricao m) {
        if (m == null || t==null) {
            return 0;
        }

        double preco = 0;
        for (PrecoAtividade p : m.getPrecoAtividades()) {
                if (t.getId().equals(p.getTipoAtividadeId())) {
                    preco += p.getValor();
                    break;
                }
        }
        return preco;
    }
}
