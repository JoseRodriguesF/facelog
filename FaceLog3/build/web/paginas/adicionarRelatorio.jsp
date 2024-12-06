<!DOCTYPE html>
<%@ page import="java.sql.*" %>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String titulo = request.getParameter("titulo");
        String descricaoErro = request.getParameter("descricao");
        String inicioIncidente = request.getParameter("inicio-incidente");
        String setor = request.getParameter("setor");
        String urgencia = request.getParameter("urgencia");

        String dbUrl = "jdbc:mysql://localhost:3306/facelog"; // Substitua pelo nome correto do banco
        String dbUser = "root";
        String dbPassword = "root";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet generatedKeys = null;

        try {
            // Conexão com o banco de dados
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Inserir dados e recuperar a chave gerada
            String sql = "INSERT INTO pendentes (titulo, decricao_erro, inicio_incidente, setor, urgencia) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, titulo);
            stmt.setString(2, descricaoErro);
            stmt.setString(3, inicioIncidente);
            stmt.setString(4, setor);
            stmt.setString(5, urgencia);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                // Recuperar o ID gerado
                generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1); // Obtenha o ID gerado
                    // Redirecionar para a página relatorioErro.jsp com o ID
                    response.sendRedirect("relatorioErro.jsp?id=" + id);
                } else {
                    out.println("<script>alert('Erro ao obter o ID do relatório.');</script>");
                }
            } else {
                out.println("<script>alert('Falha ao adicionar o relatório.');</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
        } finally {
            try {
                if (generatedKeys != null) generatedKeys.close();
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
                        <h3 class="codigo">Código de Identificação:<p id="codigo">Auto Increment</p></h3>
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
                </form>
            </div>
        </div>
    </main>
    <footer>

    </footer>
</body>
</html>