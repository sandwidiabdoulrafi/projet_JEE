<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="bg-gray-100 min-h-screen p-6">

    <!-- Carte produit -->
    <div class=" mx-auto bg-white rounded-xl shadow-lg overflow-hidden">

        <!-- Header produit -->
        <div class="bg-gradient-to-r from-indigo-500 to-purple-600 text-white text-center p-8">
            <div class="flex items-center justify-start">
                <a href="?page=produits" class="px-6 py-2 rounded-full bg-gray-200 text-gray-800 hover:bg-gray-300 flex items-center gap-2">
                    <i class="fas fa-arrow-left"></i> Retour à la liste
                </a>
            </div>
            <i class="fas fa-cube text-5xl mb-3"></i>
            <h1 class="text-3xl font-bold mb-2">${produit.nom}</h1>
            <p class="opacity-75 mb-3">Détails complets du produit</p>




             <!-- Statistiques rapides -->
            <div class="max-w-3xl mx-auto mt-8 grid grid-cols-1 md:grid-cols-4 gap-4">
                <div class="bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-xl p-6 text-center">
                    <i class="fas fa-shopping-cart text-3xl mb-2"></i>
                    <h4>Prix Achat</h4>
                    <h3 class="font-bold"><fmt:formatNumber value="${produit.prixAchat}" pattern="##0.00" />FCFA</h3>
                </div>
                <div class="bg-gradient-to-r from-green-500 to-green-600 text-white rounded-xl p-6 text-center">
                    <i class="fas fa-tag text-3xl mb-2"></i>
                    <h4>Prix Vente</h4>
                    <h3 class="font-bold"><fmt:formatNumber value="${produit.prixVente}" pattern="##0.00" />FCFA</h3>
                </div>
                <div class="bg-gradient-to-r from-purple-500 to-purple-600 text-white rounded-xl p-6 text-center">
                    <i class="fas fa-warehouse text-3xl mb-2"></i>
                    <h4>Stock Disponible</h4>
                    <h3 class="font-bold">${produit.quantite} unités</h3>
                </div>
                <div class="bg-gradient-to-r from-yellow-400 to-orange-500 text-white rounded-xl p-6 text-center">
                    <i class="fas fa-money-bill-wave text-3xl mb-2"></i>
                    <h4>Valeur Totale</h4>
                    <h3 class="font-bold"><fmt:formatNumber value="${produit.prixVente * produit.quantite}" pattern="##0.00" />FCFA</h3>
                </div>
            </div>





            <!-- Badge stock -->
            <div class="mt-4">
                <c:choose>
                    <c:when test="${produit.quantite == 0}">
                        <span class="px-4 py-2 rounded-full bg-red-600 flex items-center justify-center gap-2">
                            <i class="fas fa-times-circle"></i> Rupture de stock
                        </span>
                    </c:when>
                    <c:when test="${produit.quantite <= produit.seuilAlerte}">
                        <span class="px-4 py-2 rounded-full bg-yellow-400 text-black flex items-center justify-center gap-2">
                            <i class="fas fa-exclamation-triangle"></i> Alerte stock (≤ ${produit.seuilAlerte})
                        </span>
                    </c:when>
                    <c:when test="${produit.quantite < 10}">
                        <span class="px-4 py-2 rounded-full bg-blue-400 flex items-center justify-center gap-2">
                            <i class="fas fa-info-circle"></i> Stock faible
                        </span>
                    </c:when>
                    <c:otherwise>
                        <span class="px-4 py-2 rounded-full bg-green-500 flex items-center justify-center gap-2">
                            <i class="fas fa-check-circle"></i> Stock disponible
                        </span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Informations produit -->
        <div class="p-6 space-y-4">

            <h4 class="text-lg font-semibold flex items-center gap-2">
                <i class="fas fa-info-circle text-indigo-600"></i> Informations du Produit
            </h4>

            <div class="grid grid-cols-2 gap-4 border-b border-blac-200 py-2">
                <span class="font-semibold">ID:</span>
                <span class="text-gray-700">#${produit.id}</span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Nom:</span>
                <span class="text-gray-700">${produit.nom}</span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Prix d'achat:</span>
                <span class="text-blue-600 font-bold">
                    <fmt:formatNumber value="${produit.prixAchat}" pattern="##0.00" />FCFA
                </span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Prix de vente:</span>
                <span class="text-green-600 font-bold">
                    <fmt:formatNumber value="${produit.prixVente}" pattern="##0.00" />FCFA
                </span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Marge unitaire:</span>
                <span class="text-purple-600 font-bold">
                    <fmt:formatNumber value="${produit.prixVente - produit.prixAchat}" pattern="##0.00" />FCFA
                    <span class="text-sm text-gray-500">
                        (<fmt:formatNumber value="${((produit.prixVente - produit.prixAchat) / produit.prixAchat) * 100}" pattern="##0.0" />%)
                    </span>
                </span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Quantité en stock:</span>
                <span class="${produit.quantite == 0 ? 'text-red-600' : (produit.quantite <= produit.seuilAlerte ? 'text-yellow-500' : 'text-green-600')} font-bold">
                    ${produit.quantite} unités
                </span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Seuil d'alerte:</span>
                <span class="text-orange-600 font-bold">${produit.seuilAlerte} unités</span>
            </div>
            <div class="grid grid-cols-2 gap-4 border-b border-gray-200 py-2">
                <span class="font-semibold">Valeur stock (prix achat):</span>
                <span class="text-blue-600 font-bold">
                    <fmt:formatNumber value="${produit.prixAchat * produit.quantite}" pattern="##0.00" />FCFA
                </span>
            </div>
            <div class="grid grid-cols-2 gap-4 py-2">
                <span class="font-semibold">Valeur stock (prix vente):</span>
                <span class="text-yellow-600 font-bold">
                    <fmt:formatNumber value="${produit.prixVente * produit.quantite}" pattern="##0.00" />FCFA
                </span>
            </div>

            <!-- Boutons actions -->
            <div class="flex flex-wrap justify-end gap-4 mt-6">
                <a href="?page=produits/modifier&id=${produit.id}" class="px-6 py-2 rounded-full bg-yellow-400 text-white hover:bg-yellow-500 flex items-center gap-2">
                    <i class="fas fa-edit"></i> Modifier
                </a>
                <button type="button" 
                        class="px-6 py-2 rounded-full bg-red-600 text-white hover:bg-red-700 flex items-center gap-2"
                        data-bs-toggle="modal" 
                        data-bs-target="#deleteModal">
                    <i class="fas fa-trash"></i> Supprimer
                </button>
            </div>
        </div>

    </div>


    <!-- Modal suppression -->
    <div class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content p-6 rounded-xl shadow-lg">
                <div class="text-center">
                    <i class="fas fa-trash text-red-600 text-5xl mb-4"></i>
                    <h3 class="text-xl font-bold mb-2">Êtes-vous sûr de vouloir supprimer ce produit ?</h3>
                    <p class="mb-4"><strong>"${produit.nom}"</strong></p>
                    <div class="bg-yellow-100 text-yellow-800 p-4 rounded">
                        <i class="fas fa-exclamation-triangle mr-2"></i>
                        Cette action est <strong>irréversible</strong>. Toutes les données de ce produit seront définitivement supprimées.
                    </div>
                    <div class="mt-4 flex gap-3 justify-center">
                        <button type="button" class="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400" data-bs-dismiss="modal">
                            Annuler
                        </button>
                        <form action="/produits/supprimer/${produit.id}" method="post" class="inline">
                            <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700">
                                Confirmer la suppression
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>