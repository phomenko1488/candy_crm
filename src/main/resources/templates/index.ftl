<#import "layout/base.ftl" as base>
<@base.page title="Главная">
    <!-- Hero Section -->
    <div class="row mb-4 mb-lg-5">
        <div class="col-12">
            <div class="text-center">
                <h1 class="display-4 fw-bold mb-3">
                    <i class="bi bi-gem text-primary me-2 me-md-3"></i><span class="d-none d-md-inline">Добро пожаловать в Candy CRM</span><span class="d-md-none">Candy CRM</span>
                </h1>
                <p class="lead text-muted mb-4">Современная система управления | Candy CRM</p>
                <div class="row justify-content-center">
                    <div class="col-12 col-md-8">
                        <div class="card border-0 bg-light">
                            <div class="card-body p-3 p-md-4">
                                <p class="mb-0 text-secondary">
                                    <i class="bi bi-info-circle me-2"></i>
                                    <#if user??>
                                        Добро пожаловать, ${user.username}! Ваша роль: ${user.role.name}
                                    <#else>
                                        Управляйте складом, заказами, пользователями и финансами в одном месте
                                    </#if>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Features Grid -->
    <div class="row g-3 g-md-4 mb-4 mb-lg-5">
        <!-- Склад товаров - доступен всем -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-3 p-md-4">
                    <div class="mb-3">
                        <i class="bi bi-box text-primary" style="font-size: 2.5rem;"></i>
                    </div>
                    <h5 class="card-title">Склад товаров</h5>
                    <p class="card-text text-muted small">Управление товарами и их остатками</p>
                    <a href="/products" class="btn btn-primary btn-sm">
                        <i class="bi bi-arrow-right me-1"></i>Перейти
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Склад украшений - доступен всем -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-3 p-md-4">
                    <div class="mb-3">
                        <i class="bi bi-gem text-success" style="font-size: 2.5rem;"></i>
                    </div>
                    <h5 class="card-title">Склад украшений</h5>
                    <p class="card-text text-muted small">Управление украшениями и шаблонами</p>
                    <a href="/decorations" class="btn btn-success btn-sm">
                        <i class="bi bi-arrow-right me-1"></i>Перейти
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Заказы - доступны всем -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-3 p-md-4">
                    <div class="mb-3">
                        <i class="bi bi-cart-check text-warning" style="font-size: 2.5rem;"></i>
                    </div>
                    <h5 class="card-title">Заказы</h5>
                    <p class="card-text text-muted small">Управление заказами клиентов</p>
                    <a href="/orders" class="btn btn-warning btn-sm">
                        <i class="bi bi-arrow-right me-1"></i>Перейти
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Пользователи - только для Админа, Директора и Менеджера -->
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100 border-0 shadow-sm">
                <div class="card-body text-center p-3 p-md-4">
                    <div class="mb-3">
                        <i class="bi bi-people text-info" style="font-size: 2.5rem;"></i>
                    </div>
                    <h5 class="card-title">Пользователи</h5>
                    <p class="card-text text-muted small">Управление пользователями системы</p>
                    <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR") || user.hasRole("MANAGER"))>
                        <a href="/users" class="btn btn-info btn-sm">
                            <i class="bi bi-arrow-right me-1"></i>Перейти
                        </a>
                    <#else>
                        <button class="btn btn-secondary btn-sm disabled">
                            <i class="bi bi-lock me-1"></i>Нет доступа
                        </button>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Financial Section (for authorized users) -->
    <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR"))>
    <div class="row g-3 g-md-4 mb-4 mb-lg-5">
        <div class="col-12">
            <h3 class="text-center mb-4">
                <i class="bi bi-cash-stack me-2"></i>Финансовое управление
            </h3>
        </div>
        
        <!-- Доходы - доступны Админу и Директору -->
        <div class="col-12 col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center p-3 p-md-4">
                    <div class="mb-3">
                        <i class="bi bi-arrow-down-circle text-success" style="font-size: 2.5rem;"></i>
                    </div>
                    <h5 class="card-title">Доходы</h5>
                    <p class="card-text text-muted small">Просмотр доходов от выполненных заказов</p>
                    <a href="/finance/income" class="btn btn-success btn-sm">
                        <i class="bi bi-arrow-right me-1"></i>Перейти
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Расходы и зарплаты - только для Админа -->
        <div class="col-12 col-md-6">
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center p-3 p-md-4">
                    <div class="mb-3">
                        <i class="bi bi-arrow-up-circle text-danger" style="font-size: 2.5rem;"></i>
                    </div>
                    <h5 class="card-title">Расходы и зарплаты</h5>
                    <p class="card-text text-muted small">Управление расходами и зарплатами</p>
                    <#if user.hasRole("ADMIN")>
                        <a href="/finance/expense" class="btn btn-danger btn-sm">
                            <i class="bi bi-arrow-right me-1"></i>Перейти
                        </a>
                    <#else>
                        <button class="btn btn-secondary btn-sm disabled">
                            <i class="bi bi-lock me-1"></i>Нет доступа
                        </button>
                    </#if>
                </div>
            </div>
        </div>
    </div>
    </#if>

    <!-- Role-specific sections -->
    <#if user??>
        <!-- Админ - полный доступ -->
        <#if user.hasRole("ADMIN")>
        <div class="row mb-4 mb-lg-5">
            <div class="col-12">
                <div class="card border-0 bg-dark text-white">
                    <div class="card-body text-center p-3 p-md-4">
                        <h4 class="mb-3">
                            <i class="bi bi-shield-check me-2"></i>Администратор
                        </h4>
                        <p class="mb-3">Полный доступ ко всем разделам системы</p>
                        <div class="row g-2">
                            <div class="col-6 col-md-3">
                                <a href="/products" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-box me-1"></i><span class="d-none d-sm-inline">Товары</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/decorations" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-gem me-1"></i><span class="d-none d-sm-inline">Украшения</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/orders" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-cart-check me-1"></i><span class="d-none d-sm-inline">Заказы</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/users" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-people me-1"></i><span class="d-none d-sm-inline">Пользователи</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Директор - доступ везде кроме расходов+зп -->
        <#elseif user.hasRole("DIRECTOR")>
        <div class="row mb-4 mb-lg-5">
            <div class="col-12">
                <div class="card border-0 bg-primary text-white">
                    <div class="card-body text-center p-3 p-md-4">
                        <h4 class="mb-3">
                            <i class="bi bi-person-badge me-2"></i>Директор
                        </h4>
                        <p class="mb-3">Доступ ко всем разделам кроме расходов и зарплат</p>
                        <div class="row g-2">
                            <div class="col-6 col-md-3">
                                <a href="/products" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-box me-1"></i><span class="d-none d-sm-inline">Товары</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/decorations" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-gem me-1"></i><span class="d-none d-sm-inline">Украшения</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/orders" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-cart-check me-1"></i><span class="d-none d-sm-inline">Заказы</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/users" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-people me-1"></i><span class="d-none d-sm-inline">Пользователи</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Конструктор - доступ только к товарам и украшениям -->
        <#elseif user.hasRole("CONSTRUCTOR")>
        <div class="row mb-4 mb-lg-5">
            <div class="col-12">
                <div class="card border-0 bg-success text-white">
                    <div class="card-body text-center p-3 p-md-4">
                        <h4 class="mb-3">
                            <i class="bi bi-tools me-2"></i>Конструктор
                        </h4>
                        <p class="mb-3">Доступ только к товарам и украшениям</p>
                        <div class="row g-2">
                            <div class="col-6">
                                <a href="/products" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-box me-1"></i><span class="d-none d-sm-inline">Товары</span>
                                </a>
                            </div>
                            <div class="col-6">
                                <a href="/decorations" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-gem me-1"></i><span class="d-none d-sm-inline">Украшения</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </#if>
        
        <!-- Quick Access -->
        <div class="row mt-4 mt-lg-5">
            <div class="col-12">
                <div class="card border-0 bg-secondary text-white">
                    <div class="card-body text-center p-3 p-md-4">
                        <h4 class="mb-3">
                            <i class="bi bi-speedometer2 me-2"></i>Быстрый доступ
                        </h4>
                        <div class="row g-2">
                            <div class="col-6 col-md-3">
                                <a href="/products" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-box me-1"></i><span class="d-none d-sm-inline">Товары</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/decorations" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-gem me-1"></i><span class="d-none d-sm-inline">Украшения</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <a href="/orders" class="btn btn-light btn-sm w-100">
                                    <i class="bi bi-cart-check me-1"></i><span class="d-none d-sm-inline">Заказы</span>
                                </a>
                            </div>
                            <div class="col-6 col-md-3">
                                <#if user.hasRole("ADMIN") || user.hasRole("DIRECTOR") || user.hasRole("MANAGER")>
                                    <a href="/users" class="btn btn-light btn-sm w-100">
                                        <i class="bi bi-people me-1"></i><span class="d-none d-sm-inline">Пользователи</span>
                                    </a>
                                <#else>
                                    <button class="btn btn-light btn-sm w-100 disabled">
                                        <i class="bi bi-lock me-1"></i><span class="d-none d-sm-inline">Пользователи</span>
                                    </button>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</@base.page>