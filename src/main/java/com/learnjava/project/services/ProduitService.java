package com.learnjava.project.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.learnjava.project.models.Produit;
import com.learnjava.project.repository.ProduitRepository;

@Service
public class ProduitService {
    
    @Autowired
    private ProduitRepository produitRepository;
    
    // Récupérer tous les produits
    public List<Produit> getAllProduits() {
        return produitRepository.findAll();
    }
    
    // Récupérer un produit par ID
    public Optional<Produit> getProduitById(Long id) {
        return produitRepository.findById(id);
    }
    
    // Sauvegarder un produit
    public Produit saveProduit(Produit produit) {
        return produitRepository.save(produit);
    }
    
    // Mettre à jour un produit
    public Produit updateProduit(Long id, Produit produitDetails) {
        Optional<Produit> optionalProduit = produitRepository.findById(id);
        
        if (optionalProduit.isPresent()) {
            Produit produit = optionalProduit.get();
            produit.setNom(produitDetails.getNom());
            produit.setQuantite(produitDetails.getQuantite());
            produit.setPrixAchat(produitDetails.getPrixAchat());
            produit.setPrixVente(produitDetails.getPrixVente());
            produit.setSeuilAlerte(produitDetails.getSeuilAlerte());
            return produitRepository.save(produit);
        }
        
        throw new RuntimeException("Produit non trouvé avec l'ID : " + id);
    }
    
    // Supprimer un produit
    public void deleteProduit(Long id) {
        if (produitRepository.existsById(id)) {
            produitRepository.deleteById(id);
        } else {
            throw new RuntimeException("Produit non trouvé avec l'ID : " + id);
        }
    }
    
    // Rechercher des produits par nom
    public List<Produit> searchProduitsByNom(String nom) {
        return produitRepository.findByNomContainingIgnoreCase(nom);
    }
    
    // Obtenir les produits en rupture de stock
    public List<Produit> getProduitsEnRupture() {
        return produitRepository.findProduitsEnAlerte();
    }
    
    // Obtenir les produits dans une fourchette de prix (prix de vente)
    public List<Produit> getProduitsByPrixRange(Double prixMin, Double prixMax) {
        return produitRepository.findByPrixVenteBetween(prixMin, prixMax);
    }
}
