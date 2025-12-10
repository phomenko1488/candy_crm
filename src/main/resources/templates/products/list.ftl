<#import "../layout/base.ftl" as base>
<#import "../blocks/pagination.ftl" as p>

<@base.page title="Склад товаров">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center">
                <div class="mb-3 mb-md-0">
                    <h1 class="mb-1">
                        <i class="bi bi-box text-primary me-2"></i>Склад товаров
                    </h1>
                    <p class="text-muted mb-0">Управление товарами и их остатками</p>
                </div>
                <div class="d-flex flex-column flex-sm-row gap-2 w-100 w-md-auto">
                    <button class="btn btn-success btn-sm" id="toggleCreateForm">
                        <i class="bi bi-plus-circle me-1"></i><span class="d-none d-sm-inline">Добавить товар</span>
                    </button>
                    <button class="btn btn-primary btn-sm" id="toggleIncomeForm">
                        <i class="bi bi-arrow-down-circle me-1"></i><span class="d-none d-sm-inline">Приход</span>
                    </button>
                    <button class="btn btn-warning btn-sm" id="toggleOutcomeForm">
                        <i class="bi bi-arrow-up-circle me-1"></i><span class="d-none d-sm-inline">Списание</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Forms Section -->
    <div class="row mb-4">
        <div class="col-12">
            <!-- Форма создания нового товара -->
            <div id="createForm" class="card border-0 shadow-sm mb-4 d-none">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-plus-circle me-2"></i>Создание нового товара
                    </h5>
                </div>
                <div class="card-body">
                    <form action="/products" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Название</label>
                                <input type="text" name="name" class="form-control" placeholder="Введите название товара" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Цвет</label>
                                <input type="text" name="color" class="form-control" placeholder="Введите цвет" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Описание</label>
                                <textarea name="description" class="form-control" rows="3" placeholder="Описание товара"></textarea>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Покрытие</label>
                                <select name="cover" class="form-select">
                                    <option value="Матовый">Матовое</option>
                                    <option value="Глянцевое">Глянцевое</option>
                                    <option value="Голографическое">Голографическое</option>
                                    <option value="Другое">Другое</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Цена</label>
                                <input type="number" name="price" class="form-control" step="0.01" placeholder="0.00" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Мин. остаток</label>
                                <input type="number" name="minQuantity" class="form-control" placeholder="0" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Единица измерения</label>
                                <select name="unit" class="form-select">
                                    <option value="шт.">шт.</option>
                                    <option value="кг.">кг.</option>
                                    <option value="г.">г.</option>
                                    <option value="пачки">пачки</option>
