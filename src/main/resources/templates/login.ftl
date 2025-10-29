<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candy CRM - Вход в систему</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/mine.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="min-vh-100 d-flex align-items-center justify-content-center" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="card shadow-lg border-0">
                        <div class="card-body p-5">
                            <div class="text-center mb-4">
                                <i class="bi bi-gem text-primary" style="font-size: 3rem;"></i>
                                <h2 class="mt-3 mb-1">Candy CRM</h2>
                                <p class="text-muted">Вход в систему</p>
                            </div>

                            <#if logoutMessage??>
                                <div class="alert alert-success alert-dismissible fade show fade-in" role="alert">
                                    <i class="bi bi-check-circle me-2"></i>${logoutMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </#if>
                            <#if errorMessage??>
                                <div class="alert alert-danger alert-dismissible fade show fade-in" role="alert">
                                    <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </#if>

                            <form action="/login" method="post">
                                <div class="mb-3">
                                    <label for="username" class="form-label">
                                        <i class="bi bi-person me-1"></i>Имя пользователя
                                    </label>
                                    <input name="username" id="username" type="text" class="form-control" placeholder="Введите имя пользователя" required>
                                </div>
                                <div class="mb-4">
                                    <label for="password" class="form-label">
                                        <i class="bi bi-lock me-1"></i>Пароль
                                    </label>
                                    <input name="password" id="password" type="password" class="form-control" placeholder="Введите пароль" required>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 btn-lg">
                                    <i class="bi bi-box-arrow-in-right me-2"></i>Войти
                                </button>
                            </form>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4">
                        <p class="text-white-50 mb-0">Система управления | Candy CRM</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>