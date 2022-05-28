package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.PropertiesDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 2:02 PM:56
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.service
 * Project name : Evoli-Acme
 **/

@Service
public class PropertiesService {
    private final PropertiesDAO propertiesDAO;

    @Autowired
    public PropertiesService(PropertiesDAO propertiesDAO) {this.propertiesDAO = propertiesDAO;}

    @Transactional(readOnly = true)
    public List<Property> getAllProperties() {
        return propertiesDAO.getAllProps();
    }
}
