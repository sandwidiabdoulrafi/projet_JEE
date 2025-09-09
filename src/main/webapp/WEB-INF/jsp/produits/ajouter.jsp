<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- Messages d'erreur globaux -->
<c:if test="${not empty errorMessage}">
    <div class="mb-6 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg flex items-center animate-fade-in">
        <i class="fas fa-exclamation-triangle mr-3 text-red-500"></i>
        <span>${errorMessage}</span>
        <button onclick="this.parentElement.style.display='none'" class="ml-auto text-red-500 hover:text-red-700">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>


<!-- Formulaire principal -->
<div class=" mx-auto">
    <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden animate-fade-in">

        <!-- En-tête du formulaire -->
        <div class="bg-gradient-to-r from-green-500 to-emerald-600 text-white p-6">
            <div class="flex items-center gap-3">
               
                <div class="flex items-center justify-center">
                    <h2 class="text-xl font-semibold">Informations du nouveau produit</h2>
                </div>
            </div>
        </div>

        <!-- Corps du formulaire -->
        <div class="p-8">
            <form:form method="post" action="/produits/ajouter" modelAttribute="produit" class="space-y-6">

                <c:if test="${not empty successMessage}">
                    <div id="successMessage" style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                        ${successMessage}
                    </div>

                    <script>
                        // Masquer le message après 3 secondes
                        setTimeout(function() {
                            document.getElementById('successMessage').style.display = 'none';
                        }, 3000);
                    </script>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div id="errorMessage" style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
                        ${errorMessage}
                    </div>

                    <script>
                        setTimeout(function() {
                            document.getElementById('errorMessage').style.display = 'none';
                        }, 3000);
                    </script>
                </c:if>


                <!-- Nom du produit -->
                <div class="space-y-2">
                    <label for="nom" class="block text-sm font-semibold text-gray-700 flex items-center gap-2">
                        <i class="fas fa-tag text-green-500"></i>
                        Nom du produit
                        <span class="text-red-500">*</span>
                    </label>
                    <form:input path="nom"
                                id="nom"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-colors duration-200 text-gray-900"
                                placeholder="Ex: MacBook Air M3..."
                                required="true"/>
                    <form:errors path="nom" cssClass="text-red-500 text-sm flex items-center gap-1">
                        <i class="fas fa-exclamation-circle"></i>
                    </form:errors>
                </div>

                <!-- Prix d'achat et Prix de vente -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Prix d'achat -->
                    <div class="space-y-2">
                        <label for="prixAchat" class="block text-sm font-semibold text-gray-700 flex items-center gap-2">
                            Prix d'achat
                            <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <form:input path="prixAchat" 
                                        type="number" 
                                        step="0.01" 
                                        min="0"
                                        id="prixAchat"
                                        class="w-full pl-4 pr-12 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-colors duration-200"
                                        placeholder="0.00" 
                                        required="true"/>
                            <div class="absolute inset-y-0 right-0 flex items-center pr-4 pointer-events-none">
                                <span class="text-gray-500 font-medium">FCFA</span>
                            </div>
                        </div>
                        <form:errors path="prixAchat" cssClass="text-red-500 text-sm flex items-center gap-1">
                            <i class="fas fa-exclamation-circle"></i>
                        </form:errors>
                    </div>

                    <!-- Prix de vente -->
                    <div class="space-y-2">
                        <label for="prixVente" class="block text-sm font-semibold text-gray-700 flex items-center gap-2">
                            Prix de vente
                            <span class="text-red-500">*</span>
                        </label>
                        <div class="relative">
                            <form:input path="prixVente" 
                                        type="number" 
                                        step="0.01" 
                                        min="0"
                                        id="prixVente"
                                        class="w-full pl-4 pr-12 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200"
                                        placeholder="0.00" 
                                        required="true"/>
                            <div class="absolute inset-y-0 right-0 flex items-center pr-4 pointer-events-none">
                                <span class="text-gray-500 font-medium">FCFA</span>
                            </div>
                        </div>
                        <form:errors path="prixVente" cssClass="text-red-500 text-sm flex items-center gap-1">
                            <i class="fas fa-exclamation-circle"></i>
                        </form:errors>
                    </div>
                </div>

                <!-- Quantité et Seuil d'alerte - NOMS SIMPLES -->
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Quantité -->
                    <div class="space-y-2">
                        <label for="quantite" class="block text-sm font-semibold text-gray-700 flex items-center gap-2">
                            <i class="fas fa-boxes text-green-500"></i>
                            Quantité en stock
                            <span class="text-red-500">*</span>
                        </label>
                        <form:input path="quantite" 
                                    type="number" 
                                    min="0"
                                    id="quantite"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-green-500 focus:border-green-500 transition-colors duration-200"
                                    placeholder="0" 
                                    required="true"/>
                        <form:errors path="quantite" cssClass="text-red-500 text-sm flex items-center gap-1">
                            <i class="fas fa-exclamation-circle"></i>
                        </form:errors>
                        <p class="text-xs text-gray-500">Nombre d'unités disponibles en stock</p>
                    </div>

                    <!-- Seuil d'alerte -->
                    <div class="space-y-2">
                        <label for="seuilAlerte" class="block text-sm font-semibold text-gray-700 flex items-center gap-2">
                            <i class="fas fa-exclamation-triangle text-orange-500"></i>
                            Seuil d'alerte 
                            <span class="text-red-500">*</span>
                        </label>
                        <form:input path="seuilAlerte" 
                                    type="number" 
                                    min="0"
                                    id="seuilAlerte"
                                    class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-orange-500 focus:border-orange-500 transition-colors duration-200"
                                    placeholder="5" 
                                    required="true"/>
                        <form:errors path="seuilAlerte" cssClass="text-red-500 text-sm flex items-center gap-1">
                            <i class="fas fa-exclamation-circle"></i>
                        </form:errors>
                        <p class="text-xs text-gray-500">Nombre minimum pour déclencher une alerte</p>
                    </div>
                </div>

                <!-- Indicateurs visuels pour les validations -->
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-4 p-4 bg-gray-50 rounded-lg">
                    <div class="flex items-center gap-2 text-sm">
                        <i class="fas fa-info-circle text-blue-500"></i>
                        <span class="text-gray-600">Stock faible : < 10 unités</span>
                    </div>
                    <div class="flex items-center gap-2 text-sm">
                        <i class="fas fa-exclamation-triangle text-yellow-500"></i>
                        <span class="text-gray-600">Stock critique : < 5 unités</span>
                    </div>
                    <div class="flex items-center gap-2 text-sm">
                        <i class="fas fa-check-circle text-green-500"></i>
                        <span class="text-gray-600">Stock optimal : ≥ 10 unités</span>
                    </div>
                </div>

                <!-- Boutons d'action -->
                <div class="flex flex-col sm:flex-row gap-4 pt-6 border-t border-gray-200">
                    <button type="submit"
                            class="flex-1 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300 hover:shadow-lg hover:scale-105 flex items-center justify-center gap-2">
                        <i class="fas fa-plus-circle"></i>
                        Ajouter le produit
                    </button>
                    <a href="?page=produits/liste"
                        class="flex-1 bg-gray-500 hover:bg-gray-600 text-white px-6 py-3 rounded-lg font-semibold transition-all duration-300 hover:shadow-lg flex items-center justify-center gap-2">
                        <i class="fas fa-arrow-left"></i>
                        Retour à la liste
                    </a>
                </div>
            </form:form>
        </div>
    </div>
