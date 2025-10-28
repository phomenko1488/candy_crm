<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Детали операции</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
<h1 class="mb-4">Детали финансовой операции</h1>

<#if operation??>
    <div class="card">
        <div class="card-header">
            <h5>Основная информация</h5>
        </div>
        <div class="card-body">
            <p class="mb-2"><strong>ID:</strong> ${operation.id}</p>
            <p class="mb-2"><strong>Тип:</strong> <span class="badge bg-${(operation.type == 'INCOME')?then('success', 'danger')}">${operation.type}</span></p>
            <p class="mb-2"><strong>Сумма:</strong> ${operation.amount}</p>
            <p class="mb-2"><strong>Комментарий:</strong> ${operation.comment}</p>
            <p class="mb-2"><strong>Дата создания:</strong> ${operation.createdAt}</p>
            <p class="mb-0"><strong>Дата обновления:</strong> ${operation.updatedAt}</p>
        </div>
    </div>

    <#if operation.order??>
        <div class="card mt-4">
            <div class="card-header">
                <h5>Связанный заказ</h5>
            </div>
            <div class="card-body">
                <p class="mb-0">ID заказа: ${operation.order.id}</p>
                <!-- Добавь больше деталей о заказе, если нужно -->
            </div>
        </div>
    </#if>

    <#if operation.product??>
        <div class="card mt-4">
            <div class="card-header">
                <h5>Связанный продукт</h5>
            </div>
            <div class="card-body">
                <p class="mb-0">Продукт: ${operation.product.name} (цена: ${operation.product.price})</p>
            </div>
        </div>
    </#if>

    <#if operation.salary??>
        <div class="card mt-4">
            <div class="card-header">
                <h5>Зарплата</h5>
            </div>
            <div class="card-body">
                <p class="mb-2"><strong>Описание:</strong> ${operation.salary.description}</p>
                <p class="mb-2"><strong>Период:</strong> ${operation.salary.startDate} - ${operation.salary.endDate}</p>
                <p class="mb-0"><strong>Сумма:</strong> ${operation.salary.amount}</p>
            </div>
        </div>
    </#if>

    <a href="/finance-operations" class="btn btn-secondary mt-3">Назад к списку</a>
<#else>
    <div class="alert alert-warning">
        <h4>Операция не найдена.</h4>
        <a href="/finance-operations" class="btn btn-primary">Вернуться к списку</a>
    </div>
</#if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>