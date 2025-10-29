<#import "../layout/base.ftl" as base>

<@base.page title="Пользователи">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-people text-primary me-2"></i>Пользователи
                    </h1>
                    <p class="text-muted mb-0">Управление пользователями системы</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-funnel me-2"></i>Фильтр по роли
                    </h5>
                </div>
                <div class="card-body">
                    <form method="get" action="/users" class="row g-3">
                        <div class="col-md-4">
                            <label for="roleId" class="form-label">Роль:</label>
                            <select name="roleId" id="roleId" class="form-select">
                                <option value="">Все нижестоящие</option>
                                <#list allRoles as r>
                                    <option value="${r.id}" <#if currentRoleId?? && currentRoleId == r.id>selected</#if>>${r.name}</option>
                                </#list>
                            </select>
                        </div>
                        <div class="col-md-2 d-flex align-items-end">
                            <input type="hidden" name="page" value="0" />
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-search me-1"></i>Фильтровать
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Add User Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-person-plus me-2"></i>Добавить нижестоящего пользователя
                    </h5>
                </div>
                <div class="card-body">
                    <form method="post" action="/users" class="row g-3">
                        <div class="col-md-3">
                            <label for="name" class="form-label">
                                <i class="bi bi-person me-1"></i>Имя:
                            </label>
                            <input type="text" name="name" id="name" class="form-control" placeholder="Введите имя" value="${userCreateRequest.name!''}" required />
                        </div>
                        <div class="col-md-3">
                            <label for="password" class="form-label">
                                <i class="bi bi-lock me-1"></i>Пароль:
                            </label>
                            <input type="password" name="password" id="password" class="form-control" placeholder="Введите пароль" required />
                        </div>
                        <div class="col-md-2">
                            <label for="roleId" class="form-label">
                                <i class="bi bi-shield me-1"></i>Роль:
                            </label>
                            <select name="roleId" id="roleId" class="form-select" required>
                                <#list availableRoles as r>
                                    <option value="${r.id}" <#if userCreateRequest.roleId?? && userCreateRequest.roleId == r.id>selected</#if>>${r.name} (level ${r.level})</option>
                                </#list>
                            </select>
                        </div>
                        <div class="col-md-1 d-flex align-items-end">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-circle me-1"></i>Добавить
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Users Table -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Нижестоящие пользователи
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th><i class="bi bi-hash me-1"></i>ID</th>
                                    <th><i class="bi bi-person me-1"></i>Username</th>
                                    <th><i class="bi bi-shield me-1"></i>Роль</th>
                                    <th><i class="bi bi-toggle-on me-1"></i>Активен</th>
                                    <th><i class="bi bi-calendar me-1"></i>Дата создания</th>
                                    <th><i class="bi bi-gear me-1"></i>Действия</th>
                                </tr>
                            </thead>
                            <tbody>
                                <#list usersPage.content as user>
                                    <tr>
                                        <td><span class="badge bg-secondary">#${user.id}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-person-circle text-primary me-2"></i>
                                                <span class="fw-medium">${user.username}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-info">${user.role.name} (level ${user.role.level})</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-${(user.active)?then('success', 'danger')}">
                                                <i class="bi bi-${(user.active)?then('check-circle', 'x-circle')} me-1"></i>
                                                ${(user.active)?then('Да', 'Нет')}
                                            </span>
                                        </td>
                                        <td><span class="text-muted">${user.createdAt}</span></td>
                                        <td>
                                            <div class="d-flex gap-1">
                                                <a href="/users/${user.id}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye me-1"></i>Подробнее
                                                </a>
                                                <form method="post" action="/users/${user.id}/toggle-active" style="display: inline;">
                                                    <button type="submit" class="btn btn-sm btn-${(user.active)?then('warning', 'info')}">
                                                        <i class="bi bi-${(user.active)?then('pause', 'play')} me-1"></i>
                                                        ${(user.active)?then('Выключить', 'Включить')}
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <#if usersPage.totalPages gt 1>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация пользователей">
                    <ul class="pagination justify-content-center">
                        <#list 0..(usersPage.totalPages - 1) as i>
                            <li class="page-item <#if i == usersPage.number>active</#if>">
                                <a class="page-link" href="/users?page=${i}&size=${usersPage.size}<#if currentRoleId??>&roleId=${currentRoleId}</#if>">${i + 1}</a>
                            </li>
                        </#list>
                    </ul>
                </nav>
            </div>
        </div>
    </#if>
</@base.page>