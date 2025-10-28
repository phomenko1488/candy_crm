<#-- view.ftl (renamed from item.ftl) -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>Order #${(order.id)!}</h1>
        <a href="/orders" class="btn btn-secondary">Back to List</a>
    </div>

    <!-- Order Details -->
    <div class="card mb-4">
        <div class="card-header">
            <h5>Order Information</h5>
        </div>
        <div class="card-body">
            <p><strong>ID:</strong> ${(order.id)!}</p>
            <p><strong>Contact Info:</strong> ${(order.contactInfo)!}</p>
            <p><strong>Status:</strong> ${(order.orderStatus)!}</p>
            <p><strong>Date:</strong> ${(order.date)!}</p>
            <p><strong>Price:</strong> ${(order.price)}</p>
            <p><strong>Created By:</strong> ${((order.createdBy.username)!)!}</p>
            <p><strong>Edited By:</strong> ${((order.editedBy.username)!)!}</p>
            <p><strong>Created At:</strong> ${(order.createdAt)!}</p>
            <p><strong>Updated At:</strong> ${(order.updatedAt)!}</p>
        </div>
    </div>

    <!-- Order Items -->
    <div class="card mb-4">
        <div class="card-header">
            <h5>Order Items</h5>
        </div>
        <div class="card-body">
            <#if order.items?? && (order.items?size > 0)>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Product/Decoration</th>
                            <th>Quantity</th>
                        </tr>
                        </thead>
                        <tbody>
                        <#list order.items as item>
                            <tr>
                                <td>
                                    <#if item.product??>
                                        ${item.product.name} - ${item.product.price}
                                    <#elseif item.decoration??>
                                        ${item.decoration.name} - ${item.decoration.price}
                                    <#else>
                                        N/A
                                    </#if>
                                </td>
                                <td>${item.qty}</td>
                            </tr>
                        </#list>
                        </tbody>
                    </table>
                </div>
            <#else>
                <p>No items in this order.</p>
            </#if>
        </div>
    </div>
    <!-- Edit Status Form -->
    <#if (order.orderStatus!'') == 'CREATED'||(order.orderStatus!'') == 'PROGRESS'>
        <div class="card">
            <div class="card-header">
                <h5>Change Status</h5>
            </div>
            <form method="post" action="/orders/edit" class="card-body">
                <input type="hidden" name="orderId" value="${(order.id)!}">
                <div class="mb-3">
                    <label for="newStatus" class="form-label">New Status</label>
                    <select class="form-select" id="newStatus" name="newStatus" required>
                        <#-- Assuming OrderStatus enum values; adjust as needed -->
                        <option value="">Select Status</option>
                        <#--                    <option value="CREATED" <#if (order.orderStatus!'') == 'CREATED'>selected</#if>>CREATED</option>-->
                        <option value="PROGRESS" <#if (order.orderStatus!'') == 'PROGRESS'>selected</#if>>PROGRESS
                        </option>
                        <option value="CANCELED" <#if (order.orderStatus!'') == 'CANCELED'>selected</#if>>CANCELED
                        </option>
                        <option value="DONE" <#if (order.orderStatus!'') == 'DONE'>selected</#if>>DONE
                        </option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update Status</button>
            </form>
        </div>
    </#if>


    <!-- Flash Messages -->
    <#if successMessage??>
        <div class="alert alert-success mt-3">${successMessage}</div>
    </#if>
    <#if errorMessage??>
        <div class="alert alert-danger mt-3">${errorMessage}</div>
    </#if>
</div>
</body>
</html>