package com.learnjava.project.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.learnjava.project.models.Produit;

@Repository
public interface ProduitRepository extends JpaRepository<Produit, Long> {

    // Rechercher des produits par nom (contient)
    List<Produit> findByNomContainingIgnoreCase(String nom);

    @Query("SELECT p FROM Produit p WHERE p.quantite < p.seuilAlerte")
    List<Produit> findProduitsEnAlerte();
    
    // Rechercher des produits dans une fourchette de prix
    List<Produit> findByPrixVenteBetween(Double prixMin, Double prixMax);
}
