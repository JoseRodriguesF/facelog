<%@ page import="java.sql.*" %>
<%
    // Recuperar os dados enviados pelo formulário
    String titulo = request.getParameter("titulo");
    String descricaoErro = request.getParameter("descricaoErro");
    String inicioIncidente = request.getParameter("inicioIncidente");
    String fimIncidente = request.getParameter("fimIncidente");
    String setor = request.getParameter("setor");
    String urgencia = request.getParameter("urgencia");
    String descricaoResolucao = request.getParameter("descricaoResolucao");

    // Configurações do banco de dados
    String dbUrl = "jdbc:mysql://localhost:3306/facelog";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement insertStmt = null;
    PreparedStatement deleteStmt = null;
    PreparedStatement selectLastIdStmt = null;
    ResultSet rs = null;

    try {
        // Conectar ao banco de dados
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Buscar o último ID na tabela `concluidos`
        int nextId = 1; // Caso a tabela esteja vazia, o ID começa em 1
        String selectLastIdSql = "SELECT MAX(id_relatorio) AS lastId FROM concluidos";
        selectLastIdStmt = conn.prepareStatement(selectLastIdSql);
        rs = selectLastIdStmt.executeQuery();
        if (rs.next() && rs.getInt("lastId") > 0) {
            nextId = rs.getInt("lastId") + 1;
        }

        // Inserir os dados na tabela `concluidos`
        String insertSql = "INSERT INTO concluidos (id_relatorio, titulo, decricao_erro, decricao_resolucao, inicio_incidente, fim_incidente, setor, urgencia) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        insertStmt = conn.prepareStatement(insertSql);
        insertStmt.setInt(1, nextId);
        insertStmt.setString(2, titulo);
        insertStmt.setString(3, descricaoErro);
        insertStmt.setString(4, descricaoResolucao);
        insertStmt.setString(5, inicioIncidente);
        insertStmt.setString(6, fimIncidente);
        insertStmt.setString(7, setor);
        insertStmt.setString(8, urgencia);
        insertStmt.executeUpdate();

        // Remover o relatório da tabela `pendentes`
        String deleteSql = "DELETE FROM pendentes WHERE id_relatorio = ?";
        deleteStmt = conn.prepareStatement(deleteSql);
        deleteStmt.setInt(1, nextId);
        deleteStmt.executeUpdate();

        // Redirecionar para a página de conclusão
        response.sendRedirect("conclusao.jsp");
    } catch (Exception e) {
        out.println("<script>alert('Erro ao processar a conclusão: " + e.getMessage() + "');</script>");
    } finally {
        // Fechar os recursos
        try {
            if (rs != null) rs.close();
            if (selectLastIdStmt != null) selectLastIdStmt.close();
            if (insertStmt != null) insertStmt.close();
            if (deleteStmt != null) deleteStmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<script>alert('Erro ao fechar a conexão: " + e.getMessage() + "');</script>");
        }
    }
%>