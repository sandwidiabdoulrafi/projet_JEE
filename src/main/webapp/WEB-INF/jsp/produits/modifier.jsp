<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="bg-gray-100 min-h-screen">
    <!-- Formulaire de modification -->
    <div class="mx-auto pb-12">
        <div class="bg-white rounded-xl shadow-lg overflow-hidden">

            <!-- En-tête -->
            <div class="bg-gradient-to-r from-green-500 to-teal-500 text-white text-center p-2 flex items-center justify-start gap-16">
                <a  href="?page=produits/liste" class="flex flex-row items-center text-gray-700 hover:text-gray-500 transition gap-4 ">
                    <i class="fas fa-arrow-left text-4xl mb-2"></i>
                    <span class="text-[25px]">Retour</span>
                </a>                
                <div class="flex  items-center gap-2 ml-[100px]">
                    <i class="fas fa-edit text-3xl mb-3"></i>
                    <h2 class="text-2xl font-bold">Modifier le Produit</h2>
                </div>
                
            </div>

            <!-- Corps -->
            <div class="p-8">

                <!-- Messages d'erreur -->
                <c:if test="${not empty errorMessage}">
                    <div class="bg-red-100 text-red-700 p-3 rounded mb-4 flex items-center gap-2">
                        <i class="fas fa-exclamation-triangle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <form:form method="post" modelAttribute="produit" class="space-y-6">
                    <!-- Champ ID caché -->
                    <form:hidden path="id"/>

                    <!-- Nom du produit -->
                    <div>
                        <label for="nom" class="block font-medium mb-2">
                            <i class="fas fa-tag mr-1"></i> Nom du produit <span class="text-red-500">*</span>
                        </label>
                        <form:input path="nom"
                                    id="nom"
                                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-500"
                                    placeholder="Ex: Ordinateur portable HP"
                                    required="true"/>
                        <form:errors path="nom" cssClass="text-red-500 text-sm mt-1 block"/>
                    </div>

                    <!-- Quantité -->
                    <div>
                        <label for="quantite" class="block font-medium mb-2">
                            <i class="fas fa-boxes mr-1"></i> Quantité en stock <span class="text-red-500">*</span>
                        </label>
                        <form:input path="quantite" type="number" min="0"
                            id="quantite"
                            class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-500"
                            placeholder="0" required="true"/>
                        <form:errors path="quantite" cssClass="text-red-500 text-sm mt-1 block"/>
                    </div>

                    <!-- Prix d'achat et Prix de vente -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="prixAchat" class="block font-medium mb-2">
                                <i class="fas fa-shopping-cart mr-1"></i> Prix d'achat <span class="text-red-500">*</span>
                            </label>
                            <div class="flex">
                                <form:input path="prixAchat" type="number" step="0.01" min="0.01"
                                            id="prixAchat"
                                            class="flex-1 border border-gray-300 rounded-l-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-500"
                                            placeholder="0.00" required="true"/>
                                <span class="bg-gray-200 border border-l-0 border-gray-300 rounded-r-lg px-4 flex items-center">FCFA</span>
                            </div>
                            <form:errors path="prixAchat" cssClass="text-red-500 text-sm mt-1 block"/>
                        </div>
                        
                        <div>
                            <label for="prixVente" class="block font-medium mb-2">
                                Prix de vente <span class="text-red-500">*</span>
                            </label>
                            <div class="flex">
                                <form:input path="prixVente" type="number" step="0.01" min="0.01"
                                            id="prixVente"
                                            class="flex-1 border border-gray-300 rounded-l-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-500"
                                            placeholder="0.00" required="true"/>
                                <span class="bg-gray-200 border border-l-0 border-gray-300 rounded-r-lg px-4 flex items-center">FCFA</span>
                            </div>
                            <form:errors path="prixVente" cssClass="text-red-500 text-sm mt-1 block"/>
                        </div>
                    </div>

                    <!-- Seuil d'alerte -->
                    <div>
                        <label for="seuilAlerte" class="block font-medium mb-2">
                            <i class="fas fa-exclamation-triangle mr-1"></i> Seuil d'alerte <span class="text-red-500">*</span>
                        </label>
                        <form:input path="seuilAlerte" type="number" min="0"
                            id="seuilAlerte"
                            class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-green-500"
                            placeholder="5" required="true"/>
                        <div class="text-sm text-gray-600 mt-1">
                            <i class="fas fa-info-circle mr-1"></i> 
                            Quantité en dessous de laquelle une alerte sera générée
                        </div>
                        <form:errors path="seuilAlerte" cssClass="text-red-500 text-sm mt-1 block"/>
                    </div>

                    <!-- Informations calculées -->
                    <div class="bg-blue-50 rounded-lg p-4">
                        <h4 class="font-medium text-blue-800 mb-2">
                            <i class="fas fa-calculator mr-1"></i> Informations calculées
                        </h4>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                            <div class="text-blue-700">
                                <strong>Marge unitaire:</strong> 
                                <span id="margeUnitaire">-</span>
                            </div>
                            <div class="text-blue-700">
                                <strong>Taux de marge:</strong> 
                                <span id="tauxMarge">-</span>
                            </div>
                            <div class="text-blue-700">
                                <strong>Valeur stock:</strong> 
                                <span id="valeurStock">-</span>
                            </div>
                        </div>
                    </div>

                    <!-- Boutons -->
                    <div class="flex items-center justify-between gap-8 pt-4">
                        <button type="reset" class="w-full text-center bg-gray-400 text-white px-6 py-3 rounded-lg font-semibold hover:bg-gray-500 transition-all">
                            Annuler
                        </button>
                        <button type="submit" class="w-full text-white bg-gradient-to-r from-green-500 to-teal-500 px-6 py-3 rounded-lg font-semibold hover:from-green-600 hover:to-teal-600 transition-all">
                            <i class="fas fa-save mr-2"></i> Modifier le Produit
                        </button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>

    <!-- Informations actuelles -->
    <div class="max-w-4xl mx-auto mb-8">
        <div class="bg-white rounded-xl shadow p-6">
            <div class="text-green-700 font-bold mb-4 flex items-center gap-2">
                <i class="fas fa-info-circle"></i> Informations actuelles du produit
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 text-gray-700">
                <div class="bg-gray-50 p-3 rounded">
                    <div class="font-semibold text-gray-500 text-sm">ID</div>
                    <div class="text-lg">${produit.id}</div>
                </div>

                <div class="bg-gray-50 p-3 rounded">
                    <div class="font-semibold text-gray-500 text-sm">Nom</div>
                    <div class="text-lg">${produit.nom}</div>
                </div>

                <div class="bg-gray-50 p-3 rounded">
                    <div class="font-semibold text-gray-500 text-sm">Quantité</div>
                    <div class="text-lg">${produit.quantite}</div>
                </div>

                <div class="bg-gray-50 p-3 rounded">
                    <div class="font-semibold text-gray-500 text-sm">Prix d'achat</div>
                    <div class="text-lg">${produit.prixAchat}FCFA</div>
                </div>

                <div class="bg-gray-50 p-3 rounded">
                    <div class="font-semibold text-gray-500 text-sm">Prix de vente</div>
                    <div class="text-lg">${produit.prixVente}FCFA</div>
                </div>

                <div class="bg-gray-50 p-3 rounded">
                    <div class="font-semibold text-gray-500 text-sm">Seuil d'alerte</div>
                    <div class="text-lg">${produit.seuilAlerte}</div>
                </div>
            </div>
        </div>
    </div>

</div>

<script>

function calculerInfos() {
    const prixAchat = parseFloat(document.getElementById('prixAchat').value) || 0;
    const prixVente = parseFloat(document.getElementById('prixVente').value) || 0;
    const quantite = parseInt(document.getElementById('quantite').value) || 0;
    
    // Marge unitaire
    const margeUnitaire = prixVente - prixAchat;
    document.getElementById('margeUnitaire').textContent = margeUnitaire.toFixed(2) + 'FCFA';
    
    // Taux de marge
    const tauxMarge = prixAchat > 0 ? ((margeUnitaire / prixAchat) * 100) : 0;
    document.getElementById('tauxMarge').textContent = tauxMarge.toFixed(1) + '%';
    
    // Valeur du stock
    const valeurStock = quantite * prixAchat;
    document.getElementById('valeurStock').textContent = valeurStock.toFixed(2) + 'FCFA';
}

// Événements pour le calcul automatique
document.addEventListener('DOMContentLoaded', function() {
    calculerInfos();
    
    document.getElementById('prixAchat').addEventListener('input', calculerInfos);
    document.getElementById('prixVente').addEventListener('input', calculerInfos);
    document.getElementById('quantite').addEventListener('input', calculerInfos);
});
</script>