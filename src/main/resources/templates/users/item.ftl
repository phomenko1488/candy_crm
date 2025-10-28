<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали пользователя</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
<h1 class="mb-4">Детали пользователя</h1>

<#if user??>
    <div class="card">
        <div class="card-header">
            <h5>Основная информация</h5>
        </div>
        <div class="card-body">
            <p class="mb-2"><strong>ID:</strong> ${user.id}</p>
            <p class="mb-2"><strong>Имя:</strong> ${user.username}</p>
            <p class="mb-2"><strong>Роль:</strong> <span
                        class="badge bg-secondary">${user.role.name} (level ${user.role.level})</span></p>
            <p class="mb-2"><strong>Активен:</strong> <span
                        class="badge bg-${(user.active)?then('success', 'danger')}">${(user.active)?then('Да', 'Нет')}</span>
            </p>
            <p class="mb-2"><strong>Дата создания:</strong> ${user.createdAt}</p>
            <p class="mb-0"><strong>Дата обновления:</strong> ${user.updatedAt}</p>
        </div>
    </div>

    <a href="/users" class="btn btn-secondary mt-3">Назад к списку</a>
<#else>
    <div class="alert alert-warning">
        <h4>Пользователь не найден или доступ запрещён.</h4>
        <a href="/users" class="btn btn-primary">Вернуться к списку</a>
    </div>
</#if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>