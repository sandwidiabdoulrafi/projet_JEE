package com.learnjava.project.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "produits")
public class Produit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le nom du produit est obligatoire")
    private String nom;

    @NotNull(message = "La quantité en stock est obligatoire")
    @Min(value = 0, message = "La quantité ne peut pas être négative")
    private Integer quantite;

    @NotNull(message = "Le prix d'achat est obligatoire")
    @DecimalMin(value = "0.0", inclusive = false, message = "Le prix d'achat doit être positif")
    private Double prixAchat;

    @NotNull(message = "Le prix de vente est obligatoire")
    @DecimalMin(value = "0.0", inclusive = false, message = "Le prix de vente doit être positif")
    private Double prixVente;

    @NotNull(message = "Le seuil d'alerte est obligatoire")
    @Min(value = 0, message = "Le seuil d'alerte ne peut pas être négatif")
    private Integer seuilAlerte;

    // Constructeurs
    public Produit() {}

    public Produit(String nom, Integer quantite, Double prixAchat, Double prixVente, Integer seuilAlerte) {
        this.nom = nom;
        this.quantite = quantite;
        this.prixAchat = prixAchat;
        this.prixVente = prixVente;
        this.seuilAlerte = seuilAlerte;
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public Integer getQuantite() { return quantite; }
    public void setQuantite(Integer quantite) { this.quantite = quantite; }

    public Double getPrixAchat() { return prixAchat; }
    public void setPrixAchat(Double prixAchat) { this.prixAchat = prixAchat; }

    public Double getPrixVente() { return prixVente; }
    public void setPrixVente(Double prixVente) { this.prixVente = prixVente; }

    public Integer getSeuilAlerte() { return seuilAlerte; }
    public void setSeuilAlerte(Integer seuilAlerte) { this.seuilAlerte = seuilAlerte; }

    @Override
    public String toString() {
        return "Produit{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", quantite=" + quantite +
                ", prixAchat=" + prixAchat +
                ", prixVente=" + prixVente +
                ", seuilAlerte=" + seuilAlerte +
                '}';
    }
}
