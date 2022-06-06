package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.ArticleCategory;
import fr.epsi.rennes.poec.evoli.mspr.dao.ArticleDAO;
import fr.epsi.rennes.poec.evoli.mspr.domain.PokemonProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Author : Stephen Mistayan
 * Created on : 5/10/2022 : 2:02 PM:56
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.service
 * Project name : Evoli-Acme
 **/

@Service
@Repository
public class PropertiesService {
    private final ArticleDAO articleDAO;

    @Autowired
    public PropertiesService(ArticleDAO articleDAO) {
        this.articleDAO = articleDAO;
    }

    @Transactional(readOnly = true)
    public List<ArticleCategory> getAllCategories() {
        return articleDAO.getAllCategories();
    }

}
