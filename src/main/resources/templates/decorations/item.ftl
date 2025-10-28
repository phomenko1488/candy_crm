<!doctype html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>${decoration.name}</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
</head>
<script>
    function toggleForm() {
        const form = document.getElementById('createDecorationTemplateForm');
        const btn = document.getElementById('toggleFormBtn');
        if (form.style.display === 'none') {
            form.style.display = 'block';
            btn.innerText = 'Скрыть форму';
        } else {
            form.style.display = 'none';
            btn.innerText = 'Добавить шаблон';
        }
    }
</script>
<body>
<div class="container mt-5">
    <h1>${decoration.name}</h1>
    <p><b>Описание:</b> ${decoration.description}</p>
    <p><b>Цвет:</b> ${decoration.color}</p>
    <p><b>База:</b> ${decoration.base}</p>
    <p><b>Цена:</b> ${decoration.price}</p>
    <p><b>Количество:</b> ${decoration.quantity}</p>


    <hr>
    <#--    CRAFT-->

    <h3>Крафт</h3>
    <form method="post" action="/decorations/${decoration.id}/craft">
        <input type="hidden" name="decorationId" value="${decoration.id}">
        <div class="mb-3">
            <label for="template">Шаблон</label>
            <select name="decorationTemplateId" id="template">
                <#list decoration.templates as template>
                    <option value="${template.id}">${template.name}</option>
                </#list>
            </select>
        </div>
        <input type="hidden" name="type" value="INCOME">
        <#--        <div class="mb-3">-->
        <#--            <label for="type">Тип операции</label>-->
        <#--            <select name="type" id="type" class="form-select">-->
        <#--                <option value="INCOME">Приход</option>-->
        <#--                <option value="OUTCOME">Расход</option>-->
        <#--            </select>-->
        <#--        </div>-->
        <#--        <div class="mb-3">-->
        <#--            <label for="amount">Количество</label>-->
        <#--            <input type="number" name="amount" class="form-control" required>-->
        <#--        </div>-->
        <#--        <div class="mb-3">-->
        <#--            <label for="price">Цена</label>-->
        <#--            <input type="number" name="price" step="0.01" class="form-control">-->
        <#--        </div>-->
        <#--        <div class="mb-3">-->
        <#--            <label for="comment">Комментарий</label>-->
        <#--            <textarea name="comment" class="form-control"></textarea>-->
        <#--        </div>-->
        <button type="submit" class="btn btn-primary">Craft</button>
    </form>

    <hr>
    <#--    &lt;#&ndash;    OPERATOINS&ndash;&gt;-->
    <div class="mb-2">
        <h3>История операций</h3>
        <#if operations??&&operations.content??>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Тип</th>
                    <th>Количество</th>
<#--                    <th>Цена</th>-->
                    <th>Комментарий</th>
                    <th>Дата</th>
                </tr>
                </thead>
                <tbody>
                <#list operations.content as op>
                    <tr>
                        <td>${op.type}</td>
                        <td>${op.amount}</td>
