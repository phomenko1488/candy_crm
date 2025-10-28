<#import "../blocks/pagination.ftl" as p>

<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Украшения</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <script>
        function toggleForm() {
            const form = document.getElementById('createDecorationForm');
            const btn = document.getElementById('toggleFormBtn');
            if (form.style.display === 'none') {
                form.style.display = 'block';
                btn.innerText = 'Скрыть форму';
            } else {
                form.style.display = 'none';
                btn.innerText = 'Добавить украшение';
            }
        }
    </script>
</head>
<body>
<div class="container mt-5">
    <h1>Украшения</h1>

    <button id="toggleFormBtn" class="btn btn-primary mb-3" onclick="toggleForm()">Добавить украшение</button>
    <div id="createDecorationForm" style="display: none;" class="card mt-4">
        <div class="card-body">
            <h4 class="card-title mb-3">Создание нового украшения</h4>
            <form method="post" action="/decorations">
                <div class="mb-3">
                    <label class="form-label">Название</label>
                    <input type="text" name="name" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Описание</label>
                    <textarea name="description" class="form-control"></textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">Цвет</label>
                    <input type="text" name="color" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">База</label>
                    <input type="text" name="base" class="form-control">
                </div>

                <div class="mb-3">
                    <label class="form-label">Цена</label>
                    <input type="number" name="price" step="0.01" class="form-control">
                </div>

                <button type="submit" class="btn btn-success">Создать</button>
            </form>
        </div>
    </div>

    <#-- Сообщения об успехе и ошибках -->
    <#if successMessage??>
        <div class="alert alert-success">${successMessage}</div>
    </#if>
    <#if errorMessage??>
        <div class="alert alert-danger">${errorMessage}</div>
    </#if>

    <#-- Таблица украшений -->
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Название</th>
            <th>Описание</th>
            <th>Цвет</th>
            <th>База</th>
            <th>Цена</th>
            <th>Количество</th>
            <th>Действия</th>
        </tr>
        </thead>
        <tbody>
        <#list decorations as decoration>
            <tr>
                <td>${decoration.name}</td>
                <td>${decoration.description!''}</td>
                <td>${decoration.color!''}</td>
                <td>${decoration.base!''}</td>
                <td>${decoration.price?string('0.00')}</td>
                <td>${decoration.quantity!0}</td>
                <td>
                    <a href="/decorations/${decoration.id}" class="btn btn-sm btn-info">Открыть</a>
                </td>
            </tr>
        </#list>
        </tbody>
    </table>

    <@p.pagination currentPage=page.getNumber() totalPages=page.getTotalPages() baseUrl="/decorations" />

</div>
</body>
</html>
