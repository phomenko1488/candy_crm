<#import "../layout/base.ftl" as base>

<@base.page title="Заказы">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                <div class="mb-3 mb-md-0">
                    <h1 class="mb-1">
                        <i class="bi bi-cart-check text-primary me-2"></i>Заказы
                    </h1>
                    <p class="text-muted mb-0">Управление заказами клиентов</p>
                </div>
                <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#createOrderModal">
                    <i class="bi bi-plus-circle me-1"></i><span class="d-none d-sm-inline">Создать заказ</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Orders Table -->
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
                                    <th><i class="bi bi-person me-1"></i>Контакт</th>
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
                                                    <span>${order.contactInfo!''}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-<#if order.orderStatus == 'PENDING'>warning<#elseif order.orderStatus == 'COMPLETED'>success<#elseif order.orderStatus == 'CANCELLED'>danger<#else>secondary</#if>">
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
                                            <td><span class="fw-medium">${(order.price)} ₽</span></td>
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

                    <!-- Mobile Cards -->
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
                                            <span class="badge bg-<#if order.orderStatus == 'PENDING'>warning<#elseif order.orderStatus == 'COMPLETED'>success<#elseif order.orderStatus == 'CANCELLED'>danger<#else>secondary</#if>">
                                                ${order.orderStatus}
                                            </span>
                                        </div>
                                        <div class="row g-2 mb-2">
                                            <div class="col-12">
                                                <small class="text-muted">Контакт:</small>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-telephone text-primary me-2"></i>
                                                    <span>${order.contactInfo!''}</span>
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
                                                <div class="fw-medium">${(order.price)} ₽</div>
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

    <!-- Pagination -->
    <#if orders.getNumber()?? && (orders.totalPages > 1)>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация заказов">
                    <ul class="pagination justify-content-center">
                        <#if orders.hasPrevious()>
                            <li class="page-item">
                                <a class="page-link" href="?page=${orders.number - 1}&size=${orders.size}">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
                            </li>
                        </#if>
                        <#list 0..orders.totalPages-1 as i>
                            <li class="page-item <#if i == orders.number>active</#if>">
                                <a class="page-link" href="?page=${i}&size=${orders.size}">${i + 1}</a>
                            </li>
                        </#list>
                        <#if orders.hasNext()>
                            <li class="page-item">
                                <a class="page-link" href="?page=${orders.number + 1}&size=${orders.size}">
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

<!-- Create Order Modal -->
<div class="modal fade" id="createOrderModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="createOrderModalLabel">
                    <i class="bi bi-plus-circle me-2"></i><span class="d-none d-sm-inline">Создать новый заказ</span><span class="d-sm-none">Новый заказ</span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="createOrderForm" method="post" action="/orders">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="contactInfo" class="form-label">
                            <i class="bi bi-telephone me-1"></i>Контактная информация
                        </label>
                        <input type="text" class="form-control" id="contactInfo" name="contactInfo" placeholder="Телефон, email или другие контакты" required>
                    </div>

                    <div id="itemsContainer">
                        <!-- Dynamic items will be added here by JS -->
                    </div>

                    <button type="button" id="addItemBtn" class="btn btn-outline-secondary mt-2 w-100 w-md-auto">
                        <i class="bi bi-plus-circle me-1"></i>Добавить товар
                    </button>
                </div>
                <div class="modal-footer d-flex flex-column flex-sm-row gap-2">
                    <button type="button" class="btn btn-secondary w-100 w-sm-auto" data-bs-dismiss="modal">
                        <i class="bi bi-x-circle me-1"></i>Отмена
                    </button>
                    <button type="submit" class="btn btn-primary w-100 w-sm-auto">
                        <i class="bi bi-check-circle me-1"></i>Создать заказ
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // JS arrays for products and decorations
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

    // Initialize first item
    document.addEventListener('DOMContentLoaded', function () {
        addItem();
    });

    let itemIndex = 0;

    function addItem() {
        const container = document.getElementById('itemsContainer');
        const itemDiv = document.createElement('div');
        itemDiv.className = 'item-row mb-3 p-3 border rounded bg-light';
        itemDiv.id = 'item-' + itemIndex;

        // Build HTML using concatenation
        let html = '<div class="row">';
        html += '<div class="col-md-7">';
        html += '<label class="form-label">Товар</label>';
        html += '<select class="form-select item-select" onchange="handleItemChange(this, ' + itemIndex + ')">';
        html += '<option value="">Выберите товар</option>';
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

        // Populate item select with products and decorations
        const itemSelect = itemDiv.querySelector('.item-select');
        products.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = 'Товар: ' + item.name + ' - ' + item.price + ' ₽';
            option.dataset.type = 'product';
            itemSelect.appendChild(option);
        });
        decorations.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = 'Украшение: ' + item.name + ' - ' + item.price + ' ₽';
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