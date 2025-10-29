<#import "../layout/base.ftl" as base>

<@base.page title="${decoration.name}">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-gem text-primary me-2"></i>${decoration.name}
                    </h1>
                    <p class="text-muted mb-0">Детальная информация об украшении</p>
                </div>
                <a href="/decorations" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к списку
                </a>
            </div>
        </div>
    </div>

    <!-- Decoration Details -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-info-circle me-2"></i>Информация об украшении
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <#if decoration.description?has_content>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="bi bi-file-text text-muted me-2 mt-1"></i>
                                    <div>
                                        <strong>Описание:</strong>
                                        <p class="text-muted mb-0 ms-2">${decoration.description}</p>
                                    </div>
                                </div>
                            </#if>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-palette text-info me-2"></i>
                                <div>
                                    <strong>Цвет:</strong>
                                    <span class="ms-2">${decoration.color}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-layers text-secondary me-2"></i>
                                <div>
                                    <strong>База:</strong>
                                    <span class="ms-2">${decoration.base}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-currency-dollar text-success me-2"></i>
                                <div>
                                    <strong>Цена:</strong>
                                    <span class="fw-medium ms-2">${decoration.price} ₽</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-hash text-primary me-2"></i>
                                <div>
                                    <strong>Количество:</strong>
                                    <span class="badge bg-info ms-2">${decoration.quantity}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Craft Section -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-hammer me-2"></i>Крафт
                    </h5>
                </div>
                <div class="card-body">
                    <form method="post" action="/decorations/${decoration.id}/craft">
                        <input type="hidden" name="decorationId" value="${decoration.id}">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label for="template" class="form-label">Шаблон</label>
                                <select name="decorationTemplateId" id="template" class="form-select">
                                    <#list decoration.templates as template>
                                        <option value="${template.id}">${template.name}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="col-md-6 d-flex align-items-end">
                                <input type="hidden" name="type" value="INCOME">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-hammer me-1"></i>Craft
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Operations History -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-clock-history me-2"></i>История операций
                    </h5>
                </div>
                <div class="card-body p-0">
                    <#if operations??&&operations.content??>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-tag me-1"></i>Тип</th>
                                    <th><i class="bi bi-hash me-1"></i>Количество</th>
                                    <th><i class="bi bi-chat-text me-1"></i>Комментарий</th>
                                    <th><i class="bi bi-calendar me-1"></i>Дата</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list operations.content as op>
                                    <tr>
                                        <td>
                                                <span class="badge bg-<#if op.type == 'INCOME'>success<#else>warning</#if>">
                                                    <i class="bi bi-<#if op.type == 'INCOME'>arrow-down-circle<#else>arrow-up-circle</#if> me-1"></i>
                                                    ${op.type}
                                                </span>
                                        </td>
                                        <td><span class="fw-medium">${op.amount}</span></td>
                                        <td>
                                            <#if op.comment?has_content>
                                                <span class="text-muted">${op.comment}</span>
                                            <#else>
                                                <span class="text-muted">—</span>
                                            </#if>
                                        </td>
                                        <td><span class="text-muted">${op.createdAt.toLocalDate().toString()}</span>
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                    <#else>
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                            <div class="mt-2">Нет операций</div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Operations Pagination -->
    <#if (operations.getTotalElements()>0)>
        <div class="row mb-4">
            <div class="col-12">
                <nav aria-label="Пагинация операций">
                    <ul class="pagination justify-content-center">
                        <#if operations.hasPrevious()>
                            <li class="page-item">
                                <a class="page-link"
                                   href="?opPage=${operations.number-1}&opSize=${operations.size}&teSize=${templates.size}&tePage=${templates.number}">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
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
                                   href="?opPage=${operations.number+1}&opSize=${operations.size}&teSize=${templates.size}&tePage=${templates.number}">
                                    Следующая <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </#if>
                    </ul>
                </nav>
            </div>
        </div>
    </#if>

    <!-- Templates Section -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">
                            <i class="bi bi-layout-text-window-reverse me-2"></i>Шаблоны
                        </h5>
                        <button id="toggleFormBtn" class="btn btn-primary btn-sm" onclick="toggleForm()">
                            <i class="bi bi-plus-circle me-1"></i>Добавить шаблон
                        </button>
                    </div>
                </div>
                <div class="card-body p-0">
                    <#if templates??&&templates.content??>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-tag me-1"></i>Название</th>
                                    <th><i class="bi bi-file-text me-1"></i>Описание</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list templates.content as templage>
                                    <tr>
                                        <td>
                                            <a href="/decorations-templates/${templage.id}"
                                               class="text-decoration-none">
                                                <i class="bi bi-layout-text-window-reverse text-primary me-2"></i>
                                                ${templage.name}
                                            </a>
                                        </td>
                                        <td>
                                            <#if templage.description?has_content>
                                                <span class="text-muted">${templage.description}</span>
                                            <#else>
                                                <span class="text-muted">—</span>
                                            </#if>
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                    <#else>
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-layout-text-window-reverse" style="font-size: 3rem;"></i>
                            <div class="mt-2">Нет шаблонов</div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Templates Pagination -->
    <#if (templates.getTotalElements()>0)>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация шаблонов">
                    <ul class="pagination justify-content-center">
                        <#if templates.hasPrevious()>
                            <li class="page-item">
                                <a class="page-link"
                                   href="?tePage=${templates.number-1}&teSize=${templates.size}&opSize=${operations.size}&opPage=${operations.number}">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
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
                                   href="?tePage=${templates.number+1}&teSize=${templates.size}&opSize=${operations.size}&opPage=${operations.number}">
                                    Следующая <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </#if>
                    </ul>
                </nav>
            </div>
        </div>
    </#if>

    <!-- Add Template Form -->
    <div class="row mt-4">
        <div class="col-12">
            <div id="createDecorationTemplateForm" class="card border-0 shadow-sm d-none">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-plus-circle me-2"></i>Создание нового шаблона
                    </h5>
                </div>
                <div class="card-body">
                    <form method="post" action="/decorations-templates">
                        <input type="hidden" name="decorationId" value="${decoration.id}">
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="name" class="form-label">Название шаблона</label>
                                <input type="text" name="name" id="name" class="form-control"
                                       placeholder="Введите название шаблона" required>
                            </div>
                            <div class="col-md-6">
                                <label for="description" class="form-label">Описание</label>
                                <textarea name="description" id="description" class="form-control" rows="3"
                                          placeholder="Описание шаблона"></textarea>
                            </div>
                        </div>

                        <div id="template-items">
                            <h6 class="mb-3">
                                <i class="bi bi-list-ul me-2"></i>Товары в шаблоне
                            </h6>
                            <div class="template-item mb-2">
                                <div class="row g-2">
                                    <div class="col-md-6">
                                        <select name="items[0].productId" class="form-select">
                                            <#list products as product>
                                                <option value="${product.id}">${product.name}</option>
                                            </#list>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" name="items[0].qty" value="1" min="1" class="form-control"
                                               placeholder="Количество">
                                    </div>
                                    <div class="col-md-3">
                                        <button type="button" class="btn btn-success add-item w-100">
                                            <i class="bi bi-plus-circle me-1"></i>Добавить
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-1"></i>Создать шаблон
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</@base.page>

