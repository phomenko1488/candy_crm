<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Финансовые операции</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">
<h1 class="mb-4">Список финансовых операций</h1>

<#if successMessage?? && successMessage != "">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        ${successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</#if>

<!-- Фильтр по типу -->
<div class="card mb-4">
    <div class="card-header">
        <h5>Фильтр по типу</h5>
    </div>
    <div class="card-body">
        <form method="get" action="/finance-operations" class="row g-3">
            <div class="col-md-4">
                <label for="type" class="form-label">Тип операции:</label>
                <select name="type" id="type" class="form-select">
                    <option value="">Все</option>
                    <#list types as t>
                        <option value="${t.name()}" <#if currentType?? && currentType.name() == t.name()>selected</#if>>${t}</option>
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

<!-- Форма добавления зарплаты -->
<div class="card mb-4">
    <div class="card-header">
        <h5>Добавить зарплату</h5>
    </div>
    <div class="card-body">
        <form method="post" action="/finance-operations/salary" class="row g-3" id="salaryForm">
            <div class="col-md-3">
                <label for="startDate" class="form-label">Дата начала:</label>
                <input type="datetime-local"
                       name="startDate"
                       id="startDate"
                       class="form-control"
                       value="<#if salaryCreateRequest.startDate??>${salaryCreateRequest.startDate?string('yyyy-MM-dd\'T\'HH:mm')}</#if>"
                       required />
            </div>

            <div class="col-md-3">
                <label for="endDate" class="form-label">Дата окончания:</label>
                <input type="datetime-local"
                       name="endDate"
                       id="endDate"
                       class="form-control"
                       value="<#if salaryCreateRequest.endDate??>${salaryCreateRequest.endDate?string('yyyy-MM-dd\'T\'HH:mm')}</#if>"
                       required />
            </div>

            <div class="col-md-3">
                <label for="comment" class="form-label">Комментарий:</label>
                <input type="text"
                       name="comment"
                       id="comment"
                       class="form-control"
                       placeholder="Комментарий"
                       value="${salaryCreateRequest.comment!''}"
                       required />
            </div>

            <div class="col-md-2">
                <label for="amount" class="form-label">Сумма:</label>
                <input type="number"
                       name="amount"
                       id="amount"
                       class="form-control"
                       step="0.01"
                       placeholder="Сумма"
                       min="0"
                       value="<#if salaryCreateRequest.amount??>${salaryCreateRequest.amount?string}</#if>"
                       required />
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
        <h5>Операции</h5>
    </div>
    <div class="card-body p-0">
        <table class="table table-striped table-hover mb-0">
            <thead>
            <tr>
                <th>ID</th>
                <th>Тип</th>
                <th>Сумма</th>
                <th>Комментарий</th>
                <th>Дата создания</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody>
            <#list operationsPage.content as op>
                <tr>
                    <td>${op.id}</td>
                    <td><span class="badge bg-${(op.type == 'INCOME')?then('success', 'danger')}">${op.type}</span></td>
                    <td>${op.amount}</td>
                    <td>${op.comment}</td>
                    <td>${op.createdAt}</td>
                    <td><a href="/finance-operations/${op.id}" class="btn btn-sm btn-outline-primary">Подробнее</a></td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
</div>

<!-- Пагинация -->
<#if operationsPage.totalPages gt 1>
    <nav aria-label="Пагинация" class="mt-3">
        <ul class="pagination justify-content-center">
            <#list 0..(operationsPage.totalPages - 1) as i>
                <li class="page-item <#if i == operationsPage.number>active</#if>">
                    <a class="page-link" href="/finance-operations?page=${i}&size=${operationsPage.size}<#if currentType??>&type=${currentType.name()}</#if>">${i + 1}</a>
                </li>
            </#list>
        </ul>
    </nav>
</#if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');

        if (startDateInput && endDateInput) {
            startDateInput.addEventListener('change', function() {
                const startValue = this.value;
                if (startValue) {
                    endDateInput.min = startValue;
                }
            });

            const now = new Date().toISOString().slice(0, 16);
            startDateInput.min = now;
            endDateInput.min = now;
        }
    });
</script>
</body>
</html>