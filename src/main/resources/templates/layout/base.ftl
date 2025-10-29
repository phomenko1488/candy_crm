<#macro page title="">
<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candy CRM - ${title!"Главная"}</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/mine.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <!-- Header -->
    <header>
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand" href="/">
                    <i class="bi bi-gem me-2"></i><span class="d-none d-sm-inline">Candy CRM</span><span class="d-sm-none">CRM</span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <!-- Склад -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-box-seam me-1"></i><span class="d-none d-md-inline">Склад</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="/products"><i class="bi bi-box me-2"></i>Товары</a></li>
                                <li><a class="dropdown-item" href="/decorations"><i class="bi bi-gem me-2"></i>Украшения</a></li>
                            </ul>
                        </li>
                        
                        <!-- Заказы -->
                        <li class="nav-item">
                            <a class="nav-link" href="/orders">
                                <i class="bi bi-cart-check me-1"></i><span class="d-none d-md-inline">Заказы</span>
                            </a>
                        </li>
                        
                        <!-- Пользователи -->
                        <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR") || user.hasRole("MANAGER"))>
                            <li class="nav-item">
                                <a class="nav-link" href="/users">
                                    <i class="bi bi-people me-1"></i><span class="d-none d-md-inline">Пользователи</span>
                                </a>
                            </li>
                        </#if>
                        
                        <!-- Финансы -->
                        <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR"))>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-cash-stack me-1"></i><span class="d-none d-md-inline">Финансы</span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/finance/income"><i class="bi bi-arrow-down-circle me-2"></i>Доходы</a></li>
                                    <#if user.hasRole("ADMIN")>
                                        <li><a class="dropdown-item" href="/finance/expense"><i class="bi bi-arrow-up-circle me-2"></i>Расходы и зарплаты</a></li>
                                    </#if>
                                </ul>
                            </li>
                        </#if>
                    </ul>
                    
                    <ul class="navbar-nav">
                        <#if user??>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="bi bi-person-circle me-1"></i><span class="d-none d-sm-inline">${user.username}</span>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="/profile"><i class="bi bi-person me-2"></i>Профиль</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="/logout"><i class="bi bi-box-arrow-right me-2"></i>Выход</a></li>
                                </ul>
                            </li>
                        <#else>
                            <li class="nav-item">
                                <a class="nav-link" href="/login">
                                    <i class="bi bi-box-arrow-in-right me-1"></i><span class="d-none d-sm-inline">Вход</span>
                                </a>
                            </li>
                        </#if>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="container">
        <!-- Уведомления -->
        <#if successMessage??>
            <div class="alert alert-success alert-dismissible fade show fade-in" role="alert">
                <i class="bi bi-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </#if>
        <#if errorMessage??>
            <div class="alert alert-danger alert-dismissible fade show fade-in" role="alert">
                <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </#if>

        <#nested>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2025 Candy CRM. Все права защищены.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0 text-muted">Система управления кондитерской</p>
                </div>
            </div>
        </div>
    </footer>

    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>
</#macro>