<#--                                    <option value="пачки">пачки</option>-->
                                </select>
                            </div>
                            <div class="col-md-6 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-1"></i>Создать товар
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Форма добавления ПРИВОЗА -->
            <div id="incomeForm" class="card border-0 shadow-sm mb-4 d-none">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-arrow-down-circle me-2"></i>Добавить приход
                    </h5>
                </div>
                <div class="card-body">
                    <form action="/products/operations" method="post">
                        <input type="hidden" name="type" value="INCOME">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Товар</label>
                                <select name="productId" class="form-select" required>
                                    <option value="">Выберите товар</option>
                                    <#list products as p>
                                        <option value="${p.id}">${p.name}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Количество</label>
                                <input type="number" name="amount" class="form-control" placeholder="0" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Цена (за все)</label>
                                <input type="number" step="0.01" name="price" class="form-control" placeholder="0.00" required>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-check-circle me-1"></i>Добавить приход
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Форма добавления СПИСАНИЯ -->
            <div id="outcomeForm" class="card border-0 shadow-sm mb-4 d-none">
                <div class="card-header bg-warning text-dark">
                    <h5 class="mb-0">
                        <i class="bi bi-arrow-up-circle me-2"></i>Списание товара
                    </h5>
                </div>
                <div class="card-body">
                    <form action="/products/operations" method="post">
                        <input type="hidden" name="type" value="OUTCOME">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Товар</label>
                                <select name="productId" class="form-select" required>
                                    <option value="">Выберите товар</option>
                                    <#list products as p>
                                        <option value="${p.id}">${p.name}</option>
                                    </#list>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Количество</label>
                                <input type="number" name="amount" class="form-control" placeholder="0" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Комментарий</label>
                                <textarea name="comment" class="form-control" rows="2" placeholder="Причина списания"></textarea>
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-warning">
                                    <i class="bi bi-check-circle me-1"></i>Списать товар
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Список товаров
                    </h5>
                </div>
                <div class="card-body p-0">
                    <!-- Desktop Table -->
                    <div class="table-responsive d-none d-lg-block">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th><i class="bi bi-tag me-1"></i>Название</th>
                                    <th><i class="bi bi-hash me-1"></i>Кол-во</th>
                                    <th><i class="bi bi-rulers me-1"></i>Ед. изм.</th>
                                    <th><i class="bi bi-currency-dollar me-1"></i>Цена</th>
                                    <th><i class="bi bi-gear me-1"></i>Действия</th>
                                </tr>
                            </thead>
                            <tbody>
                                <#if products?size gt 0>
                                    <#list products as product>
                                        <tr <#if product.quantity < product.minQuantity>class="table-warning"</#if>>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <i class="bi bi-box text-primary me-2"></i>
                                                    <div>
                                                        <div class="fw-medium">${product.name}</div>
                                                        <#if product.description?has_content>
                                                            <small class="text-muted">${product.description}</small>
                                                        </#if>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-<#if product.quantity < product.minQuantity>danger<#else>success</#if>">
                                                    ${product.quantity}
                                                </span>
                                                <#if product.quantity < product.minQuantity>
                                                    <small class="text-danger d-block">Мин: ${product.minQuantity}</small>
                                                </#if>
                                            </td>
                                            <td><span class="text-muted">${product.unit}</span></td>
                                            <td><span class="fw-medium">${product.price} ₽</span></td>
                                            <td>
                                                <a href="/products/${product.id}" class="btn btn-sm btn-outline-primary">
                                                    <i class="bi bi-eye me-1"></i>Открыть
                                                </a>
                                            </td>
                                        </tr>
                                    </#list>
                                <#else>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-5">
                                            <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                                            <div class="mt-2">Нет товаров</div>
                                        </td>
                                    </tr>
                                </#if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Mobile Cards -->
                    <div class="d-lg-none p-3">
                        <#if products?size gt 0>
                            <#list products as product>
                                <div class="card mb-3 <#if product.quantity < product.minQuantity>border-warning</#if>">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-start mb-2">
                                            <div class="d-flex align-items-center">
                                                <i class="bi bi-box text-primary me-2"></i>
                                                <div>
                                                    <h6 class="mb-0 fw-medium">${product.name}</h6>
                                                    <#if product.description?has_content>
                                                        <small class="text-muted">${product.description}</small>
                                                    </#if>
                                                </div>
                                            </div>
                                            <span class="badge bg-<#if product.quantity < product.minQuantity>danger<#else>success</#if>">
                                                ${product.quantity}
                                            </span>
                                        </div>
                                        <div class="row g-2 mb-2">
                                            <div class="col-6">
                                                <small class="text-muted">Ед. изм:</small>
                                                <div>${product.unit}</div>
                                            </div>
                                            <div class="col-6">
                                                <small class="text-muted">Цена:</small>
                                                <div class="fw-medium">${product.price} ₽</div>
                                            </div>
                                        </div>
                                        <#if product.quantity < product.minQuantity>
                                            <div class="alert alert-warning alert-sm py-2 mb-2">
                                                <small><i class="bi bi-exclamation-triangle me-1"></i>Мин. остаток: ${product.minQuantity}</small>
                                            </div>
                                        </#if>
                                        <a href="/products/${product.id}" class="btn btn-sm btn-outline-primary w-100">
                                            <i class="bi bi-eye me-1"></i>Открыть
                                        </a>
                                    </div>
                                </div>
                            </#list>
                        <#else>
                            <div class="text-center text-muted py-5">
                                <i class="bi bi-inbox" style="font-size: 3rem;"></i>
                                <div class="mt-2">Нет товаров</div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Pagination -->
    <#if page.totalPages gt 0>
        <div class="row mt-4">
            <div class="col-12">
                <nav aria-label="Пагинация">
                    <ul class="pagination justify-content-center">
                        <#if page.hasPrevious()>
                            <li class="page-item">
                                <a class="page-link" href="?page=${page.number - 1}&size=${page.size}">
                                    <i class="bi bi-chevron-left"></i> Предыдущая
                                </a>
                            </li>
                        </#if>
                        <#list 0..page.totalPages - 1 as i>
                            <li class="page-item <#if page.number == i>active</#if>">
                                <a class="page-link" href="?page=${i}&size=${page.size}">${i + 1}</a>
                            </li>
                        </#list>
                        <#if page.hasNext()>
                            <li class="page-item">
                                <a class="page-link" href="?page=${page.number + 1}&size=${page.size}">
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
    const toggleSections = [
        {btn: "toggleCreateForm", form: "createForm"},
        {btn: "toggleIncomeForm", form: "incomeForm"},
        {btn: "toggleOutcomeForm", form: "outcomeForm"}
    ];

    toggleSections.forEach(section => {
        const btn = document.getElementById(section.btn);
        const form = document.getElementById(section.form);

        btn.addEventListener("click", function () {
            const isHidden = form.classList.contains("d-none");
            document.querySelectorAll("div[id$='Form']").forEach(f => f.classList.add("d-none"));
            if (isHidden) form.classList.remove("d-none");
        });
    });
</script>
