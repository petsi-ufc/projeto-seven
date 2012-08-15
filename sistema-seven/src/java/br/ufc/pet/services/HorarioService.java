/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.services;

import br.ufc.pet.daos.HorarioDAO;
import br.ufc.pet.evento.Horario;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Caio
 */
public class HorarioService {

    private HorarioDAO horarioDAO;

    public HorarioService() {
        horarioDAO = new HorarioDAO();
    }

    public Horario getHorarioById(long id) {
        try {
            Horario en = horarioDAO.getById(id);
            return en;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public ArrayList<Horario> getHorariosByAtivideId(long id) {
        try {
            ArrayList<Horario> horarios = horarioDAO.getByAtividadeId(id);
            return horarios;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public ArrayList<Horario> getHorariosByEventoId(long id) {
        try {
            ArrayList<Horario> horarios = horarioDAO.getByEventoId(id);
            return horarios;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public ArrayList<Horario> getAllHorarios() {
        try {
            ArrayList<Horario> horarios = horarioDAO.getAllHorarios();
            return horarios;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public boolean adicionar(Horario horario) {
        try {
            horarioDAO.insert(horario);
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean excluir(long horId) {
        try {
            horarioDAO.delete(horId);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean atualizar(Horario horario) {
        try {
            horarioDAO.update(horario);
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
