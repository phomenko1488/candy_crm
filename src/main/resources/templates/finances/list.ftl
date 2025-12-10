<#import "../layout/base.ftl" as base>

<@base.page title="Финансовые операции">
    <!-- Page Header (unchanged) -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                <div class="mb-3 mb-md-0">
                    <h1 class="mb-1">
                        <i class="bi bi-cash-stack text-primary me-2"></i>${pageTitle!"Финансовые операции"}
                    </h1>
                    <p class="text-muted mb-0">${operationType!"Управление доходами и расходами"}</p>
                </div>
                <div class="d-flex gap-2">
                    <a href="/finance/income" class="btn btn-success btn-sm">
                        <i class="bi bi-arrow-down-circle me-1"></i><span class="d-none d-sm-inline">Доходы</span>
                    </a>
                    <#if user?? && user.hasRole("ADMIN")>
                        <a href="/finance/expense" class="btn btn-danger btn-sm">
                            <i class="bi bi-arrow-up-circle me-1"></i><span class="d-none d-sm-inline">Расходы</span>
                        </a>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Sections (Divided: Date + Export, and Position separate) -->
    <div class="row mb-4">
        <div class="col-12 <#if pageTitle == "Расходы и зарплаты">col-md-6</#if>">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">
                        <i class="bi bi-calendar-range me-2"></i>Фильтр по дате
                    </h6>
                    <#if filterMode?? && filterMode == "date">
                        <span class="badge bg-info">Активно</span>
                    <#elseif filterMode??>
                        <a href="/finance/${(pageTitle == "Доходы")?then('income', 'expense')}"
                           class="btn btn-sm btn-outline-secondary">Очистить</a>
                    </#if>
                </div>
                <div class="card-body">
                    <#if pageTitle == "Доходы">
                    <form method="get" action="/finance/income" class="row g-3" id="dateFilterForm">
                        <#else>
                        <form method="get" action="/finance/expense" class="row g-3" id="dateFilterForm">
                            </#if>
                            <input type="hidden" name="page" value="0"/>
                            <input type="hidden" name="size" value="${operationsPage.size}"/>
                            <div class="col-md-5">
                                <label for="startDateFilter" class="form-label">Дата начала:</label>
                                <input type="date" name="startDate" id="startDateFilter" class="form-control"
                                       value="${startDateStr!''}"/>
                            </div>
                            <div class="col-md-5">
                                <label for="endDateFilter" class="form-label">Дата окончания:</label>
                                <input type="date" name="endDate" id="endDateFilter" class="form-control"
                                       value="${endDateStr!''}"/>
                            </div>
                            <div class="col-md-2 d-flex align-items-end flex-column gap-1">
                                <button type="submit" class="btn btn-primary btn-sm">
                                    <i class="bi bi-search me-1"></i>Фильтр
                                </button>
                                <a href="/finance/${(pageTitle == "Доходы")?then('income/export', 'expense/export')}?startDate=${startDateStr!}&endDate=${endDateStr!}"
                                   class="btn btn-success btn-sm" id="exportBtn">
                                    <i class="bi bi-download me-1"></i>Экспорт
                                </a>
                            </div>
                        </form>
                </div>
            </div>
        </div>

        <#if pageTitle == "Расходы и зарплаты">
            <div class="col-md-6">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-light d-flex justify-content-between align-items-center">
                        <h6 class="mb-0">
                            <i class="bi bi-person-badge me-2"></i>Фильтр по должности
                        </h6>
                        <#if filterMode?? && filterMode == "position">
                            <span class="badge bg-info">Активно</span>
                        <#else>
                            <a href="/finance/expense" class="btn btn-sm btn-outline-secondary">Очистить</a>
                        </#if>
                    </div>
                    <div class="card-body">
                        <form method="get" action="/finance/expense" class="row g-3" id="positionFilterForm">
                            <input type="hidden" name="page" value="0"/>
                            <input type="hidden" name="size" value="${operationsPage.size}"/>
                            <div class="col-md-10">
                                <label for="positionFilter" class="form-label">Должность:</label>
                                <select name="position" id="positionFilter" class="form-select">
                                    <option value="">Все</option>
                                    <#list positions as pos>
                                        <option value="${pos.name()}"
                                                <#if position?? && position.name() == pos.name()>selected</#if>>${pos.toOutput()}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-search me-1"></i>Фильтр
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </#if>
    </div>

    <!-- Add Salary Section (Updated: Position instead of comment) -->
    <#if showSalaryForm?? && showSalaryForm>
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="bi bi-wallet-fill me-2"></i>Добавить зарплату
                        </h5>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/finance/expense/salary" class="row g-3" id="salaryForm">
                            <div class="col-md-3">
                                <label for="startDate" class="form-label">
                                    <i class="bi bi-calendar-event me-1"></i>Дата начала:
                                </label>
                                <input type="date"
                                       name="startDate"
                                       id="startDate"
                                       class="form-control"
                                       required/>
                            </div>
                            <div class="col-md-3">
                                <label for="endDate" class="form-label">
                                    <i class="bi bi-calendar-check me-1"></i>Дата окончания:
                                </label>
                                <input type="date"
                                       name="endDate"
                                       id="endDate"
                                       class="form-control"
                                       required/>
                            </div>
                            <div class="col-md-3">
                                <label for="positionSalary" class="form-label">
                                    <i class="bi bi-person-badge me-1"></i>Должность:
                                </label>
                                <select name="position" id="positionSalary" class="form-select" required>
                                    <#list positions as pos>
                                        <option value="${pos.name()}">${pos.toOutput()}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label for="amount" class="form-label">
                                    <i class="bi bi-currency-dollar me-1"></i>Сумма:
                                </label>
                                <input type="number"
                                       name="amount"
                                       id="amount"
                                       class="form-control"
                                       step="0.01"
                                       placeholder="0.00"
                                       min="0"
                                       <#if salaryCreateRequest.amount??>value="${salaryCreateRequest.amount?string}"</#if>
                                       required/>
                            </div>
                            <div class="col-md-1 d-flex align-items-end">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-check-circle me-1"></i>Добавить
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </#if>

    <!-- Operations Table (unchanged) -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Операции
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                            <tr>
                                <th><i class="bi bi-hash me-1"></i>ID</th>
                                <th><i class="bi bi-tag me-1"></i>Тип</th>
                                <th><i class="bi bi-currency-dollar me-1"></i>Сумма</th>
                                <th><i class="bi bi-chat-text me-1"></i>Комментарий</th>
                                <th><i class="bi bi-calendar me-1"></i>Дата создания</th>
                                <th><i class="bi bi-gear me-1"></i>Действия</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list operationsPage.content as op>
                                <tr>
                                    <td><span class="badge bg-secondary">#${op.id}</span></td>
                                    <td>
                                            <span class="badge bg-${(op.type == 'INCOME')?then('success', 'danger')}">
                                                <i class="bi bi-${(op.type == 'INCOME')?then('arrow-down-circle', 'arrow-up-circle')} me-1"></i>
                                                <#if op.type == 'INCOME'>
                                                    Доход
                                                <#else >
                                                    <#if op.getSalary()??>
                                                        Зарплата
                                                    <#else >
                                                        Закупка
                                                    </#if>
                                                </#if>
                                            </span>
                                    </td>
                                    <td><span class="fw-medium">${op.amount} $</span></td>
                                    <td>
                                        <#if op.comment?has_content>
                                            <span class="text-muted">${op.comment}</span>
                                        <#else>
                                            <span class="text-muted">—</span>
                                        </#if>
                                    </td>
                                    <td><span class="text-muted">${op.createdAt}</span></td>
                                    <td>
                                        <#if op.type == 'INCOME'>
                                            <a href="/finance/income/${op.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye me-1"></i>Подробнее
                                            </a>
                                        <#else>
                                            <a href="/finance/expense/${op.id}" class="btn btn-sm btn-outline-primary">
                                                <i class="bi bi-eye me-1"></i>Подробнее
                                            </a>
                                        </#if>
                                    </td>
                                </tr>
                            </#list>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pagination (Preserves only active filter) -->
    <#if operationsPage.totalPages gt 1>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация операций">
                    <ul class="pagination justify-content-center">
                        <#list 0..(operationsPage.totalPages - 1) as i>
                            <li class="page-item <#if i == operationsPage.number>active</#if>">
                                <#assign baseUrl = (pageTitle == "Доходы")?string("/finance/income", "/finance/expense") />
                                <#assign params = "?page=${i}&size=${operationsPage.size}" />
                                <#if filterMode??>
                                    <#if filterMode == "position">
                                        <#assign params = params + "&position=${position.name()!''}" />
                                    <#elseif filterMode == "date">
                                        <#assign params = params + "&startDate=${startDateStr!''}&endDate=${endDateStr!''}" />
                                    </#if>
                                </#if>
                                <a class="page-link" href="${baseUrl}${params}">${i + 1}</a>
                            </li>
                        </#list>
                    </ul>
                </nav>
            </div>
        </div>
    </#if>
</@base.page>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Salary form date validation
        const startDateInput = document.getElementById('startDate');
        const endDateInput = document.getElementById('endDate');
        if (startDateInput && endDateInput) {
            startDateInput.addEventListener('change', function () {
                const startValue = this.value;
                if (startValue) {
                    endDateInput.min = startValue;
                }
            });
        }

        // Date filter form validation
        const startDateFilter = document.getElementById('startDateFilter');
        const endDateFilter = document.getElementById('endDateFilter');
        if (startDateFilter && endDateFilter) {
            startDateFilter.addEventListener('change', function () {
                const startValue = this.value;
                if (startValue) {
                    endDateFilter.min = startValue;
                }
            });
        }
    });
</script>