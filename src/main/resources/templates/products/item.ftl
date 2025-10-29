<#import "../layout/base.ftl" as base>

<@base.page title="Товар: ${product.name}">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-box text-primary me-2"></i>Товар: ${product.name}
                    </h1>
                    <p class="text-muted mb-0">Детальная информация о товаре</p>
                </div>
                <a href="/products" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к списку
                </a>
            </div>
        </div>
    </div>

    <!-- Product Details -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-info-circle me-2"></i>Информация о товаре
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-hash text-primary me-2"></i>
                                <div>
                                    <strong>Остаток:</strong>
                                    <span class="badge bg-<#if product.quantity < product.minQuantity>danger<#else>success</#if> ms-2">
                                        ${product.quantity} ${product.unit}
                                    </span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-exclamation-triangle text-warning me-2"></i>
                                <div>
                                    <strong>Мин. остаток:</strong>
                                    <span class="ms-2">${product.minQuantity}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-currency-dollar text-success me-2"></i>
                                <div>
                                    <strong>Цена:</strong>
                                    <span class="fw-medium ms-2">${product.price} ₽</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-palette text-info me-2"></i>
                                <div>
                                    <strong>Цвет:</strong>
                                    <span class="ms-2">${product.color}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-layers text-secondary me-2"></i>
                                <div>
                                    <strong>Покрытие:</strong>
                                    <span class="ms-2">${product.cover}</span>
                                </div>
                            </div>
                            <#if product.description?has_content>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="bi bi-file-text text-muted me-2 mt-1"></i>
                                    <div>
                                        <strong>Описание:</strong>
                                        <p class="text-muted mb-0 ms-2">${product.description}</p>
                                    </div>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Operations History -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-clock-history me-2"></i>История операций
                    </h5>
                </div>
                <div class="card-body p-0">
                    <#if (operations.getTotalElements()>0)>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
        <thead>
        <tr>
                                        <th><i class="bi bi-tag me-1"></i>Тип</th>
                                        <th><i class="bi bi-hash me-1"></i>Количество</th>
                                        <th><i class="bi bi-person me-1"></i>Кто</th>
                                        <th><i class="bi bi-calendar me-1"></i>Дата</th>
        </tr>
        </thead>
        <tbody>
            <#list operations.content as op>
                <tr>
                                            <td>
                                                <span class="badge bg-<#if op.type.name() == 'INCOME'>success<#else>warning</#if>">
                                                    <i class="bi bi-<#if op.type.name() == 'INCOME'>arrow-down-circle<#else>arrow-up-circle</#if> me-1"></i>
                                                    ${op.type.name()}
                                                </span>
                                            </td>
                                            <td><span class="fw-medium">${op.amount}</span></td>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-person-circle text-primary me-2"></i>
                                                    <span>${op.createdBy.username}</span>
                                                </div>
                                            </td>
                                            <td><span class="text-muted">${op.createdAt.toLocalDate().toString()}</span></td>
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

    <!-- Pagination -->
    <#if (operations.getTotalElements()>0)>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация операций">
                    <ul class="pagination justify-content-center">
                <#if operations.hasPrevious()>
                    <li class="page-item">
                                <a class="page-link" href="?page=${operations.number-1}&size=${operations.size}">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
                    </li>
                </#if>
                <#list 0..operations.totalPages-1 as i>
                    <li class="page-item <#if operations.number==i>active</#if>">
                        <a class="page-link" href="?page=${i}&size=${operations.size}">${i+1}</a>
                    </li>
                </#list>
                <#if operations.hasNext()>
                    <li class="page-item">
                                <a class="page-link" href="?page=${operations.number+1}&size=${operations.size}">
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