<#import "layout/base.ftl" as base>
<@base.page title="CRM System - Главная">
    <div class="row">
        <div class="col-12">
            <h1 class="display-4">Добро пожаловать в CRM систему</h1>
            <p class="lead">Управление складом, заказами, пользователями и финансами</p>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title">Склад товаров</h5>
                    <p class="card-text">Управление товарами и их остатками</p>
                    <a href="/products" class="btn btn-primary">Перейти</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title">Склад украшений</h5>
                    <p class="card-text">Управление украшениями и шаблонами</p>
                    <a href="/decorations" class="btn btn-primary">Перейти</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title">Заказы</h5>
                    <p class="card-text">Управление заказами клиентов</p>
                    <a href="/orders" class="btn btn-primary">Перейти</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title">Пользователи</h5>
                    <p class="card-text">Управление пользователями системы</p>
                    <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR") || user.hasRole("MANAGER"))>
                        <a href="/users" class="btn btn-primary">Перейти</a>
                    <#else>
                        <a href="/users" class="btn btn-secondary disabled">Нет доступа</a>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <#if user?? && (user.hasRole("ADMIN") || user.hasRole("DIRECTOR"))>
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title">Входящие</h5>
                    <p class="card-text">Просмотр доходов от выполненных заказов</p>
                    <a href="/finance/income" class="btn btn-success">Перейти</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card">
                <div class="card-body text-center">
                    <h5 class="card-title">Расходы</h5>
                    <p class="card-text">Управление расходами и зарплатами</p>
                    <a href="/finance/expense" class="btn btn-danger">Перейти</a>
                </div>
            </div>
        </div>
    </div>
    </#if>
</@base.page>