<#import "../layout/base.ftl" as base>

<@base.page title="Украшения">
    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h1 class="mb-1">
                        <i class="bi bi-gem text-primary me-2"></i>Украшения
                    </h1>
                    <p class="text-muted mb-0">Управление украшениями и шаблонами</p>
                </div>
                <button id="toggleFormBtn" class="btn btn-primary" onclick="toggleForm()">
                    <i class="bi bi-plus-circle me-1"></i>Добавить украшение
                </button>
            </div>
        </div>
    </div>

    <!-- Create Decoration Form -->
    <div class="row mb-4">
        <div class="col-12">
            <div id="createDecorationForm" class="card border-0 shadow-sm d-none">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="bi bi-plus-circle me-2"></i>Создание нового украшения
                    </h5>
                </div>
                <div class="card-body">
                    <form method="post" action="/decorations">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Название</label>
                                <input type="text" name="name" class="form-control"
                                       placeholder="Введите название украшения" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Цвет</label>
                                <select name="color" id="color">
                                    <option value="Мат">Мат</option>
                                    <option value="Прозрачный">Прозрачный</option>
                                    <option value="Голографичный">Голографичный</option>
                                    <option value="Прозрачно-голографичный">Прозрачно-голографичный</option>
                                    <option value="Прозрачно-матовый">Прозрачно-матовый</option>
                                    <option value="Прозрачно-блестящий">Прозрачно-блестящий</option>
                                    <option value="Пастельный">Пастельный</option>
                                    <option value="Пастельный-глянцевый">Пастельный-глянцевый</option>
                                    <option value="Глянцевый">Глянцевый</option>
                                    <option value="Темный-матовый">Темный-матовый</option>
                                    <option value="Темный-голографичный">Темный-голографичный</option>
                                    <option value="Серебро">Серебро</option>
                                    <option value="Золото">Золото</option>
                                    <option value="Пудровый">Пудровый</option>
                                    <option value="-">-</option>
                                </select>
                                <#--                                <input type="text" name="color" class="form-control" placeholder="Введите цвет">-->
                            </div>
                            <div class="col-12">
                                <label class="form-label">Описание</label>
                                <textarea name="description" class="form-control" rows="3"
                                          placeholder="Описание украшения"></textarea>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Основа</label>
                                <select name="base" id="base">
                                    <option value="Жемчуг">Жемчуг</option>
                                    <option value="Камни">Камни</option>
                                    <option value="Бусы">Бусы</option>
                                    <option value="-">-</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Цена</label>
                                <input type="number" name="price" step="0.01" class="form-control" placeholder="0.00">
                            </div>
                            <div class="col-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-1"></i>Создать украшение
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Decorations Table -->
    <div class="row">
        <div class="col-12">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="mb-0">
                        <i class="bi bi-list-ul me-2"></i>Список украшений
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                            <tr>
                                <th><i class="bi bi-tag me-1"></i>Название</th>
                                <th><i class="bi bi-file-text me-1"></i>Описание</th>
                                <th><i class="bi bi-palette me-1"></i>Цвет</th>
                                <th><i class="bi bi-layers me-1"></i>База</th>
                                <th><i class="bi bi-currency-dollar me-1"></i>Цена</th>
                                <th><i class="bi bi-hash me-1"></i>Количество</th>
                                <th><i class="bi bi-gear me-1"></i>Действия</th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list decorations as decoration>
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="bi bi-gem text-success me-2"></i>
                                            <div>
                                                <div class="fw-medium">${decoration.name}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <#if decoration.description?has_content>
                                            <span class="text-muted">${decoration.description}</span>
                                        <#else>
                                            <span class="text-muted">—</span>
                                        </#if>
                                    </td>
                                    <td>
                                        <#if decoration.color?has_content>
                                            <span class="badge bg-light text-dark">${decoration.color}</span>
                                        <#else>
                                            <span class="text-muted">—</span>
                                        </#if>
                                    </td>
                                    <td>
                                        <#if decoration.base?has_content>
                                            <span class="text-muted">${decoration.base}</span>
                                        <#else>
                                            <span class="text-muted">—</span>
                                        </#if>
                                    </td>
                                    <td><span class="fw-medium">${decoration.price?string('0.00')} ₽</span></td>
                                    <td>
                                        <span class="badge bg-info">${decoration.quantity!0}</span>
                                    </td>
                                    <td>
                                        <a href="/decorations/${decoration.id}" class="btn btn-sm btn-outline-primary">
                                            <i class="bi bi-eye me-1"></i>Открыть
                                        </a>
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
    function toggleForm() {
        const form = document.getElementById('createDecorationForm');
        const btn = document.getElementById('toggleFormBtn');
        if (form.classList.contains('d-none')) {
            form.classList.remove('d-none');
            btn.innerHTML = '<i class="bi bi-eye-slash me-1"></i>Скрыть форму';
        } else {
            form.classList.add('d-none');
            btn.innerHTML = '<i class="bi bi-plus-circle me-1"></i>Добавить украшение';
        }
    }
</script>