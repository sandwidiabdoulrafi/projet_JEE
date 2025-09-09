<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Messages de succès/erreur -->
<c:if test="${not empty successMessage}">
    <div class="mb-4 p-4 bg-green-100 border border-green-400 text-green-700 rounded-lg flex items-center animate-fade-in">
        <i class="fas fa-check-circle mr-3 text-green-500"></i>
        <span>${successMessage}</span>
        <button onclick="this.parentElement.style.display='none'" class="ml-auto text-green-500 hover:text-green-700">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<c:if test="${not empty errorMessage}">
    <div class="mb-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded-lg flex items-center animate-fade-in">
        <i class="fas fa-exclamation-triangle mr-3 text-red-500"></i>
        <span>${errorMessage}</span>
        <button onclick="this.parentElement.style.display='none'" class="ml-auto text-red-500 hover:text-red-700">
            <i class="fas fa-times"></i>
        </button>
    </div>
</c:if>

<!-- En-tête moderne -->
<div class="mb-8">
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
            <h1 class="text-3xl font-bold text-gray-900 flex items-center gap-3">
                Liste des Produits
            </h1>
        </div>
    </div>
</div>

<!-- Statistiques rapides -->
<c:if test="${not empty produits}">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
        <div class="bg-gradient-to-r from-blue-500 to-blue-600 text-white rounded-2xl p-6 shadow-lg animate-fade-in">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-blue-100 text-sm font-medium">Total Produits</p>
                    <p class="text-3xl font-bold">${produits.size()}</p>
                </div>
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-boxes text-2xl"></i>
                </div>
            </div>
        </div>
        
        <div class="bg-gradient-to-r from-green-500 to-green-600 text-white rounded-2xl p-6 shadow-lg animate-fade-in">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-green-100 text-sm font-medium">Valeur Stock</p>
                    <p class="text-3xl font-bold">
                        <c:set var="totalValue" value="0" />
                        <c:forEach items="${produits}" var="p">
                            <c:set var="totalValue" value="${totalValue + (p.prixVente * p.quantite)}" />
                        </c:forEach>
                        <fmt:formatNumber value="${totalValue}" pattern="##0.00" /> FCFA
                    </p>
                </div>
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-calculator text-2xl"></i>
                </div>
            </div>
        </div>
        
        <div class="bg-gradient-to-r from-orange-500 to-red-500 text-white rounded-2xl p-6 shadow-lg animate-fade-in">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-orange-100 text-sm font-medium">Stock Faible</p>
                    <p class="text-3xl font-bold">
                        <c:set var="lowStock" value="0" />
                        <c:forEach items="${produits}" var="p">
                            <c:if test="${p.quantite < 10}">
                                <c:set var="lowStock" value="${lowStock + 1}" />
                            </c:if>
                        </c:forEach>
                        ${lowStock}
                    </p>
                </div>
                <div class="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center">
                    <i class="fas fa-exclamation-triangle text-2xl"></i>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- Barre de recherche et filtres -->
<div class="bg-white rounded-2xl shadow-lg border border-gray-100 p-6 mb-8 animate-fade-in">
    <form method="get" class="flex items-center justify-between">
        <input type="hidden" name="page" value="produits/liste">
        <div class="md:col-span-2">
            <label for="search" class="block text-sm font-medium text-gray-700 mb-2">Rechercher un produit </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                    <i class="fas fa-search text-gray-400"></i>
                </div>
                <input type="text" 
                    class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition-colors duration-200" 
                    id="search" 
                    name="search" 
                    value="${param.search}"
                    placeholder="Nom du produit...">
            </div>
        </div>
        
        <div class="flex items-end gap-2">
            <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-3 rounded-lg font-medium transition-all duration-200 hover:shadow-md flex items-center gap-2">
                <i class="fas fa-search"></i>
                Filtrer
            </button>
            <a href="?page=produits/liste" class="bg-gray-500 hover:bg-gray-600 text-white px-4 py-3 rounded-lg font-medium transition-all duration-200 hover:shadow-md flex items-center gap-2">
                <i class="fas fa-times"></i>
                
                réinitialiser
            </a>
        </div>
    </form>
</div>

