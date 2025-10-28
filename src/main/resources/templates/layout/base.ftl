<#macro page title="">
<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRM System - ${title!"Главная"}</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/mine.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">CRM System</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <!-- Склад -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            Склад
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/warehouse">Товары</a></li>
                            <li><a class="dropdown-item" href="/jewelry">Украшения</a></li>
                        </ul>
                    </li>
                    
                    <!-- Заказы -->
                    <li class="nav-item">
                        <a class="nav-link" href="/orders">Заказы</a>
                    </li>
                    
                    <!-- Пользователи -->
                    <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR") || user.hasRole("MANAGER"))>
                        <li class="nav-item">
                            <a class="nav-link" href="/users">Пользователи</a>
                        </li>
                    </#if>
                    
                    <!-- Финансы -->
                    <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR"))>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                Финансы
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/finance/income">Входящие</a></li>
                                <li><a class="dropdown-item" href="/finance/expense">Расходы</a></li>
                            </ul>
                        </li>
                    </#if>
                </ul>
                
                <ul class="navbar-nav">
                    <#if user??>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle"></i> ${user.username}
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/profile">Профиль</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="/logout">Выход</a></li>
                            </ul>
                        </li>
                    <#else>
                        <li class="nav-item">
                            <a class="nav-link" href="/login">Вход</a>
                        </li>
                    </#if>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container mt-4">
        <!-- Уведомления -->
        <#if successMessage??>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </#if>
        <#if errorMessage??>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </#if>

        <#nested>
    </main>

    <footer class="bg-dark text-light py-3 mt-5">
        <div class="container text-center">
            <p>&copy; 2025 CRM System. Все права защищены.</p>
        </div>
    </footer>

    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
</#macro>
