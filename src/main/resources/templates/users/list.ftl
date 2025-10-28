<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Пользователи</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
<h1 class="mb-4">Список пользователей</h1>

<#if successMessage?? && successMessage != "">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ${successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</#if>

<!-- Фильтр по роли -->
<div class="card mb-4">
    <div class="card-header">
        <h5>Фильтр по роли</h5>
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
                <button type="submit" class="btn btn-primary">Фильтровать</button>
            </div>
        </form>
    </div>
</div>

<!-- Форма добавления пользователя (только availableRoles) -->
<div class="card mb-4">
    <div class="card-header">
        <h5>Добавить нижестоящего пользователя</h5>
    </div>
    <div class="card-body">
        <form method="post" action="/users" class="row g-3">
            <div class="col-md-3">
                <label for="name" class="form-label">Имя:</label>
                <input type="text" name="name" id="name" class="form-control" placeholder="Имя" value="${userCreateRequest.name!''}" required />
            </div>

            <div class="col-md-3">
                <label for="password" class="form-label">Пароль:</label>
                <input type="password" name="password" id="password" class="form-control" placeholder="Пароль" required />
            </div>

            <div class="col-md-2">
                <label for="roleId" class="form-label">Роль:</label>
                <select name="roleId" id="roleId" class="form-select" required>
                    <#list availableRoles as r>
                        <option value="${r.id}" <#if userCreateRequest.roleId?? && userCreateRequest.roleId == r.id>selected</#if>>${r.name} (level ${r.level})</option>
                    </#list>
                </select>
            </div>

            <div class="col-md-1 d-flex align-items-end">
                <button type="submit" class="btn btn-success">Добавить</button>
            </div>
        </form>
    </div>
</div>

<!-- Пагинированный список -->
<div class="card">
    <div class="card-header">
        <h5>Нижестоящие пользователи</h5>
    </div>
    <div class="card-body p-0">
        <table class="table table-striped table-hover mb-0">
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Роль</th>
                <th>Активен</th>
                <th>Дата создания</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody>
            <#list usersPage.content as user>
                <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                    <td><span class="badge bg-secondary">${user.role.name} (level ${user.role.level})</span></td>
                    <td><span class="badge bg-${(user.active)?then('success', 'danger')}">${(user.active)?then('Да', 'Нет')}</span></td>
                    <td>${user.createdAt}</td>
                    <td>
                        <a href="/users/${user.id}" class="btn btn-sm btn-outline-primary me-1">Подробнее</a>
                        <form method="post" action="/users/${user.id}/toggle-active" style="display: inline;">
                            <button type="submit" class="btn btn-sm btn-${(user.active)?then('warning', 'info')}">${(user.active)?then('Выключить', 'Включить')}</button>
                        </form>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</div>

<!-- Пагинация -->
<#if usersPage.totalPages gt 1>
    <nav aria-label="Пагинация" class="mt-3">
        <ul class="pagination justify-content-center">
            <#list 0..(usersPage.totalPages - 1) as i>
                <li class="page-item <#if i == usersPage.number>active</#if>">
                    <a class="page-link" href="/users?page=${i}&size=${usersPage.size}<#if currentRoleId??>&roleId=${currentRoleId}</#if>">${i + 1}</a>
                </li>
            </#list>
        </ul>
    </nav>
</#if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>