<%@ page import="java.sql.*" %>
<%
    String idParam = request.getParameter("id");
    int id = 0;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            out.println("<script>alert('ID inválido: " + idParam + "');</script>");
        }
    } else {
        out.println("<script>alert('ID não fornecido na requisição.');</script>");
    }

    String dbUrl = "jdbc:mysql://localhost:3306/facelog";
    String dbUser = "root";
    String dbPassword = "root";
    
    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        
        String sql = "DELETE FROM concluidos WHERE id_relatorio = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        
        int rowsAffected = stmt.executeUpdate();
        
        if (rowsAffected > 0) {
            out.println("<script>alert('Relatório excluído com sucesso.'); window.location.href='" + request.getContextPath() + "/index.jsp';</script>");
        } else {
            out.println("<script>alert('Erro ao excluir relatório.');</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Erro ao excluir o relatório: " + e.getMessage() + "');</script>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<script>alert('Erro ao fechar a conexão: " + e.getMessage() + "');</script>");
        }
    }
%>