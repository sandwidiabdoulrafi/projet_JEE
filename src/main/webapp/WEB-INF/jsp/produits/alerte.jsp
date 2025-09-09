<%-- Page d'alerte des produits --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container mx-auto p-6">
    <h1 class="text-2xl font-bold mb-4 text-red-600">
        Produits en Alerte de Stock
    </h1>

    <c:choose>
        <c:when test="${not empty produits}">
            <div class="bg-red-50 border border-red-200 rounded-lg p-4 mb-4">
                <p class="text-red-800 font-semibold">
                    ${produits.size()} produit(s) nécessite(nt) un réapprovisionnement
                </p>
            </div>
            <div class="h-[600px] overflow-y-auto ">
            
                <table class="table-auto w-full border-collapse bg-white shadow-lg rounded-lg overflow-hidden">
                    <thead class="bg-red-600 text-white sticky top-0 z-10">
                        <tr>
                            <th class="px-6 py-3 text-left">Nom du Produit</th>
                            <th class="px-6 py-3 text-center">Quantité Actuelle</th>
                            <th class="px-6 py-3 text-center">Seuil d'Alerte</th>
                            <th class="px-6 py-3 text-center">Statut</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${produits}" varStatus="status">
                            <tr class="${status.index % 2 == 0 ? 'bg-red-50' : 'bg-white'}">
                                <td class="border-b px-6 py-4 font-medium">${p.nom}</td>
                                <td class="border-b px-6 py-4 text-center">
                                    <span class="bg-red-100 text-red-800 px-2 py-1 rounded-full text-sm font-bold">
                                        ${p.quantite}
                                    </span>
                                </td>
                                <td class="border-b px-6 py-4 text-center">${p.seuilAlerte}</td>
                                <td class="border-b px-6 py-4 text-center">
                                    <c:choose>
                                        <c:when test="${p.quantite == 0}">
                                            <span class="bg-red-600 text-white px-2 py-1 rounded-full text-xs">
                                                RUPTURE
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-orange-500 text-white px-2 py-1 rounded-full text-xs">
                                                STOCK FAIBLE
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        
        <c:otherwise>
            <div class="bg-green-50 border border-green-200 rounded-lg p-6 text-center">
                <h2 class="text-xl font-semibold text-green-800 mb-2">
                    Aucun produit en alerte !
                </h2>
                <p class="text-green-600">
                    Tous vos produits ont des stocks suffisants.
                </p>
            </div>
        </c:otherwise>
    </c:choose>
</div>