package com.learnjava.project.controllers;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.learnjava.project.models.Produit;
import com.learnjava.project.services.ProduitService;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/")
public class ProduitController {
    
    @Autowired
    private ProduitService produitService;
    
    // Page d'accueil
    @GetMapping("/")
    public String index() {
        return "index"; // → /WEB-INF/jsp/index.jsp
    }
    
    @GetMapping("/produits/liste")
    public String listeProduits(Model model, 
        @RequestParam(required = false) String search,
        @RequestParam(required = false) Integer seuil) {
            List<Produit> produits;
            
            if (search != null && !search.trim().isEmpty()) {
                produits = produitService.searchProduitsByNom(search);
                model.addAttribute("search", search);
            } else if (seuil != null) {
                produits = produitService.getProduitsEnRupture();
                model.addAttribute("seuil", seuil);
            } else {
                produits = produitService.getAllProduits();
            }
            
            model.addAttribute("produits", produits);
            return "produits/liste"; // → /WEB-INF/jsp/produits/liste.jsp
    }
    
    // Afficher la liste des produits pour modification (sans ID)
    @GetMapping("/produits/modifier")
    public String afficherListeModification(Model model, @RequestParam(required = false) Long id) {
        if (id != null) {
            // Si un ID est fourni, afficher le formulaire de modification
            Optional<Produit> produit = produitService.getProduitById(id);
            if (produit.isPresent()) {
                model.addAttribute("produit", produit.get());
                return "produits/modifier"; // → /WEB-INF/jsp/produits/modifier.jsp
            } else {
                return "redirect:/produits/liste";
            }
        } else {
            // Si aucun ID, afficher la liste des produits
            List<Produit> produits = produitService.getAllProduits();
            model.addAttribute("produits", produits);
            return "produits/modifier"; // → /WEB-INF/jsp/produits/modifier.jsp
        }
    }

    private static final Logger logger = LoggerFactory.getLogger(ProduitController.class);

    @GetMapping("/produits/alerte")
    public String afficheAlertPage(Model model) {
        List<Produit> produitsEnAlerte = produitService.getProduitsEnRupture();


        logger.info("Nombre de produits en alerte : {}", produitsEnAlerte.size());
        logger.debug("Produits en alerte : {}", produitsEnAlerte);
        
        if (!produitsEnAlerte.isEmpty()) {
            // Si des produits sont en alerte, on les affiche
            model.addAttribute("produits", produitsEnAlerte);
        } else {
            // Si aucun produit en alerte, on affiche un message
            model.addAttribute("errorMessage", "Aucun produit en alerte.");
        }

            model.addAttribute("errorMessage", "Aucun produit en alerte.");
            logger.warn("Aucun produit en alerte trouvé.");
        
        return "produits/alerte";
    }


    // Afficher la liste des produits (mapping alternatif)
    @GetMapping("/produits")
    public String redirectToListe() {
        return "redirect:/produits/liste";
    }
    
    // Afficher le formulaire d'ajout
    @GetMapping("/produits/ajouter")
    public String afficherFormulaireAjout(Model model) {
        model.addAttribute("produit", new Produit());
        return "produits/ajouter"; // → /WEB-INF/jsp/produits/ajouter.jsp
    }
    
    // Traiter l'ajout d'un produit
    @PostMapping("/produits/ajouter")
    public String ajouterProduit(@Valid @ModelAttribute Produit produit, BindingResult result, Model model, RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            return "redirect:/?page=produits/ajouter";
        }
        
        try {
            produitService.saveProduit(produit);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Produit '" + produit.getNom() + "' ajouté avec succès!");
            model.addAttribute("produit", new Produit()); 
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Erreur lors de l'ajout du produit : " + e.getMessage());
        }
        
        return "redirect:/?page=produits/ajouter";
    }

    // Traiter la modification d'un produit
    @PostMapping("/produits/modifier")
    public String traiterModificationProduit(@Valid @ModelAttribute Produit produit, BindingResult result, RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            return "redirect:/produits/modifier?id=" + produit.getId();
        }
        
        try {
            produitService.saveProduit(produit);
            redirectAttributes.addFlashAttribute("successMessage", 
                "Produit '" + produit.getNom() + "' modifié avec succès!");
                return "redirect:/produits/liste";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Erreur lors de la modification : " + e.getMessage());
        }
        
        return "redirect:/produits/liste";
    }
    
    // Supprimer un produit
    @PostMapping("/produits/supprimer/{id}")
    public String supprimerProduit(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Optional<Produit> produit = produitService.getProduitById(id);
            produitService.deleteProduit(id);
            
            String nomProduit = produit.isPresent() ? produit.get().getNom() : "le produit";
            redirectAttributes.addFlashAttribute("successMessage", 
                "Produit '" + nomProduit + "' supprimé avec succès!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Erreur lors de la suppression : " + e.getMessage());
        }
        
        return "redirect:/?page=produits/liste";
    }





    

    // Afficher les détails d'un produit 
    @GetMapping("/produits/details")
    public String voirProduit(@RequestParam Long id, Model model) {
        Optional<Produit> produit = produitService.getProduitById(id);
        
        if (produit.isPresent()) {
            model.addAttribute("produit", produit.get());
        } else {
            model.addAttribute("errorMessage", "Produit introuvable");
        }
        
        return "produits/details"; // → /WEB-INF/jsp/produits/details.jsp
    }

}