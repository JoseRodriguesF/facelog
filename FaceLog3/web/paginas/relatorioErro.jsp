<%@ page import="java.sql.*" %>
<%
    // Recuperar o ID do relatório do campo oculto no formulário
    String idParam = request.getParameter("id");
    int id = 0;

    // Verifica se o ID foi fornecido no parâmetro
    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            out.println("<script>alert('ID inválido: " + idParam + "');</script>");
        }
    } else {
        out.println("<script>alert('ID não fornecido na requisição.');</script>");
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

    // Verificar se o formulário foi enviado para excluir
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("excluir") != null) {
        try {
            // Conexão com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Comando SQL para excluir o relatório
            String deleteSql = "DELETE FROM pendentes WHERE id_relatorio = ?";
            stmt = conn.prepareStatement(deleteSql);
            stmt.setInt(1, id);
            int rowsDeleted = stmt.executeUpdate();

            if (rowsDeleted > 0) {
                out.println("<script>alert('Relatório excluído com sucesso!');</script>");
                response.sendRedirect(request.getContextPath() + "/index.jsp");  // Redirecionar para uma página de sucesso após exclusão
            } else {
                out.println("<script>alert('Erro ao excluir o relatório.');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Erro ao excluir o relatório: " + e.getMessage() + "');</script>");
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
        // Caso contrário, carregue os dados do relatório
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/relatorioErro/relatorioEroo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global/footer.css">
    <script>
        // Função para confirmar a exclusão e enviar o formulário
        function confirmarExclusao() {
            if (confirm("Tem certeza de que deseja excluir este relatório?")) {
                document.getElementById('formExclusao').submit();  // Submete o formulário após confirmação
            }
        }
    </script>
</head>
<body>
    <header>
        <div class="logo">
            <img src="${pageContext.request.contextPath}/icones/facebook.svg" alt="icone do facebook" id="logo-img">
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
                <label for="pendentes" class="menu-toggle" id="pendentes1">Pendentes
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
                <label for="resolvidos" class="menu-toggle">Resolvidos
                    <img src="${pageContext.request.contextPath}/icones/seta.svg" alt="seta">
                </label>
            </div>
            <div class="menu-relatorio">
                <h2 class="nome-menu">Relatório de erro<hr class="blue-line"></h2>
                <form id="formExclusao" method="POST" action="">
                    <div class="div-status">
                        <h3 class="titulo">Título:<br>
                            <p id="titulo">
                                <%= titulo != null && !titulo.trim().isEmpty() ? titulo : "Não encontrado" %>
                            </p>
                        </h3>
                        <h3 class="status">Status:<br><p>Pendentes</p></h3>
                    </div>
                    <h3 class="descricao">Descrição do Erro:<br><br>
                        <p id="descricao">
                            <%= descricaoErro != null && !descricaoErro.trim().isEmpty() ? descricaoErro : "Não encontrado" %>
                        </p>
                    </h3>
                    <div class="linha-1-relatorio">
                        <h3 class="codigo">Código de Identificação:<p id="codigo"><%= id %></p></h3>
                        <h3 class="inicio-incidente">Início do Incidente:<br>
                            <p type="date" id="inicio-incidente">
                                <%= inicioIncidente != null && !inicioIncidente.trim().isEmpty() ? inicioIncidente : "Não encontrado" %>
                            </p>
                        </h3>
                    </div>
                    <div class="linha-2-relatorio">
                        <h3 class="setor">Setor:<br>
                            <p><%= setor != null && !setor.trim().isEmpty() ? setor : "Não encontrado" %></p>
                        </h3>
                        <h3 class="urgencia">Urgência:<br>
                            <p><%= urgencia != null && !urgencia.trim().isEmpty() ? urgencia : "Não encontrado" %></p>
                        </h3>
                    </div>
                    <div class="botoes">
                        <button id="editar" type="button" onclick="window.location.href='editarRelatorioErro.jsp?id=<%= id %>';">Editar</button>
                        <button id="excluir" type="button" onclick="confirmarExclusao()">Excluir</button> <!-- Alterado -->
                        <button id="adicionar-conclusao" type="button" onclick="window.location.href='adicionarConclusao.jsp?id=<%= id %>';">Adicionar conclusão</button>
                        
                    </div>
                    <input type="hidden" name="id" value="<%= id %>">
                    <input type="hidden" name="excluir" value="true">
                </form>
            </div>
        </div>
    </main>
    <footer></footer>
</body>
</html>
