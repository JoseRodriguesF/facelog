<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.apache.org/taglibs/core" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Adicionar Relatório</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/container.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/menu.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adicionarRelatorio/adicionarRelatorio.css">
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
                <div class="menu-header">Relatórios</div>
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
                <label for="resolvidos" class="menu-toggle" id="resolvidos1">Resolvidos
                    <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
                </label>
            </div>
            <div class="menu-relatorio">
                <h2 class="nome-menu">Adicionar Relatório<hr class="blue-line"></h2>
                <form action="" method="post" class="celular">
                    <h3 class="titulo">Título:<br><br><input name="titulo" type="text" id="titulo"></h3>
                    <h3 class="descricao">Descrição do Erro:<br><br><textarea name="descricao" id="descricao"></textarea></h3>
                    <div class="linha-1-relatorio">
                        <h3 class="codigo">Código de Identificação:<p id="codigo">variavel</p><h3>
                        <h3 class="inicio-incidente">Início do Incidente:<br><input name="inicio-incidente" type="datetime-local" id="inicio-incidente"></h3>
                    </div>
                    <div class="linha-2-relatorio">
                        <h3 class="setor">Setor:<br>
                            <select name="setor" id="setor">
                                <option value="TI">TI</option>
                                <option value="Redes">Redes</option>
                                <option value="DevOps">DevOps</option>
                            </select>
                        </h3>
                        <h3 class="urgencia">Urgência:<br>
                            <select name="urgencia" id="urgencia">
                                <option value="baixa">Baixa</option>
                                <option value="media">Média</option>
                                <option value="alta">Alta</option>
                            </select>
                        </h3>
                    </div>
                    <div class="botoes">
                        <button id="adicionar" type="submit">Adicionar</button>
                    </div>
                    <% 
                    // Verificar se o formulário foi enviado via POST
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String titulo = request.getParameter("titulo");
                        String descricao = request.getParameter("descricao");
                        String inicioIncidente = request.getParameter("inicio-incidente");
                        String setor = request.getParameter("setor");
                        String urgencia = request.getParameter("urgencia");

                        // Parâmetros de conexão com o banco de dados
                        String url = "jdbc:mysql://localhost:3306/facelog";
                        String user = "root";
                        String password = "root";
                        String sql = "INSERT INTO pendentes (titulo, descricao_erro, inicio_incidente, setor, urgencia) VALUES (?, ?, ?, ?, ?)";

                        // Conectar ao banco de dados e inserir os dados
                        try (Connection conn = DriverManager.getConnection(url, user, password);
                             PreparedStatement stmt = conn.prepareStatement(sql)) {
                             
                            // Setar os parâmetros do SQL
                            stmt.setString(1, titulo);
                            stmt.setString(2, descricao);
                            stmt.setString(3, inicioIncidente);
                            stmt.setString(4, setor);
                            stmt.setString(5, urgencia);

                            // Executar a inserção
                            stmt.executeUpdate();

                            out.println("<p>Relatório adicionado com sucesso!</p>");
                        } catch (SQLException e) {
                            out.println("<p>Erro ao adicionar relatório: " + e.getMessage() + "</p>");
                        }
                    }
                    %>
                </form>
            </div>
        </div>
    </main>
    <footer>

    </footer>
</body>
</html>