<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>${template.name}</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<div class="container mt-5">
    <h1>${template.name}</h1>
<#--    <h1>Для ${template.}</h1>-->
    <p><b>Описание:</b> ${template.description}</p>
    <hr>
    <#--    &lt;#&ndash;    OPERATOINS&ndash;&gt;-->
    <div class="mb-2">
        <h3>Состав</h3>
        <#if template.items??>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Продукт</th>
                    <th>Количество</th>
                </tr>
                </thead>
                <tbody>
                <#list template.items as item>
                    <tr>
                        <td><a href="/products/${item.id}">${item.product.name}</a></td>
                        <td>${item.qty}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>

    </div>
</div>
</body>
</html>