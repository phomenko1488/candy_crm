<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Orders</h1>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createOrderModal">
            Create New Order
        </button>
    </div>

    <!-- Orders Table -->
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Contact Info</th>
                <th>Status</th>
                <th>Date</th>
                <th>Created By</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <#if orders??>
                <#list orders.content as order>
                    <tr>
                        <td>${order.id}</td>
                        <td>${order.contactInfo!''}</td>
                        <td>${order.orderStatus}</td>
                        <td>${order.date}</td>
                        <td>${(order.createdBy.username)!''}</td>
                        <td>${(order.price)}</td>
                        <td>
                            <a href="/orders/${order.id}" class="btn btn-sm btn-outline-primary">View</a>
                        </td>
                    </tr>
                </#list>
            </#if>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
    <#if orders.getNumber()?? && (orders.totalPages > 1)>
        <nav aria-label="Orders pagination">
            <ul class="pagination justify-content-center">
                <#if orders.hasPrevious()>
                    <li class="page-item">
                        <a class="page-link" href="?page=${orders.number - 1}&size=${orders.size}">Previous</a>
                    </li>
                </#if>
                <#list 0..orders.totalPages-1 as i>
                    <li class="page-item <#if i == orders.number>active</#if>">
                        <a class="page-link" href="?page=${i}&size=${orders.size}">${i + 1}</a>
                    </li>
                </#list>
                <#if orders.hasNext()>
                    <li class="page-item">
                        <a class="page-link" href="?page=${orders.number + 1}&size=${orders.size}">Next</a>
                    </li>
                </#if>
            </ul>
        </nav>
    </#if>

    <!-- Flash Messages -->
    <#if successMessage??>
        <div class="alert alert-success mt-3">${successMessage}</div>
    </#if>
    <#if errorMessage??>
        <div class="alert alert-danger mt-3">${errorMessage}</div>
    </#if>
</div>

<!-- Create Order Modal -->
<div class="modal fade" id="createOrderModal" tabindex="-1" aria-labelledby="createOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createOrderModalLabel">Create New Order</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="createOrderForm" method="post" action="/orders">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="contactInfo" class="form-label">Contact Info</label>
                        <input type="text" class="form-control" id="contactInfo" name="contactInfo" required>
                    </div>

                    <div id="itemsContainer">
                        <!-- Dynamic items will be added here by JS -->
                    </div>

                    <button type="button" id="addItemBtn" class="btn btn-outline-secondary mt-2">+ Add Item</button>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Create Order</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    console.log(228)

    // JS arrays for products and decorations
    const products = [
        <#if products??>
        <#list products as product>
        {id: ${product.id}, name: "${product.name?js_string}", price: ${product.price?c}},
        </#list>
        <#else>
        []
        </#if>
    ];

    const decorations = [
        <#if decorations??>
        <#list decorations as decoration>
        {id: ${decoration.id}, name: "${decoration.name?js_string}", price: ${decoration.price?c}},
        </#list>
        <#else>
        []
        </#if>
    ];
    console.log(products)
    console.log(decorations)

    // Initialize first item
    document.addEventListener('DOMContentLoaded', function () {
        addItem();
    });

    let itemIndex = 0;

    function addItem() {
        const container = document.getElementById('itemsContainer');
        const itemDiv = document.createElement('div');
        itemDiv.className = 'item-row mb-3 p-3 border rounded';
        itemDiv.id = 'item-' + itemIndex;

        // Build HTML using concatenation
        let html = '<div class="row">';
        html += '<div class="col-md-7">';
        html += '<label class="form-label">Item</label>';
        html += '<select class="form-select item-select" onchange="handleItemChange(this, ' + itemIndex + ')">';
        html += '<option value="">Select Item</option>';
        html += '</select>';
        html += '</div>';
        html += '<div class="col-md-3">';
        html += '<label class="form-label">Quantity</label>';
        html += '<input type="number" class="form-control" name="items[' + itemIndex + '].quantity" min="1" required>';
        html += '</div>';
        html += '<div class="col-md-2 d-flex align-items-end">';
        if (itemIndex > 0) {
            html += '<button type="button" class="btn btn-danger remove-item-btn" onclick="removeItem(' + itemIndex + ')">-</button>';
        }
        html += '</div>';
        html += '</div>';
        html += '<input type="hidden" class="product-hidden" name="items[' + itemIndex + '].productId" value="">';
        html += '<input type="hidden" class="decoration-hidden" name="items[' + itemIndex + '].decorationId" value="">';

        itemDiv.innerHTML = html;
        container.appendChild(itemDiv);

        // Populate item select with products and decorations
        const itemSelect = itemDiv.querySelector('.item-select');
        products.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = 'Product: ' + item.name + ' - ' + item.price;
            option.dataset.type = 'product';
            itemSelect.appendChild(option);
        });
        decorations.forEach(item => {
            const option = document.createElement('option');
            option.value = item.id;
            option.textContent = 'Decoration: ' + item.name + ' - ' + item.price;
            option.dataset.type = 'decoration';
            itemSelect.appendChild(option);
        });

        itemIndex++;
    }

    function handleItemChange(select, index) {
        const row = document.getElementById('item-' + index);
        const selectedOption = select.options[select.selectedIndex];
        const productHidden = row.querySelector('.product-hidden');
        const decorationHidden = row.querySelector('.decoration-hidden');

        if (!selectedOption.value) {
            productHidden.value = '';
            decorationHidden.value = '';
            return;
        }

        const type = selectedOption.dataset.type;
        const id = selectedOption.value;

        if (type === 'product') {
            productHidden.value = id;
            decorationHidden.value = '';
        } else if (type === 'decoration') {
            decorationHidden.value = id;
            productHidden.value = '';
        }
    }

    function removeItem(index) {
        const itemDiv = document.getElementById('item-' + index);
        if (itemDiv) {
            itemDiv.remove();
        }
    }

    document.getElementById('addItemBtn').addEventListener('click', addItem);
</script>
</body>
</html>