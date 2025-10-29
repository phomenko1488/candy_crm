<#--
    Универсальный блок пагинации для Bootstrap 5 с современным дизайном.
    Использование:
    <#import "../../blocks/pagination.ftl" as p>
    <@p.pagination currentPage=currentPage totalPages=totalPages baseUrl="/warehouse/products" />
-->

<#macro pagination currentPage totalPages baseUrl>
    <#if totalPages?? && totalPages gt 1>
        <nav aria-label="Пагинация">
            <ul class="pagination justify-content-center">
                <#-- Кнопка "Предыдущая" -->
                <li class="page-item <#if currentPage == 0>disabled</#if>">
                    <a class="page-link"
                       href="${baseUrl}?page=${currentPage - 1}&size=10"
                       aria-label="Предыдущая">
                        <i class="bi bi-chevron-left"></i>
                    </a>
                </li>

                <#-- Номера страниц -->
                <#list 0..(totalPages - 1) as i>
                    <#if i >= currentPage - 2 && i <= currentPage + 2>
                        <li class="page-item <#if i == currentPage>active</#if>">
                            <a class="page-link" href="${baseUrl}?page=${i}&size=10">${i + 1}</a>
                        </li>
                    </#if>
                </#list>

                <#-- Кнопка "Следующая" -->
                <li class="page-item <#if currentPage + 1 >= totalPages>disabled</#if>">
                    <a class="page-link"
                       href="${baseUrl}?page=${currentPage + 1}&size=10"
                       aria-label="Следующая">
                        <i class="bi bi-chevron-right"></i>
                    </a>
                </li>
            </ul>
        </nav>
    </#if>
</#macro>