</div>

<!-- Script pour validation en temps réel -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    const prixAchatInput = document.getElementById('prixAchat');
    const prixVenteInput = document.getElementById('prixVente');
    const quantiteInput = document.getElementById('quantite');
    const seuilInput = document.getElementById('seuilAlerte');

    // Validation des prix
    [prixAchatInput, prixVenteInput].forEach(input => {
        if (input) {
            input.addEventListener('input', function() {
                const value = parseFloat(this.value);
                if (value < 0 || isNaN(value)) {
                    this.classList.add('border-red-500');
                    this.classList.remove('border-green-500');
                } else {
                    this.classList.remove('border-red-500');
                    this.classList.add('border-green-500');
                }
            });
        }
    });

    // Validation de la quantité avec indicateur visuel
    if (quantiteInput) {
        quantiteInput.addEventListener('input', function() {
            const value = parseInt(this.value);
            this.classList.remove('border-red-500', 'border-yellow-500', 'border-green-500');

            if (value < 0 || isNaN(value)) {
                this.classList.add('border-red-500');
            } else if (value < 5) {
                this.classList.add('border-red-500');
            } else if (value < 10) {
                this.classList.add('border-yellow-500');
            } else {
                this.classList.add('border-green-500');
            }
        });
    }

    // Validation du seuil d'alerte
    if (seuilInput) {
        seuilInput.addEventListener('input', function() {
            const value = parseInt(this.value);
            if (value < 0 || isNaN(value)) {
                this.classList.add('border-red-500');
                this.classList.remove('border-orange-500');
            } else {
                this.classList.remove('border-red-500');
                this.classList.add('border-orange-500');
            }
        });
    }
});
</script>