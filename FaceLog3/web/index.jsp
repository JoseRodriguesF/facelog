<!DOCTYPE html>

<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/global/header.css">
    <link rel="stylesheet" href="css/global/container.css">
    <link rel="stylesheet" href="css/global/menu.css">
</head>
<body>
    <header>
        <div class="logo">
            <img src="icones/facebook.svg" alt="icone do facebook" id="logo-img">
            <h1 id="logo-txt">acelog</h1>
        </div>
        <div class="adicionar_relatorio">
            <a href="paginas/adicionarRelatorio.jsp">
                <p>Adicionar relatório</p>
                <img src="icones/mais.svg" alt="icone mais" id="icone_mais">
            </a>
        </div>
    </header>
    <main>
        <div class="menu-container">
            <div class="menu-header">Relatórios</div>
            <input type="checkbox" id="pendentes">
            <label for="pendentes" class="menu-toggle" id="pendentes1">Pendentes
                <img src="icones/seta.svg" alt="seta">
            </label>
            <div class="menu-items">
                <c:forEach var="relatorio" items="${relatorios}">
                    <div class="menu-item">
                        <a href="#$relatorio.id">${relatorio.titulo}</a>
                    </div>
                </c:forEach>
            </div>
            <input type="checkbox" id="resolvidos">
            <label for="resolvidos" class="menu-toggle">Resolvidos
                <img src="icones/seta.svg" alt="seta">
            </label>
        </div>
    </main>
    <footer>

    </footer>
    
</body>
</html>