<#--                        <td>${op.price}</td>-->
                        <td>${op.comment}</td>
                        <td>${op.createdAt.toLocalDate().toString()}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>
        <#if (operations.getTotalElements()>0)>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <#if operations.hasPrevious()>
                        <li class="page-item">
                            <a class="page-link"
                               href="?opPage=${operations.number-1}&opSize=${operations.size}&teSize=${templates.size}&tePage=${templates.number}">Предыдущая</a>
                        </li>
                    </#if>
                    <#list 0..operations.totalPages-1 as i>
                        <li class="page-item <#if operations.number==i>active</#if>">
                            <a class="page-link"
                               href="?opPage=${i}&opSize=${operations.size}&teSize=${templates.size}&tePage=${templates.number}">${i+1}</a>
                        </li>
                    </#list>
                    <#if operations.hasNext()>
                        <li class="page-item">
                            <a class="page-link"
                               href="?opPage=${operations.number+1}&opSize=${operations.size}&teSize=${templates.size}&tePage=${templates.number}">Следующая</a>
                        </li>
                    </#if>
                </ul>
            </nav>
        </#if>
    </div>
    <#--    TEMPLATES-->
    <div>
        <h3>Шаблоны</h3>
        <#if templates??&&templates.content??>
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Название</th>
                    <th>Описание</th>
                </tr>
                </thead>
                <tbody>
                <#list templates.content as templage>
                    <tr>
                        <td><a href="/decorations-templates/${templage.id}">${templage.name}</a></td>
                        <td>${templage.description}</td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>
        <#if (templates.getTotalElements()>0)>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <#if templates.hasPrevious()>
                        <li class="page-item">
                            <a class="page-link"
                               href="?tePage=${templates.number-1}&teSize=${templates.size}&opSize=${operations.size}&opPage=${operations.number}">Предыдущая</a>
                        </li>
                    </#if>
                    <#list 0..templates.totalPages-1 as i>
                        <li class="page-item <#if templates.number==i>active</#if>">
                            <a class="page-link"
                               href="?tePage=${i}&teSize=${templates.size}&opSize=${operations.size}&opPage=${operations.number}">${i+1}</a>
                        </li>
                    </#list>
                    <#if templates.hasNext()>
                        <li class="page-item">
                            <a class="page-link"
                               href="?tePage=${templates.number+1}&teSize=${templates.size}&opSize=${operations.size}&opPage=${operations.number}">Следующая</a>
                        </li>
                    </#if>
                </ul>
            </nav>
        </#if>
        <button id="toggleFormBtn" class="btn btn-primary mb-3" onclick="toggleForm()">Добавить шаблон</button>
        <div id="createDecorationTemplateForm" style="display: none;" class="card mt-4">
            <div class="card-body">
                <h4 class="card-title mb-3">Создание нового шаблона</h4>
                <form method="post" action="/decorations-templates">
                    <input type="hidden" name="decorationId" value="${decoration.id}">

                    <div class="mb-3">
                        <label for="name">Название шаблона</label>
                        <input type="text" name="name" id="name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="description">Описание</label>
                        <textarea name="description" id="description" class="form-control"></textarea>
                    </div>

                    <div id="template-items">
                        <div class="template-item mb-2">
                            <select name="items[0].productId" class="form-select d-inline-block w-auto">
                                <#list products as product>
                                    <option value="${product.id}">${product.name}</option>
                                </#list>
                            </select>
                            <input type="number" name="items[0].qty" value="1" min="1"
                                   class="form-control d-inline-block w-auto">
                            <button type="button" class="btn btn-success add-item" style="margin-left: 5px;">+</button>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success">Создать</button>
                </form>
            </div>
        </div>
    </div>
    <script>
        console.log('Скрипт загружен!');

        // alert('Скрипт запускается!');  // Раскомментируй для теста

        function toggleForm() {  // Уже есть в head, но ок
            const form = document.getElementById('createDecorationTemplateForm');
            const btn = document.getElementById('toggleFormBtn');
            if (form.style.display === 'none') {
                form.style.display = 'block';
                btn.innerText = 'Скрыть форму';
            } else {
                form.style.display = 'none';
                btn.innerText = 'Добавить шаблон';
            }
        }

        let itemIndex = 1;

        function bindEvents() {
            console.log('Привязываю события.');
            // alert('События привязаны!');  // Тест

            document.addEventListener("click", function (e) {
                console.log('Клик:', e.target.tagName, e.target.className);

                if (e.target.classList.contains("add-item")) {
                    console.log('add-item сработал! Index:', itemIndex);

                    const container = document.getElementById("template-items");
                    if (!container) {
                        console.error('Container не найден!');
                        return;
                    }

                    const firstSelect = document.querySelector('select[name="items[0].productId"]');
                    if (!firstSelect) {
                        console.error('Первый select не найден!');
                        return;
                    }

                    // Удаляем + с текущего последнего элемента
                    const currentItems = container.querySelectorAll('.template-item');
                    if (currentItems.length > 0) {
                        const lastItem = currentItems[currentItems.length - 1];
                        const existingAddBtn = lastItem.querySelector('.add-item');
                        if (existingAddBtn) {
                            existingAddBtn.remove();
                        }
                    }

                    const newSelect = firstSelect.cloneNode(true);
                    newSelect.name = 'items[' + itemIndex + '].productId';
                    Array.from(newSelect.options).forEach(option => option.removeAttribute('selected'));
                    newSelect.classList.add('d-inline-block', 'w-auto');

                    const newInput = document.createElement('input');
                    newInput.type = 'number';
                    newInput.name = 'items[' + itemIndex + '].qty';
                    newInput.value = '1';
                    newInput.min = '1';
                    newInput.className = 'form-control d-inline-block w-auto';

                    const removeBtn = document.createElement('button');
                    removeBtn.type = 'button';
                    removeBtn.className = 'btn btn-danger remove-item';
                    removeBtn.innerText = '-';
                    removeBtn.style.marginLeft = '5px';

                    const addBtn = document.createElement('button');
                    addBtn.type = 'button';
                    addBtn.className = 'btn btn-success add-item';
                    addBtn.innerText = '+';
                    addBtn.style.marginLeft = '5px';

                    const newItem = document.createElement("div");
                    newItem.classList.add("template-item", "mb-2");
                    newItem.appendChild(newSelect);
                    newItem.appendChild(newInput);
                    newItem.appendChild(removeBtn);
                    newItem.appendChild(addBtn);

                    container.appendChild(newItem);
                    console.log('Элемент добавлен! Всего:', container.querySelectorAll('.template-item').length);
                    itemIndex++;
                }

                if (e.target.classList.contains("remove-item")) {
                    console.log('remove-item сработал!');
                    const itemToRemove = e.target.closest(".template-item");
                    const allItems = document.querySelectorAll('.template-item');
                    if (itemToRemove && allItems.length > 1) {
                        // Добавляем + обратно на новый последний элемент, если удаляем не последний
                        const isLast = itemToRemove === allItems[allItems.length - 1];
                        itemToRemove.remove();
                        console.log('Удалено. Осталось:', allItems.length - 1);

                        if (!isLast) {
                            // Если удалили не последний, добавляем + на новый последний
                            const newLast = container.querySelectorAll('.template-item')[allItems.length - 2]; // Новый последний
                            const addBtn = document.createElement('button');
                            addBtn.type = 'button';
                            addBtn.className = 'btn btn-success add-item';
                            addBtn.innerText = '+';
                            addBtn.style.marginLeft = '5px';
                            newLast.appendChild(addBtn);
                        }
                    } else {
                        console.warn('Нельзя удалить последний!');
                    }
                }
            });
        }

        // Защита: запускаем сразу или ждём
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', bindEvents);
        } else {
            bindEvents();
        }
    </script>
</div>
</body>
</html>