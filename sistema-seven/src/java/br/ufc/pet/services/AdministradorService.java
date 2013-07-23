/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package br.ufc.pet.services;

import br.ufc.pet.daos.AdministradorDAO;
import br.ufc.pet.evento.Administrador;
import java.sql.SQLException;

/**
 *
 * @author fernando
 */
public class AdministradorService {

    private AdministradorDAO administradorDAO;

    public AdministradorService() {
        administradorDAO = new AdministradorDAO();
    }

    public Administrador getByUsuarioId(Long id) {
        try {
            Administrador admin = administradorDAO.getByUsuarioId(id);
            if (admin != null) {
                UsuarioService us = new UsuarioService();
                admin.setUsuario(us.getById(admin.getUsuario().getId()));
                EventoService es = new EventoService();
                admin.setEventos(es.buscarEventosAbertos());


                return admin;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void alterarSenhaAdmin(Long id, String senha){
         try {
            Administrador admin = administradorDAO.getByUsuarioId(id);
            if (admin != null) {
                UsuarioService us = new UsuarioService();
                admin.setUsuario(us.getById(admin.getUsuario().getId()));
                admin.getUsuario().setSenha(senha);
                us.updateSenhaUser(admin.getUsuario());
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
    }

}
