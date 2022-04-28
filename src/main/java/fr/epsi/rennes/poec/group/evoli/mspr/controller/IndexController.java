package fr.epsi.rennes.poec.group.evoli.mspr.controller;


import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController //Se renseigner sur MVC
public class IndexController {

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("title", "Page d'accueil");
        return "index";
    }

    //rajouter
}
