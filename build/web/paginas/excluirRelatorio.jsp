<%@ page import="java.sql.*" %>
<%
    String idParam = request.getParameter("id");
    int id = 0;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            id = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            out.println("<script>alert('ID inv�lido: " + idParam + "');</script>");
        }
    } else {
        out.println("<script>alert('ID n�o fornecido na requisi��o.');</script>");
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
            out.println("<script>alert('Relat�rio exclu�do com sucesso.'); window.location.href='" + request.getContextPath() + "/index.jsp';</script>");
        } else {
            out.println("<script>alert('Erro ao excluir relat�rio.');</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Erro ao excluir o relat�rio: " + e.getMessage() + "');</script>");
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            out.println("<script>alert('Erro ao fechar a conex�o: " + e.getMessage() + "');</script>");
        }
    }
%>