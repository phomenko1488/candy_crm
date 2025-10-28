<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Просмотр товара</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Товар: ${product.name}</h1>
    <p>Остаток: <strong>${product.quantity} ${product.unit}</strong></p>
    <p>Мин. остаток: ${product.minQuantity}</p>
    <p>Цена: ${product.price}</p>
    <p>Описание: ${product.description}</p>
    <p>Цвет: ${product.color}</p>
    <p>Покрытие: ${product.cover}</p>

    <hr>
    <#--    <h3>Добавить операцию</h3>-->
    <#--    <form action="/warehouse/${product.id}/operation" method="post">-->
    <#--        <div class="mb-2">-->
    <#--            <label>Тип:</label>-->
    <#--            <select name="type" class="form-select">-->
    <#--                <option value="INCOME">Приход</option>-->
    <#--                <option value="OUTCOME">Расход</option>-->
    <#--            </select>-->
    <#--        </div>-->
    <#--        <div class="mb-2">-->
    <#--            <label>Количество:</label>-->
    <#--            <input type="number" name="amount" class="form-control" required>-->
    <#--        </div>-->
    <#--        <div class="mb-2">-->
    <#--            <label>Комментарий:</label>-->
    <#--            <input type="text" name="comment" class="form-control">-->
    <#--        </div>-->
    <#--        <button class="btn btn-primary">Добавить</button>-->
    <#--    </form>-->

    <hr>
    <h3>История операций</h3>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Тип</th>
            <th>Количество</th>
            <#--            <th>Комментарий</th>-->
            <th>Кто</th>
            <th>Дата</th>
        </tr>
        </thead>
        <tbody>
        <#if (operations.getTotalElements()>0)>
            <#list operations.content as op>
                <tr>
                    <td>${op.type.name()}</td>
                    <td>${op.amount}</td>
                    <#--                <td>${op.comment!""}</td>-->
                    <td>${op.createdBy.username}</td>
                    <td>${op.createdAt.toLocalDate().toString()}</td>
                </tr>
            </#list>
        </#if>
        </tbody>
    </table>

    <#-- Пагинация -->
    <#if (operations.getTotalElements()>0)>

        <nav aria-label="Page navigation">
            <ul class="pagination">
                <#if operations.hasPrevious()>
                    <li class="page-item">
                        <a class="page-link" href="?page=${operations.number-1}&size=${operations.size}">Предыдущая</a>
                    </li>
                </#if>
                <#list 0..operations.totalPages-1 as i>
                    <li class="page-item <#if operations.number==i>active</#if>">
                        <a class="page-link" href="?page=${i}&size=${operations.size}">${i+1}</a>
                    </li>
                </#list>
                <#if operations.hasNext()>
                    <li class="page-item">
                        <a class="page-link" href="?page=${operations.number+1}&size=${operations.size}">Следующая</a>
                    </li>
                </#if>
            </ul>
        </nav>
    </#if>

    <a href="/products" class="btn btn-secondary mt-3">Назад к списку</a>
</div>
</body>
</html>
