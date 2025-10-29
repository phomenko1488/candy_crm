<#import "../layout/base.ftl" as base>

<@base.page title="Детали пользователя">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-person text-primary me-2"></i>Детали пользователя
                    </h1>
                    <p class="text-muted mb-0">Информация о пользователе системы</p>
                </div>
                <a href="/users" class="btn btn-secondary">
                    <i class="bi bi-arrow-left me-1"></i>Назад к списку
                </a>
            </div>
        </div>
    </div>

    <#if userM??>
        <!-- User Details -->
        <div class="row">
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
                                        <span class="badge bg-secondary ms-2">#${userM.id}</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-person-circle text-info me-2"></i>
                                    <div>
                                        <strong>Имя:</strong>
                                        <span class="fw-medium ms-2">${userM.username}</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-shield text-warning me-2"></i>
                                    <div>
                                        <strong>Роль:</strong>
                                        <span class="badge bg-info ms-2">${userM.role.name} (level ${userM.role.level})</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-toggle-on text-success me-2"></i>
                                    <div>
                                        <strong>Активен:</strong>
                                        <span class="badge bg-${(userM.active)?then('success', 'danger')} ms-2">
                                            <i class="bi bi-${(userM.active)?then('check-circle', 'x-circle')} me-1"></i>
                                            ${(userM.active)?then('Да', 'Нет')}
                                        </span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-calendar-plus text-success me-2"></i>
                                    <div>
                                        <strong>Дата создания:</strong>
                                        <span class="text-muted ms-2">${userM.createdAt}</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-3">
                                    <i class="bi bi-arrow-clockwise text-muted me-2"></i>
                                    <div>
                                        <strong>Дата обновления:</strong>
                                        <span class="text-muted ms-2">${userM.updatedAt}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    <#else>
        <!-- User Not Found -->
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-body text-center py-5">
                        <i class="bi bi-exclamation-triangle text-warning" style="font-size: 4rem;"></i>
                        <h4 class="mt-3 mb-3">Пользователь не найден или доступ запрещён</h4>
                        <p class="text-muted mb-4">Возможно, пользователь был удален или у вас нет прав для просмотра этой информации.</p>
                        <a href="/users" class="btn btn-primary">
                            <i class="bi bi-arrow-left me-1"></i>Вернуться к списку
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</@base.page>