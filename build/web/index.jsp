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

            <button class="menu-toggle" onclick="window.location.href='paginas/pendentes.jsp'">
                Pendentes
                <img src="icones/seta.svg" alt="seta">
            </button>

            <!-- Botão para listar relatórios resolvidos -->
            <button class="menu-toggle" onclick="window.location.href='paginas/resolvidos.jsp'">
                Resolvidos
                <img src="icones/seta.svg" alt="seta">
            </button>
        </div>
    </main>

    <footer>
        <!-- Pode colocar informações do rodapé aqui -->
    </footer>

</body>

</html>