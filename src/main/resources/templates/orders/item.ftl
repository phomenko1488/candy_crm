<#import "../layout/base.ftl" as base>

<@base.page title="Заказ #${(order.id)!}">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-cart-check text-primary me-2"></i>Заказ #${(order.id)!}
                    </h1>
                    <p class="text-muted mb-0">Детальная информация о заказе</p>
                </div>
                <a href="/orders" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к списку
                </a>
            </div>
        </div>
    </div>

    <!-- Order Details -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-info-circle me-2"></i>Информация о заказе
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-hash text-primary me-2"></i>
                                <div>
                                    <strong>ID:</strong>
                                    <span class="badge bg-secondary ms-2">#${(order.id)!}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-person text-info me-2"></i>
                                <div>
                                    <strong>Клиент:</strong>
                                    <#if order.client?? && order.client.id??>
                                        <a href="/clients/${order.client.id}" class="text-decoration-none ms-2">
                                            ${order.client.name!''} (${order.client.phone!''})
                                        </a>
                                    <#else>
                                        <span class="text-muted ms-2">Без клиента</span>
                                    </#if>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-flag text-warning me-2"></i>
                                <div>
                                    <strong>Статус:</strong>
                                    <span class="badge bg-<#if (order.orderStatus!'') == 'PENDING'>warning<#elseif (order.orderStatus!'') == 'COMPLETED'>success<#elseif (order.orderStatus!'') == 'CANCELLED'>danger<#else>secondary</#if> ms-2">
                                        ${(order.orderStatus)!}
                                    </span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-calendar text-success me-2"></i>
                                <div>
                                    <strong>Дата:</strong>
                                    <span class="ms-2">${(order.date)!}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-currency-dollar text-success me-2"></i>
                                <div>
                                    <strong>Цена:</strong>
                                    <span class="fw-medium ms-2">${(order.price)} ₽</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-person-circle text-primary me-2"></i>
                                <div>
                                    <strong>Создал:</strong>
                                    <span class="ms-2">${((order.createdBy.username)!)!}</span>
                                </div>
                            </div>
                            <#if ((order.editedBy.username)!)??>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-pencil-square text-info me-2"></i>
                                    <div>
                                        <strong>Редактировал:</strong>
                                        <span class="ms-2">${((order.editedBy.username)!)!}</span>
                                    </div>
                                </div>
                            </#if>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-clock text-muted me-2"></i>
                                <div>
                                    <strong>Создан:</strong>
                                    <span class="text-muted ms-2">${(order.createdAt)!}</span>
                                </div>
                            </div>
                            <#if (order.updatedAt)??>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-arrow-clockwise text-muted me-2"></i>
                                    <div>
                                        <strong>Обновлен:</strong>
                                        <span class="text-muted ms-2">${(order.updatedAt)!}</span>
                                    </div>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Items -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Товары в заказе
                    </h5>
                </div>
                <div class="card-body p-0">
                    <#if order.items?? && (order.items?size > 0)>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                <tr>
                                    <th><i class="bi bi-box me-1"></i>Товар/Украшение</th>
                                    <th><i class="bi bi-hash me-1"></i>Количество</th>
                                </tr>
                                </thead>
                                <tbody>
                                <#list order.items as item>
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <#if item.product??>
                                                    <i class="bi bi-box text-primary me-2"></i>
                                                    <div>
                                                        <div class="fw-medium">${item.product.name}</div>
                                                        <small class="text-muted">${item.product.price} ₽</small>
                                                    </div>
                                                <#elseif item.decoration??>
                                                    <i class="bi bi-gem text-success me-2"></i>
                                                    <div>
                                                        <div class="fw-medium">${item.decoration.name}</div>
                                                        <small class="text-muted">${item.decoration.price} ₽</small>
                                                    </div>
                                                <#else>
                                                    <i class="bi bi-question-circle text-muted me-2"></i>
                                                    <span class="text-muted">N/A</span>
                                                </#if>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge bg-info">${item.qty}</span>
                                        </td>
                                    </tr>
                                </#list>
                                </tbody>
                            </table>
                        </div>
                    <#else>
                        <div class="text-center text-muted py-5">
                            <i class="bi bi-cart-x" style="font-size: 3rem;"></i>
                            <div class="mt-2">Нет товаров в заказе</div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Status Form -->
    <#if (order.orderStatus!'') == 'CREATED'||(order.orderStatus!'') == 'PROGRESS'>
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0">
                            <i class="bi bi-pencil-square me-2"></i>Изменить статус
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/orders/edit">
                            <input type="hidden" name="orderId" value="${(order.id)!}">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="newStatus" class="form-label">Новый статус</label>
                                    <select class="form-select" id="newStatus" name="newStatus" required>
                                        <option value="">Выберите статус</option>
                                        <option value="PROGRESS" <#if (order.orderStatus!'') == 'PROGRESS'>selected</#if>>PROGRESS</option>
                                        <option value="CANCELED" <#if (order.orderStatus!'') == 'CANCELED'>selected</#if>>CANCELED</option>
                                        <option value="DONE" <#if (order.orderStatus!'') == 'DONE'>selected</#if>>DONE</option>
                                    </select>
                                </div>
                                <div class="col-md-6 d-flex align-items-end">
                                    <button type="submit" class="btn btn-warning">
                                        <i class="bi bi-check-circle me-1"></i>Обновить статус
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</@base.page>