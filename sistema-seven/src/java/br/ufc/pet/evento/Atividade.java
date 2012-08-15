package br.ufc.pet.evento;

import java.util.ArrayList;

public class Atividade extends Bean {

    private String local;
    private String nome;
    private Evento evento;
    private ArrayList<Horario> horarios;
    private ArrayList<ResponsavelAtividade> responsaveis;
    private TipoAtividade tipo;
    private int vagas;
    private boolean aceitaInscricao;

    public Atividade() {
        this.horarios = new ArrayList<Horario>();
        this.responsaveis = new ArrayList<ResponsavelAtividade>();
    }

    public boolean isAceitaInscricao() {
        return aceitaInscricao;
    }

    public void setAceitaInscricao(boolean aceitaInscricao) {
        this.aceitaInscricao = aceitaInscricao;
    }

    public Evento getEvento() {
        return evento;
    }

    public void setEvento(Evento evento) {
        this.evento = evento;
    }

    public ArrayList<Horario> getHorarios() {
        return horarios;
    }

    public void setHorarios(ArrayList<Horario> horarios) {
        this.horarios = horarios;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public ArrayList<ResponsavelAtividade> getResponsaveis() {
        return responsaveis;
    }

    public void setResponsaveis(ArrayList<ResponsavelAtividade> responsaveis) {
        this.responsaveis = responsaveis;
    }

    public TipoAtividade getTipo() {
        return tipo;
    }

    public void setTipo(TipoAtividade tipo) {
        this.tipo = tipo;
    }

    public int getVagas() {
        return vagas;
    }

    public void setVagas(int vagas) {
        this.vagas = vagas;
    }

    public boolean temHorario(long id){
        boolean entrou = false;
        for(Horario h : getHorarios()){
            if(h.getId() == id){
                entrou = true;
                return entrou;
            }
        }

        return entrou;
    }
}
 