<!-- Contenu principal -->
<div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden animate-fade-in">
    
    <c:choose>
        <c:when test="${empty produits}">
            <!-- État vide -->
            <div class="text-center py-16 px-8">
                <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <i class="fas fa-box-open text-4xl text-gray-400"></i>
                </div>
                <h3 class="text-xl font-semibold text-gray-900 mb-3">Aucun produit trouvé</h3>
                <p class="text-gray-600 mb-8 max-w-md mx-auto">
                    <c:choose>
                        <c:when test="${not empty param.search}">
                            Aucun produit ne correspond à votre recherche "${param.search}"
                        </c:when>
                        <c:when test="${not empty param.seuil}">
                            Aucun produit avec un stock inférieur à ${param.seuil}
                        </c:when>
                        <c:otherwise>
                            Commencez par ajouter votre premier produit pour démarrer la gestion de votre stock
                        </c:otherwise>
                    </c:choose>
                </p>
                <a href="?page=produits/ajouter" class="bg-gradient-to-r from-blue-500 to-blue-600 hover:from-blue-600 hover:to-blue-700 text-white px-6 py-3 rounded-xl font-medium transition-all duration-300 hover:shadow-lg inline-flex items-center gap-2">
                    <i class="fas fa-plus"></i>
                    Ajouter un produit
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Tableau des produits -->
            <div class="overflow-x-auto h-[450px] overflow-y-auto">
                <table class="w-full">
                    <thead class="bg-gradient-to-r from-blue-100 to-blue-300 sticky top-0 z-10">
                        <tr>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-900">
                                <i class="fas fa-hashtag mr-2 text-gray-500"></i>
                                ID
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-900">
                                <i class="fas fa-tag mr-2 text-gray-500"></i>
                                Nom
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-900">
                                <i class="fas fa-boxes mr-2 text-gray-500"></i>
                                Quantité
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-900">
                                <span class="mr-2 text-gray-500">FCFA</span>
                                Prix Vente
                            </th>
                            <th class="px-6 py-4 text-center text-sm font-semibold text-gray-900">
                                <i class="fas fa-cogs mr-2 text-gray-500"></i>
                                Actions
                            </th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:forEach items="${produits}" var="produit" varStatus="status">
                            <tr class="hover:bg-gray-50 transition-colors border-b border-gray-400 duration-200">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="bg-gray-100 text-gray-800 text-sm font-medium px-3 py-1 rounded-full">${status.count}</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="font-semibold text-gray-900">${produit.nom}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${produit.quantite < 5}">
                                            <span class="bg-red-100 text-red-800 text-sm font-medium px-3 py-1 rounded-full flex items-center gap-1 w-fit">
                                                <i class="fas fa-exclamation-triangle text-red-500"></i>
                                                ${produit.quantite}
                                            </span>
                                        </c:when>
                                        <c:when test="${produit.quantite < 10}">
                                            <span class="bg-yellow-100 text-yellow-800 text-sm font-medium px-3 py-1 rounded-full flex items-center gap-1 w-fit">
                                                <i class="fas fa-exclamation text-yellow-500"></i>
                                                ${produit.quantite}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-green-100 text-green-800 text-sm font-medium px-3 py-1 rounded-full">
                                                ${produit.quantite}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="text-lg font-bold text-gray-900">
                                        <fmt:formatNumber value="${produit.prixVente}" pattern="##0.00" /> FCFA
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-center">
                                    <div class="flex items-center justify-center space-x-2">
                                        <a href="?page=produits/details&id=${produit.id}" 
                                            class="bg-blue-100 hover:bg-blue-200 text-blue-600 w-8 h-8 rounded-lg flex items-center justify-center transition-colors duration-200"
                                            title="Voir détails">
                                            <i class="fas fa-eye text-sm"></i>
                                        </a>
                                        <a href="?page=produits/modifier&id=${produit.id}" 
                                            class="bg-yellow-100 hover:bg-yellow-200 text-yellow-600 w-8 h-8 rounded-lg flex items-center justify-center transition-colors duration-200"
                                            title="Modifier">
                                            <i class="fas fa-edit text-sm"></i>
                                        </a>
                                        <button onclick="openDeleteModal(${produit.id}, '${produit.nom}')"
                                                class="bg-red-100 hover:bg-red-200 text-red-600 w-8 h-8 rounded-lg flex items-center justify-center transition-colors duration-200"
                                                title="Supprimer">
                                            <i class="fas fa-trash text-sm"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>


<!-- Modal de suppression -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
    <div class="bg-white rounded-2xl p-6 m-4 max-w-md w-full transform transition-all duration-300 scale-95 opacity-0" id="deleteModalContent">
        <div class="flex items-center gap-3 mb-4">
            <div class="w-12 h-12 bg-red-100 rounded-xl flex items-center justify-center">
                <i class="fas fa-exclamation-triangle text-red-500 text-xl"></i>
            </div>
            <h3 class="text-lg font-semibold text-gray-900">Confirmer la suppression</h3>
        </div>
        <p class="text-gray-600 mb-6">
            Êtes-vous sûr de vouloir supprimer le produit <strong id="productName"></strong> ?
            <br><span class="text-sm text-gray-500">Cette action est irréversible.</span>
        </p>
        <div class="flex gap-3">
            <button onclick="closeDeleteModal()" class="flex-1 bg-gray-500 hover:bg-gray-600 text-white px-4 py-3 rounded-lg font-medium transition-colors duration-200">
                Annuler
            </button>
            <form id="deleteForm" method="post" class="flex-1">
                <button type="submit" class="w-full bg-red-500 hover:bg-red-600 text-white px-4 py-3 rounded-lg font-medium transition-colors duration-200 flex items-center justify-center gap-2">
                    <i class="fas fa-trash"></i>
                    Supprimer
                </button>
            </form>
        </div>
    </div>
</div>

<script>
function openDeleteModal(id, name) {
    document.getElementById('productName').textContent = name;
    document.getElementById('deleteForm').action = '/produits/supprimer/' + id;
    const modal = document.getElementById('deleteModal');
    const content = document.getElementById('deleteModalContent');
    modal.classList.remove('hidden');
    modal.classList.add('flex');
    setTimeout(() => {
        content.classList.remove('scale-95', 'opacity-0');
        content.classList.add('scale-100', 'opacity-100');
    }, 10);
}

function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    const content = document.getElementById('deleteModalContent');
    content.classList.remove('scale-100', 'opacity-100');
    content.classList.add('scale-95', 'opacity-0');
    setTimeout(() => {
        modal.classList.remove('flex');
        modal.classList.add('hidden');
    }, 300);
}

// Fermer la modal en cliquant en dehors
document.getElementById('deleteModal').addEventListener('click', function(e) {
    if (e.target === this) {
        closeDeleteModal();
    }
});
</script>
