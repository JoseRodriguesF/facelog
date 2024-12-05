<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/container.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/menu.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/editarRelatorioErro/editarRelatorioErro.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/footer.css">
</head>
<body>
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/icones/facebook.svg" alt="icone do facebook"id="logo-img">
            <h1 id="logo-txt">acelog</h1>
        </div>
        <div class="adicionar_relatorio">
            <a href="/index.html">
                <p>Fechar</p>
            </a>
        </div>
    </header>
    <main>
        <div class="main-container">
            <div class="menu-container">
                <div class="menu-header">Relat�rios</div>
                <input type="checkbox" id="pendentes">
                <label for="pendentes" class="menu-toggle">Pendentes
                    <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
                </label>
                <div class="menu-items">
                    <c:forEach var="relatorio" items="${relatorios}">
                        <div class="menu-item">
                            <a href="#${relatorio.id}">${relatorio.titulo}</a>
                        </div>
                    </c:forEach>
                </div>
                <input type="checkbox" id="resolvidos">
                <label for="resolvidos" class="menu-toggle" id="pendentes1">Resolvidos
                    <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
                </label>
            </div>
            <div class="menu-relatorio">
                <h2 class="nome-menu">Relat�rio de erro<hr class="blue-line"></h2>
                <form>
                    <div class="div-status">
                        <h3 class="titulo">T��tulo:<br><br><textarea name="titulo" id="titulo">variavel</textarea></h3>
                        <h3 class="status">Status:<br><p>Pendentes</p></h3>
                    </div>
                    <h3 class="descricao">Descri��o do Erro:<br><br><textarea name="" id="descricao">variavel</textarea></h3>
                    <div class="linha-1-relatorio">
                        <h3 class="codigo">C�digo de Identifica��o:<p id="codigo">variavel</p><h3>
                        <h3 class="inicio-incidente">In��cio do Incidente:<br><p type="date" id="inicio-incidente">data</p></h3>
                    </div>
                    <div class="linha-2-relatorio">
                        <h3 class="setor">Setor:<br><p>variavel</p>
                        </h3>
                        <h3 class="urgencia">Urg�ncia:<br><p>variavel</p>
                    </div>
                    <div class="botoes">
                        <button id="adicionar-conclusao" type="submit">Concluir</button>
                    </div>
                </form>
            </div>
        </div>
    </main>
    <footer>

    </footer>
</body>
</html>