<script>
    function toggleForm() {
        const form = document.getElementById('createDecorationTemplateForm');
        const btn = document.getElementById('toggleFormBtn');
        if (form.classList.contains('d-none')) {
            form.classList.remove('d-none');
            btn.innerHTML = '<i class="bi bi-eye-slash me-1"></i>Скрыть форму';
        } else {
            form.classList.add('d-none');
            btn.innerHTML = '<i class="bi bi-plus-circle me-1"></i>Добавить шаблон';
        }
    }

    let itemIndex = 1;

    function createRemoveBtn() {
        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'btn btn-danger remove-item w-100 mb-1';
        removeBtn.innerHTML = '<i class="bi bi-trash me-1"></i>Удалить';
        removeBtn.setAttribute('aria-label', 'Удалить товар');
        return removeBtn;
    }

    function createAddBtn() {
        const addBtn = document.createElement('button');
        addBtn.type = 'button';
        addBtn.className = 'btn btn-success add-item w-100';
        addBtn.innerHTML = '<i class="bi bi-plus-circle me-1"></i>Добавить';
        addBtn.setAttribute('aria-label', 'Добавить следующий товар');
        return addBtn;
    }

    function updateButtons() {
        const container = document.getElementById("template-items");
        if (!container) return;
        const items = container.querySelectorAll('.template-item');
        items.forEach((item, index) => {
            const btnCol = item.querySelector('.btn-col');
            if (!btnCol) return;
            btnCol.innerHTML = '';  // Очищаем кнопки

            // Добавляем - для всех элементов кроме первого (index > 0)
            if (index > 0) {
                btnCol.appendChild(createRemoveBtn());
            }

            // Добавляем + только для последнего элемента
            if (index === items.length - 1) {
                btnCol.appendChild(createAddBtn());
            }
        });
    }

    function bindEvents() {
        document.addEventListener("click", function (e) {
            if (e.target.closest(".add-item")) {
                const container = document.getElementById("template-items");
                if (!container) return;

                // Клонируем первый select и сбрасываем selected
                const firstSelect = document.querySelector('select[name^="items[0].productId"]');
                if (!firstSelect) return;
                const newSelect = firstSelect.cloneNode(true);
                newSelect.name = 'items[' + itemIndex + '].productId';
                newSelect.value = '';  // Сброс значения

                const newInput = document.createElement('input');
                newInput.type = 'number';
                newInput.name = 'items[' + itemIndex + '].qty';
                newInput.value = '1';
                newInput.min = '1';
                newInput.className = 'form-control';
                newInput.placeholder = 'Количество';
                newInput.setAttribute('aria-label', 'Количество товара');

                // Создаём новую строку с пустым btn-col (кнопки добавим в updateButtons)
                const newItem = document.createElement("div");
                newItem.classList.add("template-item", "mb-2");
                newItem.innerHTML = `
                <div class="row g-2">
                    <div class="col-md-6">
                        <!-- select here -->
                    </div>
                    <div class="col-md-3 qty-col">
                        <!-- input here -->
                    </div>
                    <div class="col-md-3 btn-col">
                        <!-- buttons will be added by updateButtons -->
                    </div>
                </div>
            `;

                // Append элементы
                newItem.querySelector('.col-md-6').appendChild(newSelect);
                newItem.querySelector('.qty-col').appendChild(newInput);

                container.appendChild(newItem);
                itemIndex++;
                updateButtons();  // Обновляем кнопки после добавления
            }

            if (e.target.closest(".remove-item")) {
                const itemToRemove = e.target.closest(".template-item");
                const allItems = document.querySelectorAll('.template-item');
                if (itemToRemove && allItems.length > 1) {
                    // Проверяем, что это не первый элемент
                    if (Array.from(allItems).indexOf(itemToRemove) === 0) {
                        return;  // Нельзя удалить первый
                    }
                    itemToRemove.remove();
                    updateButtons();  // Обновляем кнопки после удаления
                }
            }
        });
    }

    // Инициализация: При загрузке обновляем кнопки (для первого элемента)
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            bindEvents();
            updateButtons();  // На случай, если HTML первого элемента имеет лишние кнопки
        });
    } else {
        bindEvents();
        updateButtons();
    }
</script>