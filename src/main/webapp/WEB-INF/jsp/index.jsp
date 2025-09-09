<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Accueil - Gestion des Stocks</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#1f2937',
                        secondary: '#374151',
                        accent: '#3b82f6',
                        success: '#10b981',
                        warning: '#f59e0b',
                        danger: '#ef4444'
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.5s ease-in-out',
                        'slide-in': 'slideIn 0.3s ease-out',
                        'bounce-subtle': 'bounceSubtle 0.6s ease-in-out'
                    }
                }
            }
        }
    </script>
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes slideIn {
            from { transform: translateX(-100%); }
            to { transform: translateX(0); }
        }
        
        @keyframes bounceSubtle {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-3px); }
            60% { transform: translateY(-2px); }
        }
        
        .nav-item {
            position: relative;
            overflow: hidden;
        }
        
        .nav-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
            transition: left 0.5s;
        }
        
        .nav-item:hover::before {
            left: 100%;
        }
        
        .glass-effect {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
    <div class="h-screen w-screen flex flex-col">
        <!-- Header avec effet de verre -->
        <header class="glass-effect backdrop-blur-md bg-gradient-to-r from-primary to-secondary text-white shadow-2xl relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-blue-600/20 to-purple-600/20"></div>
            <div class="relative flex items-center justify-between p-4 z-10">
                <div class="flex items-center gap-4 animate-slide-in">
                    <div class="w-10 h-10 bg-gradient-to-r from-blue-400 to-purple-500 rounded-lg flex items-center justify-center shadow-lg">
                        <i class="fas fa-boxes text-white text-lg"></i>
                    </div>
                    <h1 class="text-2xl font-bold bg-gradient-to-r from-white to-gray-200 bg-clip-text text-transparent">
                        Gestion Stocks Pro
                    </h1>
                </div>
                <div class="flex items-center gap-3 animate-fade-in">
                    <div class="flex items-center gap-2 bg-white/10 rounded-full px-4 py-2 backdrop-blur-sm">
                        <div class="w-8 h-8 bg-gradient-to-r from-green-400 to-blue-500 rounded-full flex items-center justify-center">
                            <i class="fas fa-user text-white text-sm"></i>
                        </div>
                        <span class="font-medium">Admin</span>
                    </div>
                </div>
            </div>
        </header>

        <!-- Contenu principal -->
        <div class="flex flex-1 overflow-hidden">
            <!-- Sidebar moderne avec effets -->
            <nav class="w-72 bg-gradient-to-b from-gray-900 via-gray-800 to-gray-900 text-white shadow-2xl relative animate-slide-in">
                <!-- Effet de particules -->
                <div class="absolute inset-0 opacity-10">
                    <div class="absolute top-10 left-10 w-2 h-2 bg-blue-400 rounded-full animate-pulse"></div>
                    <div class="absolute top-32 right-8 w-1 h-1 bg-purple-400 rounded-full animate-ping"></div>
                    <div class="absolute bottom-32 left-16 w-1.5 h-1.5 bg-green-400 rounded-full animate-pulse"></div>
                </div>
                
                <div class="relative p-6 z-10">
                    <!-- Menu title -->
                    <div class="mb-8">
                        <h2 class="text-lg font-semibold text-gray-300 mb-2">Navigation</h2>
                        <div class="w-12 h-0.5 bg-gradient-to-r from-blue-400 to-purple-500 rounded-full"></div>
                    </div>
                    
                    <!-- Menu items -->
                    <div class="space-y-3">
                        <a href="?page=produits/liste"  class="nav-item group relative py-4 px-5 rounded-xl flex items-center gap-4 hover:bg-gradient-to-r hover:from-blue-600/20 hover:to-purple-600/20 transition-all duration-300 hover:transform hover:scale-105 hover:shadow-lg">
                            <div class="w-10 h-10 bg-gradient-to-r from-blue-500 to-blue-600 rounded-lg flex items-center justify-center shadow-md group-hover:shadow-blue-500/25 transition-shadow duration-300">
                                <i class="fas fa-eye text-white"></i>
                            </div>
                            <span class="font-medium group-hover:text-blue-300 transition-colors duration-300">Voir les produits</span>
                            <i class="fas fa-chevron-right ml-auto text-gray-400 group-hover:text-blue-300 group-hover:translate-x-1 transition-all duration-300"></i>
                        </a>
                        
                        <a  href="?page=produits/ajouter" class="nav-item group relative py-4 px-5 rounded-xl flex items-center gap-4 hover:bg-gradient-to-r hover:from-green-600/20 hover:to-emerald-600/20 transition-all duration-300 hover:transform hover:scale-105 hover:shadow-lg">
                            <div class="w-10 h-10 bg-gradient-to-r from-green-500 to-emerald-600 rounded-lg flex items-center justify-center shadow-md group-hover:shadow-green-500/25 transition-shadow duration-300">
                                <i class="fas fa-plus text-white"></i>
                            </div>
                            <span class="font-medium group-hover:text-green-300 transition-colors duration-300">Ajouter un produit</span>
                            <i class="fas fa-chevron-right ml-auto text-gray-400 group-hover:text-green-300 group-hover:translate-x-1 transition-all duration-300"></i>
                        </a>
                        
                        <a href="?page=produits/alerte" class="nav-item group relative py-4 px-5 rounded-xl flex items-center gap-4 hover:bg-gradient-to-r hover:from-red-600/20 hover:to-pink-600/20 transition-all duration-300 hover:transform hover:scale-105 hover:shadow-lg">
                            <div class="w-10 h-10 bg-gradient-to-r from-red-500 to-pink-600 rounded-lg flex items-center justify-center shadow-md group-hover:shadow-red-500/25 transition-shadow duration-300 relative">
                                <i class="fas fa-bell text-white"></i>
                                <span class="absolute -top-1 -right-1 w-3 h-3 bg-yellow-400 rounded-full animate-ping"></span>
                                <span class="absolute -top-1 -right-1 w-3 h-3 bg-yellow-500 rounded-full"></span>
                            </div>
                            <span class="font-medium group-hover:text-red-300 transition-colors duration-300">Alertes Stock</span>
                            <i class="fas fa-chevron-right ml-auto text-gray-400 group-hover:text-red-300 group-hover:translate-x-1 transition-all duration-300"></i>
                        </a>
                        
                    </div>
                    
                </div>
            </nav>
            

            <!-- Zone de contenu principale - OUTLET DYNAMIQUE -->
            <main class="flex-1 overflow-auto p-6 animate-fade-in">
                <c:choose>
                    <c:when test="${param.page == 'produits/ajouter'}">
                        <c:import url="/produits/ajouter" />
                    </c:when>
                    <c:when test="${param.page == 'produits/modifier'}">
                        <c:import url="/produits/modifier" />
                    </c:when>
                    <c:when test="${param.page == 'produits/details'}">
                        <c:import url="/produits/details" />
                    </c:when>
                    <c:when test="${param.page == 'produits/alerte'}">
                        <c:import url="/produits/alerte"/>
                    </c:when>
                    <c:otherwise>
                        <c:import url="/produits/liste" />
                    </c:otherwise>
                </c:choose> 
                
            </main>
        </div>
    </div>
</body>
</html>

