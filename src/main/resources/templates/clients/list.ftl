<#import "../layout/base.ftl" as base>

<@base.page title="Клиенты">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                <div class="mb-3 mb-md-0">
                    <h1 class="mb-1">
                        <i class="bi bi-people text-primary me-2"></i>Клиенты
                    </h1>
                    <p class="text-muted mb-0">Управление клиентами и контактами</p>
                </div>
                <button type="button" class="btn btn-primary btn-sm" id="toggleCreateForm">
                    <i class="bi bi-plus-circle me-1"></i><span class="d-none d-sm-inline">Создать клиента</span>
                </button>
            </div>
        </div>
    </div>

    <!-- Forms Section -->
    <div class="row mb-4">
        <div class="col-12">
            <!-- Форма создания нового клиента -->
            <div id="createClientForm" class="card border-0 shadow-sm mb-4 d-none">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-plus-circle me-2"></i>Создание нового клиента
                    </h5>
                </div>
                <div class="card-body">
                    <form method="post" action="/clients">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Название организации (inst)</label>
                                <input type="text" class="form-control" name="inst" placeholder="Введите название организации">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Имя контакта</label>
                                <input type="text" class="form-control" name="name" placeholder="Имя клиента" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Телефон</label>
                                <input type="tel" class="form-control" name="phone" placeholder="+7 (XXX) XXX-XX-XX" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Адрес</label>
                                <input type="text" class="form-control" name="address" placeholder="Адрес доставки">
                            </div>
                            <div class="col-12 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-1"></i>Создать клиента
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Clients Table -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Список клиентов
                    </h5>
                </div>
                <div class="card-body p-0">
                    <!-- Desktop Table -->
                    <div class="table-responsive d-none d-lg-block">
                        <table class="table table-hover mb-0">
                            <thead>
                            <tr>
                                <th><i class="bi bi-hash me-1"></i>ID</th>
                                <th><i class="bi bi-person me-1"></i>Имя</th>
                                <th><i class="bi bi-telephone me-1"></i>Телефон</th>
                                <th><i class="bi bi-geo-alt me-1"></i>Адрес</th>
                                <th><i class="bi bi-building me-1"></i>Организация</th>
                                <th><i class="bi bi-gear me-1"></i>Действия</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#if clients??>
                                <#list clients.content as client>
                                    <tr>
                                        <td><span class="badge bg-secondary">#${client.id}</span></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-person text-primary me-2"></i>
                                                <span>${client.name!''}</span>
                                            </div>
                                        </td>
                                        <td><span class="text-muted">${client.phone!''}</span></td>
                                        <td><span class="text-muted">${client.address!''}</span></td>
                                        <td><span class="fw-medium">${client.inst!''}</span></td>
                                        <td>
                                            <a href="/clients/${client.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye me-1"></i>Просмотр
                                            </a>
                                        </td>
                                    </tr>
                                </#list>
                            <#else>
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-5">
                                        <i class="bi bi-people" style="font-size: 3rem;"></i>
                                        <div class="mt-2">Нет клиентов</div>
                                    </td>
                                </tr>
                            </#if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Mobile Cards -->
                    <div class="d-lg-none p-3">
                        <#if clients??>
                            <#list clients.content as client>
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-person text-primary me-2"></i>
                                                <div>
                                                    <h6 class="mb-0 fw-medium">${client.name!''}</h6>
                                                    <small class="text-muted">${client.phone!''}</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row g-2 mb-2">
                                            <div class="col-12">
                                                <small class="text-muted">Адрес:</small>
                                                <div>${client.address!''}</div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Организация:</small>
                                                <div>${client.inst!''}</div>
                                            </div>
                                        </div>
                                        <a href="/clients/${client.id}" class="btn btn-sm btn-outline-primary w-100">
                                            <i class="bi bi-eye me-1"></i>Просмотр
                                        </a>
                                    </div>
                                </div>
                            </#list>
                        <#else>
                            <div class="text-center text-muted py-5">
                                <i class="bi bi-people" style="font-size: 3rem;"></i>
                                <div class="mt-2">Нет клиентов</div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <#if clients.getNumber()?? && (clients.totalPages > 1)>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация клиентов">
                    <ul class="pagination justify-content-center">
                        <#if clients.hasPrevious()>
                            <li class="page-item">
                                <a class="page-link" href="?page=${clients.number - 1}&size=${clients.size}">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
                            </li>
                        </#if>
                        <#list 0..clients.totalPages-1 as i>
                            <li class="page-item <#if i == clients.number>active</#if>">
                                <a class="page-link" href="?page=${i}&size=${clients.size}">${i + 1}</a>
                            </li>
                        </#list>
                        <#if clients.hasNext()>
                            <li class="page-item">
                                <a class="page-link" href="?page=${clients.number + 1}&size=${clients.size}">
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

<script>
    // Toggle forms (adapted from products)
    const toggleSections = [
        {btn: "toggleCreateForm", form: "createClientForm"}
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
</script>