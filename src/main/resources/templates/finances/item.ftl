<#import "../layout/base.ftl" as base>

<@base.page title="Детали операции">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-cash-stack text-primary me-2"></i>Детали финансовой операции
                    </h1>
                    <p class="text-muted mb-0">Подробная информация об операции</p>
                </div>
                <a href="/finance/<#if operation.type == 'INCOME'>income<#else>expense</#if>" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к списку
                </a>
        </div>
        </div>
    </div>

    <#if operation??>
        <!-- Operation Details -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-light">
                        <h5 class="mb-0">
                            <i class="bi bi-info-circle me-2"></i>Основная информация
                        </h5>
            </div>
            <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-hash text-primary me-2"></i>
                                    <div>
                                        <strong>ID:</strong>
                                        <span class="badge bg-secondary ms-2">#${operation.id}</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-tag text-warning me-2"></i>
                                    <div>
                                        <strong>Тип:</strong>
                                        <span class="badge bg-${(operation.type == 'INCOME')?then('success', 'danger')} ms-2">
                                            <i class="bi bi-${(operation.type == 'INCOME')?then('arrow-down-circle', 'arrow-up-circle')} me-1"></i>
                                            ${operation.type}
                                        </span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-currency-dollar text-success me-2"></i>
                                    <div>
                                        <strong>Сумма:</strong>
                                        <span class="fw-medium ms-2">${operation.amount} $</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <#if operation.comment?has_content>
                                    <div class="d-flex align-items-start mb-3">
                                        <i class="bi bi-chat-text text-muted me-2 mt-1"></i>
                                        <div>
                                            <strong>Комментарий:</strong>
                                            <p class="text-muted mb-0 ms-2">${operation.comment}</p>
                                        </div>
                                    </div>
                                </#if>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-calendar-plus text-success me-2"></i>
                                    <div>
                                        <strong>Дата создания:</strong>
                                        <span class="text-muted ms-2">${operation.createdAt}</span>
                                    </div>
                                </div>
                                <#if operation.updatedAt??>
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="bi bi-arrow-clockwise text-muted me-2"></i>
                                        <div>
                                            <strong>Дата обновления:</strong>
                                            <span class="text-muted ms-2">${operation.updatedAt}</span>
                                        </div>
                                    </div>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Related Order -->
        <#if operation.order??>
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">
                                <i class="bi bi-cart-check me-2"></i>Связанный заказ
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-hash text-primary me-2"></i>
                                <div>
                                    <strong>ID заказа:</strong>
                                    <a href="/orders/${operation.order.id}" class="btn btn-sm btn-outline-primary ms-2">
                                        <i class="bi bi-eye me-1"></i>#${operation.order.id}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </#if>

        <!-- Related Product -->
    <#if operation.product??>
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">
                                <i class="bi bi-box me-2"></i>Связанный продукт
                            </h5>
            </div>
            <div class="card-body">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-box text-primary me-2"></i>
                                <div>
                                    <strong>Продукт:</strong>
                                    <a href="/products/${operation.product.id}" class="btn btn-sm btn-outline-primary ms-2">
                                        <i class="bi bi-eye me-1"></i>${operation.product.name}
                                    </a>
                                    <span class="text-muted ms-2">(цена: ${operation.product.price} $)</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
    </#if>

        <!-- Salary Information -->
    <#if operation.salary??>
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-success text-white">
                            <h5 class="mb-0">
                                <i class="bi bi-person-workspace me-2"></i>Зарплата
                            </h5>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <#if operation.salary.description?has_content>
                                        <div class="d-flex align-items-start mb-3">
                                            <i class="bi bi-chat-text text-muted me-2 mt-1"></i>
                                            <div>
                                                <strong>Описание:</strong>
                                                <p class="text-muted mb-0 ms-2">${operation.salary.description}</p>
                                            </div>
                                        </div>
                                    </#if>
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="bi bi-calendar-range text-info me-2"></i>
                                        <div>
                                            <strong>Период:</strong>
                                            <span class="ms-2">${operation.salary.startDate} - ${operation.salary.endDate}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <i class="bi bi-currency-dollar text-success me-2"></i>
                                        <div>
                                            <strong>Сумма:</strong>
                                            <span class="fw-medium ms-2">${operation.salary.amount} $</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </#if>
    <#else>
        <!-- Operation Not Found -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body text-center py-5">
                        <i class="bi bi-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                        <h4 class="mt-3 mb-3">Операция не найдена</h4>
                        <p class="text-muted mb-4">Возможно, операция была удалена или у вас нет прав для просмотра этой информации.</p>
                        <a href="/finance/<#if operation.type == 'INCOME'>income<#else>expense</#if>" class="btn btn-primary">
                            <i class="bi bi-arrow-left me-1"></i>Вернуться к списку
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</@base.page>