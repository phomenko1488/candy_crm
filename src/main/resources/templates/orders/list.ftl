<#import "../layout/base.ftl" as base>

<@base.page title="Заказы">
    <!-- Page Header с фильтром -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                <div class="mb-3 mb-md-0">
                    <h1 class="mb-1">
                        <i class="bi bi-cart-check text-primary me-2"></i>Заказы
                    </h1>
                    <p class="text-muted mb-0">Управление заказами клиентов</p>
                </div>
                <!-- Фильтр по статусу -->
                <form method="get" class="d-flex flex-column flex-sm-row gap-2 align-items-sm-center mb-2 mb-md-0">
                    <label for="statusFilter" class="visually-hidden">Фильтр по статусу</label>
                    <select id="statusFilter" name="status" class="form-select form-select-sm"
                            onchange="this.form.submit()">
                        <option value="ALL" <#if currentStatus == "ALL">selected</#if>>Все статусы</option>
                        <option value="PENDING" <#if currentStatus == "PENDING">selected</#if>>Ожидание</option>
                        <option value="COMPLETED" <#if currentStatus == "COMPLETED">selected</#if>>Завершён</option>
                        <option value="CANCELLED" <#if currentStatus == "CANCELLED">selected</#if>>Отменён</option>
                        <option value="CREATED" <#if currentStatus == "CREATED">selected</#if>>Создан</option>
                        <option value="DONE" <#if currentStatus == "DONE">selected</#if>>Выполнен</option>
                    </select>
                    <#if currentStatus != "ALL">
                        <a href="/orders?page=${orders.number}&size=${orders.size}"
                           class="btn btn-sm btn-outline-secondary">Очистить</a>
                    </#if>
                </form>
                <button type="button" class="btn btn-primary btn-sm" id="toggleCreateForm">
                    <i class="bi bi-plus-circle me-1"></i><span class="d-none d-sm-inline">Создать заказ</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Forms Section (без изменений) -->
    <div class="row mb-4">
        <div class="col-12">
            <!-- Форма создания нового заказа -->
            <div id="createOrderForm" class="card border-0 shadow-sm mb-4 d-none">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-plus-circle me-2"></i>Создание нового заказа
                    </h5>
                </div>
                <div class="card-body">
                    <form id="createOrderForm" method="post" action="/orders">
                        <div class="row g-3">
                            <!-- Client fields -->
                            <div class="col-md-6">
                                <label class="form-label">Instagram</label>
                                <input type="text" class="form-control" name="inst"
                                       placeholder="Введите название организации" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Имя контакта</label>
                                <input type="text" class="form-control" name="name" placeholder="Имя клиента" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Телефон</label>
                                <input type="tel" class="form-control" name="phone" placeholder="+7 (XXX) XXX-XX-XX"
                                       required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Адрес</label>
                                <input type="text" class="form-control" name="address" placeholder="Адрес доставки"
                                       required>
                            </div>

                            <!-- Items container -->
                            <div id="itemsContainer" class="col-12 mt-3">
                                <!-- Dynamic items added by JS -->
                            </div>

                            <div class="col-12">
                                <button type="button" id="addItemBtn" class="btn btn-outline-secondary w-100 w-md-auto">
                                    <i class="bi bi-plus-circle me-1"></i>Добавить товар/украшение
                                </button>
                            </div>

                            <div class="col-12 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-1"></i>Создать заказ
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Orders Table (с ссылками на client) -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Список заказов
                    </h5>
                </div>
                <div class="card-body p-0">
                    <!-- Desktop Table -->
                    <div class="table-responsive d-none d-lg-block">
                        <table class="table table-hover mb-0">
                            <thead>
                            <tr>
                                <th><i class="bi bi-hash me-1"></i>ID</th>
                                <th><i class="bi bi-person me-1"></i>Клиент</th>
                                <th><i class="bi bi-flag me-1"></i>Статус</th>
                                <th><i class="bi bi-calendar me-1"></i>Дата</th>
                                <th><i class="bi bi-person-badge me-1"></i>Создал</th>
                                <th><i class="bi bi-currency-dollar me-1"></i>Цена</th>
                                <th><i class="bi bi-gear me-1"></i>Действия</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#if orders??>
                                <#list orders.content as order>
                                    <tr>
                                        <td><span class="badge bg-secondary">#${order.id}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-telephone text-primary me-2"></i>
                                                <#if order.client?? && order.client.id??>
                                                    <a href="/clients/${order.client.id}" class="text-decoration-none">
                                                        ${order.client.name!''} (${order.client.phone!''})
                                                    </a>
                                                <#else>
                                                    <span class="text-muted">Без клиента</span>
                                                </#if>
                                            </div>
                                        </td>
                                        <td>
                                                <span class="badge bg-<#if order.orderStatus.name() == 'PENDING'>warning<#elseif order.orderStatus.name() == 'COMPLETED'>success<#elseif order.orderStatus.name() == 'CANCELLED'>danger<#else>secondary</#if>">
                                                    ${order.orderStatus}
                                                </span>
                                        </td>
                                        <td><span class="text-muted">${order.date}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-person-circle text-info me-2"></i>
                                                <span>${(order.createdBy.username)!''}</span>
                                            </div>
                                        </td>
                                        <td><span class="fw-medium">${(order.price)} $</span></td>
                                        <td>
                                            <a href="/orders/${order.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye me-1"></i>Просмотр
                                            </a>
                                        </td>
                                    </tr>
                                </#list>
                            <#else>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                                        <div class="mt-2">Нет заказов</div>
                                    </td>
                                </tr>
                            </#if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Mobile Cards (с ссылками) -->
                    <div class="d-lg-none p-3">
                        <#if orders??>
                            <#list orders.content as order>
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-cart-check text-primary me-2"></i>
                                                <div>
                                                    <h6 class="mb-0 fw-medium">Заказ #${order.id}</h6>
                                                    <small class="text-muted">${order.date}</small>
                                                </div>
                                            </div>
                                            <span class="badge bg-<#if order.orderStatus.name() == 'PENDING'>warning<#elseif order.orderStatus.name() == 'COMPLETED'>success<#elseif order.orderStatus.name() == 'CANCELLED'>danger<#else>secondary</#if>">
                                                ${order.orderStatus}
                                            </span>
                                        </div>
                                        <div class="row g-2 mb-2">
                                            <div class="col-12">
                                                <small class="text-muted">Клиент:</small>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-telephone text-primary me-2"></i>
                                                    <#if order.client?? && order.client.id??>
                                                        <a href="/clients/${order.client.id}"
                                                           class="text-decoration-none">
                                                            ${order.client.name!''} (${order.client.phone!''})
                                                        </a>
                                                    <#else>
                                                        <span class="text-muted">Без клиента</span>
                                                    </#if>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Создал:</small>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person-circle text-info me-1"></i>
                                                    <span>${(order.createdBy.username)!''}</span>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Цена:</small>
                                                <div class="fw-medium">${(order.price)} $</div>
                                            </div>
                                        </div>
                                        <a href="/orders/${order.id}" class="btn btn-sm btn-outline-primary w-100">
                                            <i class="bi bi-eye me-1"></i>Просмотр
                                        </a>
                                    </div>
                                </div>
                            </#list>
                        <#else>
                            <div class="text-center text-muted py-5">
                                <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                                <div class="mt-2">Нет заказов</div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pagination (с фильтром) -->
    <#if orders.getNumber()?? && (orders.totalPages > 1)>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация заказов">
                    <ul class="pagination justify-content-center">
                        <#if orders.hasPrevious()>
                            <li class="page-item">
                                <a class="page-link"
                                   href="?page=${orders.number - 1}&size=${orders.size}<#if currentStatus?? && currentStatus != 'ALL'>&status=${currentStatus}</#if>">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
                            </li>
                        </#if>
                        <#list 0..orders.totalPages-1 as i>
                            <li class="page-item <#if i == orders.number>active</#if>">
                                <a class="page-link"
                                   href="?page=${i}&size=${orders.size}<#if currentStatus?? && currentStatus != 'ALL'>&status=${currentStatus}</#if>">${i + 1}</a>
                            </li>
                        </#list>
                        <#if orders.hasNext()>
                            <li class="page-item">
                                <a class="page-link"
                                   href="?page=${orders.number + 1}&size=${orders.size}<#if currentStatus?? && currentStatus != 'ALL'>&status=${currentStatus}</#if>">
                                    Следующая <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </#if>
                    </ul>
                </nav>
            </div>
        </div>
    </#if>
