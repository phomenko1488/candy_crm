<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Back-office</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
<div class="d-flex flex-column min-vh-100 min-vw-100">
    <div class="d-flex flex-grow-1 justify-content-center align-items-center">
        <div class="p-5 border border-primary rounded">
            <h1>CRM | Вход</h1>
            <#if logoutMessage??>
                <div class="alert alert-success">${logoutMessage}</div>
            </#if>
            <#if errorMessage??>
                <div class="alert alert-danger">${errorMessage}</div>
            </#if>
            <form action="/login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input name="username" id="username" type="text" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input name="password" id="password" type="password" class="form-control" required>
                </div>
                <input type="submit" class="btn btn-primary w-100" value="Login"/>
            </form>
        </div>
    </div>
</div>
<script src="/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>