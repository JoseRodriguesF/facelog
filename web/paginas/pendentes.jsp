<%@ page import="java.sql.*" %>

<%
    // Configurações do banco
    String url = "jdbc:mysql://localhost:3306/facelog";
    String user = "root";
    String password = "root";

    // Conexão ao banco
    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, user, password);

        // Query para buscar relatórios pendentes
        String query = "SELECT * FROM pendentes";
        stmt = connection.prepareStatement(query);
        rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Relatórios Pendentes</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/container.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/menu.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/adicionarRelatorio/adicionarRelatorio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/table/table.css">
</head>

<body>
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/icones/facebook.svg" alt="icone do facebook" id="logo-img">
            <h1 id="logo-txt">acelog</h1>
        </div>
        <div class="adicionar_relatorio">
            <a href="${pageContext.request.contextPath}/paginas/adicionarRelatorio.jsp">
                <p>Adicionar relatório</p>
                <img src="${pageContext.request.contextPath}/icones/mais.svg" alt="icone mais" id="icone_mais">
            </a>
        </div>
    </header>

    <main>
        <div class="main-container">
            <div class="menu-container">
                <div class="menu-header">Relatórios</div>

            <button class="menu-toggle" onclick="window.location.href='pendentes.jsp'">
                Pendentes
                <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
            </button>

            <!-- Botão para listar relatórios resolvidos -->
            <button class="menu-toggle" onclick="window.location.href='resolvidos.jsp'">
                Resolvidos
                <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
            </button>
        </div>
            <div class="menu-relatorio">
                <h2 class="nome-menu">Relatórios pendentes<hr class="blue-line"></h2>
        
        <table border="1">
            <thead>
                <tr>
                    <th>Título</th>
                    <th>Início do incidente</th>
                    <th>Setor afetado</th>
                    <th>Urgência</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getString("titulo") %></td>
                    <td><%= rs.getTimestamp("inicio_incidente") %></td>
                    <td><%= rs.getString("setor") %></td>
                    <td><%= rs.getString("urgencia") %></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/paginas/relatorioErro.jsp?id=<%= rs.getInt("id_relatorio") %>" class="btn-acessar">
                            Acessar
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        </div>
        </div>
    </main>

    <footer>
        <!-- Informações do rodapé -->
    </footer>
</body>

</html>
<%
    } catch (Exception e) {
        out.println("<p>Erro ao buscar relatórios: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            out.println("<p>Erro ao fechar recursos: " + e.getMessage() + "</p>");
        }
    }
%>