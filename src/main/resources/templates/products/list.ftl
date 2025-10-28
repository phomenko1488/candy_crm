<#import "../blocks/pagination.ftl" as p>

<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Склад товаров</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Склад товаров</h1>

    <#-- Сообщения -->
    <#if successMessage??>
        <div class="alert alert-success">${successMessage}</div>
    </#if>
    <#if errorMessage??>
        <div class="alert alert-danger">${errorMessage}</div>
    </#if>

    <div class="d-flex gap-2 mb-3">
        <button class="btn btn-success" id="toggleCreateForm">Добавить товар</button>
        <button class="btn btn-primary" id="toggleIncomeForm">Добавить привоз</button>
        <button class="btn btn-warning" id="toggleOutcomeForm">Списание</button>
    </div>

    <#-- Форма создания нового товара -->
    <div id="createForm" class="border rounded p-4 bg-light shadow-sm mb-4 d-none">
        <h3>Создание нового товара</h3>
        <form action="/products" method="post">
            <div class="mb-3">
                <label class="form-label">Название</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Описание</label>
                <textarea name="description" class="form-control" rows="3"></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Цвет</label>
                <input type="text" name="color" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Покрытие</label>
                <#--                <input type="text" name="name" class="form-control" required>-->
                <select name="cover" class="form-select">
                    <option value="Матовый">Матовое</option>
                    <option value="Матовый">Глянцевое</option>
                    <option value="Матовый">Голографическое</option>
                    <option value="Матовый">Другое</option>
                </select>

            </div>


            <div class="mb-3">
                <label class="form-label">Цена</label>
                <input type="number" name="price" class="form-control" step="0.01" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Мин. остаток</label>
                <input type="number" name="minQuantity" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Единица измерения</label>
                <input type="text" name="unit" class="form-control" placeholder="шт, кг и т.д." required>
            </div>

            <button type="submit" class="btn btn-primary">Создать</button>
        </form>
    </div>

    <#-- Форма добавления ПРИВОЗА -->
    <div id="incomeForm" class="border rounded p-4 bg-light shadow-sm mb-4 d-none">
        <h3>Добавить привоз (приход)</h3>
        <form action="/products/operations" method="post">
            <input type="hidden" name="type" value="INCOME">

            <div class="mb-3">
                <label class="form-label">Товар</label>
                <select name="productId" class="form-select" required>
                    <#list products as p>
                        <option value="${p.id}">${p.name}</option>
                    </#list>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Количество</label>
                <input type="number" name="amount" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Цена (за все)</label>
                <input type="number" step="0.01" name="price" class="form-control" required>
            </div>
            <input type="hidden" name="type" value="INCOME">
            <button type="submit" class="btn btn-primary">Добавить приход</button>
        </form>
    </div>

    <#-- Форма добавления СПИСАНИЯ -->
    <div id="outcomeForm" class="border rounded p-4 bg-light shadow-sm mb-4 d-none">
        <h3>Списание (расход)</h3>
        <form action="/products/operations" method="post">
            <input type="hidden" name="type" value="OUTCOME">

            <div class="mb-3">
                <label class="form-label">Товар</label>
                <select name="productId" class="form-select" required>
                    <#list products as p>
                        <option value="${p.id}">${p.name}</option>
                    </#list>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Количество</label>
                <input type="number" name="amount" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Комментарий</label>
                <textarea name="comment" class="form-control" rows="2"></textarea>
            </div>
            <input type="hidden" name="type" value="OUTCOME">

            <button type="submit" class="btn btn-warning">Списать</button>
        </form>
    </div>

    <hr>

    <table class="table table-striped align-middle">
        <thead>
        <tr>
            <th>Название</th>
            <th>Кол-во</th>
            <th>Ед. изм.</th>
            <th>Цена</th>
            <th>Действия</th>
        </tr>
        </thead>
        <tbody>
        <#if products?size gt 0>
            <#list products as product>
                <tr <#if product.quantity < product.minQuantity>style="background-color: #fff3cd;"</#if>>
                    <td>${product.name}</td>
                    <td>${product.quantity}</td>
                    <td>${product.unit}</td>
                    <td>${product.price}</td>
                    <td>
                        <a href="/products/${product.id}" class="btn btn-sm btn-info">Открыть</a>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="5" class="text-center text-muted">Нет товаров</td>
            </tr>
        </#if>
        </tbody>
    </table>

    <@p.pagination currentPage=page.getNumber() totalPages=page.getTotalPages() baseUrl="/products" />
</div>

<script>
    const toggleSections = [
        {btn: "toggleCreateForm", form: "createForm"},
        {btn: "toggleIncomeForm", form: "incomeForm"},
        {btn: "toggleOutcomeForm", form: "outcomeForm"}
    ];

    toggleSections.forEach(section => {
        const btn = document.getElementById(section.btn);
        const form = document.getElementById(section.form);

        btn.addEventListener("click", function () {
            const isHidden = form.classList.contains("d-none");
            document.querySelectorAll("div[id$='Form']").forEach(f => f.classList.add("d-none"));
            if (isHidden) form.classList.remove("d-none");
        });
    });
</script>
</body>
</html>
