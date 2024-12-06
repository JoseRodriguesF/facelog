<!DOCTYPE html>

<%@ page import="java.sql.*" %>

<%@ page import="java.sql.*" %>
<%
    // Recuperar o ID do relatório da URL
    String idParam = request.getParameter("id");
    int id = 0;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            out.println("<script>alert('ID inválido: " + idParam + "');</script>");
        }
    } else {
        out.println("<script>alert('ID não fornecido.');</script>");
    }

    // Variáveis para armazenar os dados do banco
    String titulo = "", descricaoErro = "", inicioIncidente = "", setor = "", urgencia = "";

    // Conexão com o banco de dados
    String dbUrl = "jdbc:mysql://localhost:3306/facelog";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // Verifica se o formulário foi enviado
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Recupera os dados do formulário
        titulo = request.getParameter("titulo");
        descricaoErro = request.getParameter("descricao");
        // Você pode capturar outros campos também, se necessário

        // Conexão com o banco de dados
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Atualizar os dados na tabela
            String updateSql = "UPDATE pendentes SET titulo = ?, decricao_erro = ? WHERE id_relatorio = ?";
            stmt = conn.prepareStatement(updateSql);
            stmt.setString(1, titulo);
            stmt.setString(2, descricaoErro);
            stmt.setInt(3, id);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("relatorioErro.jsp?id=" + id);
            } else {
                out.println("<script>alert('Erro ao atualizar o relatório.');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Erro ao atualizar o relatório: " + e.getMessage() + "');</script>");
        } finally {
            // Fechar os recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<script>alert('Erro ao fechar a conexão: " + e.getMessage() + "');</script>");
            }
        }
    } else {
        // Conexão com o banco de dados e recuperar os dados para o formulário
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            String sql = "SELECT * FROM pendentes WHERE id_relatorio = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                titulo = rs.getString("titulo");
                descricaoErro = rs.getString("decricao_erro");
                inicioIncidente = rs.getString("inicio_incidente");
                setor = rs.getString("setor");
                urgencia = rs.getString("urgencia");
            } else {
                out.println("<script>alert('Nenhum relatório encontrado para o ID: " + id + "');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Erro ao buscar o relatório: " + e.getMessage() + "');</script>");
        } finally {
            // Fechar os recursos
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<script>alert('Erro ao fechar a conexão: " + e.getMessage() + "');</script>");
            }
        }
    }
%>
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
            <a href="${pageContext.request.contextPath}/index.jsp">
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
                <label for="resolvidos" class="menu-toggle" id="pendentes1">Resolvidos
                    <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
                </label>
            </div>
            <div class="menu-relatorio">
                <h2 class="nome-menu">Relatório de erro<hr class="blue-line"></h2>
                <form method="post">
                    <div class="div-status">
                        <h3 class="titulo">Tí­tulo:<br><br><textarea name="titulo" id="titulo"><%= titulo %></textarea></h3>
                        <h3 class="status">Status:<br><p>Pendentes</p></h3>
                    </div>
                    <h3 class="descricao">Descrição do Erro:<br><br><textarea name="descricao" id="descricao"><%= descricaoErro %></textarea></h3>
                    <div class="linha-1-relatorio">
                        <h3 class="codigo">Código de Identificação:<p id="codigo"><%= id %></p><h3>
                        <h3 class="inicio-incidente">Iní­cio do Incidente:<br><p type="date" id="inicio-incidente"><%= inicioIncidente %></p></h3>
                    </div>
                    <div class="linha-2-relatorio">
                        <h3 class="setor">Setor:<br><p><%= setor %></p>
                        </h3>
                        <h3 class="urgencia">Urgência:<br><p><%= urgencia %></p>
                    </div>
                    <div class="botoes">
                        <button id="adicionar-conclusao" type="submit">Concluir</button>
                    </div>
                    <input type="hidden" name="id" value="<%= id %>">
                </form>
            </div>
        </div>
    </main>
    <footer>

    </footer>
</body>
</html>