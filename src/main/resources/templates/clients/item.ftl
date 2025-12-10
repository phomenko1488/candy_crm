<#import "../layout/base.ftl" as base>

<@base.page title="Клиент #${(client.id)!}">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-person text-primary me-2"></i>Клиент #${(client.id)!}
                    </h1>
                    <p class="text-muted mb-0">Детальная информация о клиенте</p>
                </div>
                <a href="/clients" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к списку
                </a>
            </div>
        </div>
    </div>

    <!-- Client Details -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-info-circle me-2"></i>Информация о клиенте
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-hash text-primary me-2"></i>
                                <div>
                                    <strong>ID:</strong>
                                    <span class="badge bg-secondary ms-2">#${(client.id)!}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-person text-info me-2"></i>
                                <div>
                                    <strong>Имя:</strong>
                                    <span class="ms-2">${(client.name)!}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-telephone text-success me-2"></i>
                                <div>
                                    <strong>Телефон:</strong>
                                    <span class="ms-2">${(client.phone)!}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-geo-alt text-warning me-2"></i>
                                <div>
                                    <strong>Адрес:</strong>
                                    <span class="ms-2">${(client.address)!}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-building text-primary me-2"></i>
                                <div>
                                    <strong>Организация:</strong>
                                    <span class="ms-2">${(client.inst)!}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <i class="bi bi-clock text-muted me-2"></i>
                                <div>
                                    <strong>Создан:</strong>
                                    <span class="text-muted ms-2">${(client.createdAt)!}</span>
                                </div>
                            </div>
                            <#if (client.updatedAt)??>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-arrow-clockwise text-muted me-2"></i>
                                    <div>
                                        <strong>Обновлен:</strong>
                                        <span class="text-muted ms-2">${(client.updatedAt)!}</span>
                                    </div>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</@base.page>