<#import "../layout/base.ftl" as base>

<@base.page title="${template.name}">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-layout-text-window-reverse text-primary me-2"></i>${template.name}
                    </h1>
                    <p class="text-muted mb-0">Шаблон украшения</p>
                </div>
                <a href="/decorations" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к украшениям
                </a>
            </div>
        </div>
    </div>

    <!-- Template Details -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-info-circle me-2"></i>Информация о шаблоне
                    </h5>
                </div>
                <div class="card-body">
                    <#if template.description?has_content>
                        <div class="d-flex align-items-start mb-3">
                            <i class="bi bi-file-text text-muted me-2 mt-1"></i>
                            <div>
                                <strong>Описание:</strong>
                                <p class="text-muted mb-0 ms-2">${template.description}</p>
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Template Items -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Состав шаблона
                    </h5>
                </div>
                <div class="card-body p-0">
                    <#if template.items??>
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead>
                                    <tr>
                                        <th><i class="bi bi-box me-1"></i>Продукт</th>
                                        <th><i class="bi bi-hash me-1"></i>Количество</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <#list template.items as item>
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-box text-primary me-2"></i>
                                                    <div>
                                                        <a href="/products/${item.id}" class="text-decoration-none">
                                                            <span class="fw-medium">${item.product.name}</span>
                                                        </a>
                                                        <#if item.product.description?has_content>
                                                            <small class="text-muted d-block">${item.product.description}</small>
                                                        </#if>
                                                    </div>
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
                            <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                            <div class="mt-2">Нет товаров в шаблоне</div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</@base.page>