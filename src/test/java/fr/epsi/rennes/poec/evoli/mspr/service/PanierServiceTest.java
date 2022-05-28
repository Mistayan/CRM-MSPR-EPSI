package fr.epsi.rennes.poec.evoli.mspr.service;

import fr.epsi.rennes.poec.evoli.mspr.dao.PanierDAO;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * Author : Stephen Mistayan
 * Created on : 5/19/2022 : 9:16 AM:14
 * IDE : IntelliJ IDEA
 * Original package : fr.epsi.rennes.poec.evoli.mspr.service
 * Project name : pizzaHut
 **/

@SpringBootTest
public class PanierServiceTest {

    @InjectMocks // Autowired, qui inject un Mock
    private PanierService panierService;

    @Mock
    private PanierDAO panierDAOMock;

    @Test
    void getPanierById() {
//        //given
//        Panier panier = new Panier();
//        List<Article> articles = new ArrayList<>();
//        Article pizza = new Article();
//        pizza.setIngredients(new ArrayList<>());
//        pizza.setLabel("une_pizza");
//        Property ingredient = new Property();
//        ingredient.setId(0);
//        ingredient.setLabel("ingred");
//        ingredient.setNbCalories(0);
//        ingredient.setPrix(0);
//        pizza.getIngredients().add(ingredient);
//        Property ingredient2 = new Property();
//        ingredient2.setId(1);
//        ingredient2.setLabel("ingred2");
//        ingredient2.setNbCalories(1298);
//        ingredient2.setPrix(0);
//        pizza.getIngredients().add(ingredient2);
//
//        Article pizza2 = new Article();
//        pizza2.setLabel("plop");
//        pizza2.setIngredients(new ArrayList<>());
//        pizza2.getIngredients().add(ingredient);
//        articles.add(pizza);
//        articles.add(pizza2);
//
//        final int PANIER_ID = 1;
//        Mockito.when(panierDAOMock.getPanierById(PANIER_ID)).thenReturn(panier);
//
//        // When
//        Panier result = panierService.getPanierById(PANIER_ID);
//
//        double prixPizza1 = result.getPizzas().get(0).getPrix();
//        double prixPizza2 = result.getPizzas().get(1).getPrix();
//        double prixPanier = result.getTotalPrix();
//
//        //THEN
//        Assertions.assertThat(prixPizza1)
//                .isEqualTo(ingredient.getPrix() + ingredient2.getPrix());
//        Assertions.assertThat(prixPizza2).isEqualTo(ingredient.getPrix());
//        Assertions.assertThat(prixPanier).isEqualTo(prixPizza1 + prixPizza2);
    }
}