</@base.page>

<!-- Остальной JS без изменений (toggle + dynamic items) -->
<script>
    // JS arrays for products and decorations (from model)
    const products = [
        <#if products??>
        <#list products as product>
        {id: ${product.id}, name: "${product.name?js_string}", price: ${product.price?c}},
        </#list>
        <#else>
        []
        </#if>
    ];

    const decorations = [
        <#if decorations??>
        <#list decorations as decoration>
        {id: ${decoration.id}, name: "${decoration.name?js_string}", price: ${decoration.price?c}},
        </#list>
        <#else>
        []
        </#if>
    ];

    // Toggle forms (like in products)
    const toggleSections = [
        {btn: "toggleCreateForm", form: "createOrderForm"}
    ];

    toggleSections.forEach(section => {
        const btn = document.getElementById(section.btn);
        const form = document.getElementById(section.form);

        if (btn && form) {
            btn.addEventListener("click", function () {
                const isHidden = form.classList.contains("d-none");
                document.querySelectorAll("div[id$='Form']").forEach(f => f.classList.add("d-none"));
                if (isHidden) form.classList.remove("d-none");
            });
        }
    });

    // Dynamic items (adapted from modal)
    let itemIndex = 0;

    document.addEventListener('DOMContentLoaded', function () {
        addItem();
    });

    function addItem() {
        const container = document.getElementById('itemsContainer');
        const itemDiv = document.createElement('div');
        itemDiv.className = 'item-row mb-3 p-3 border rounded bg-light';
        itemDiv.id = 'item-' + itemIndex;

        let html = '<div class="row">';
        html += '<div class="col-md-7">';
        html += '<label class="form-label">Товар/Украшение</label>';
        html += '<select class="form-select item-select" onchange="handleItemChange(this, ' + itemIndex + ')">';
        html += '<option value="">Выберите</option>';
        html += '</select>';
        html += '</div>';
        html += '<div class="col-md-3">';
        html += '<label class="form-label">Количество</label>';
        html += '<input type="number" class="form-control" name="items[' + itemIndex + '].quantity" min="1" required>';
        html += '</div>';
        html += '<div class="col-md-2 d-flex align-items-end">';
        if (itemIndex > 0) {
            html += '<button type="button" class="btn btn-danger remove-item-btn" onclick="removeItem(' + itemIndex + ')"><i class="bi bi-trash"></i></button>';
        }
        html += '</div>';
        html += '</div>';
        html += '<input type="hidden" class="product-hidden" name="items[' + itemIndex + '].productId" value="">';
        html += '<input type="hidden" class="decoration-hidden" name="items[' + itemIndex + '].decorationId" value="">';

        itemDiv.innerHTML = html;
        container.appendChild(itemDiv);

        // Populate select
        const itemSelect = itemDiv.querySelector('.item-select');
        products.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = 'Товар: ' + item.name + ' - ' + item.price + ' $';
            option.dataset.type = 'product';
            itemSelect.appendChild(option);
        });
        decorations.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = 'Украшение: ' + item.name + ' - ' + item.price + ' $';
            option.dataset.type = 'decoration';
            itemSelect.appendChild(option);
        });

        itemIndex++;
    }

    function handleItemChange(select, index) {
        const row = document.getElementById('item-' + index);
        const selectedOption = select.options[select.selectedIndex];
        const productHidden = row.querySelector('.product-hidden');
        const decorationHidden = row.querySelector('.decoration-hidden');

        if (!selectedOption.value) {
            productHidden.value = '';
            decorationHidden.value = '';
            return;
        }

        const type = selectedOption.dataset.type;
        const id = selectedOption.value;

        if (type === 'product') {
            productHidden.value = id;
            decorationHidden.value = '';
        } else if (type === 'decoration') {
            decorationHidden.value = id;
            productHidden.value = '';
        }
    }

    function removeItem(index) {
        const itemDiv = document.getElementById('item-' + index);
        if (itemDiv) {
            itemDiv.remove();
        }
    }

    document.getElementById('addItemBtn').addEventListener('click', addItem);
</script>