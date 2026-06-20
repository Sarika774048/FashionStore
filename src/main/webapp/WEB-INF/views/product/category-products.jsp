<%@ page import="java.util.List" %>
<%@ page import="com.fashion.store.model.Product" %>
<%@ page import="com.fashion.store.model.User" %>
<%
    // This page just forwards to products.jsp with the appropriate category context
    // The actual rendering is handled by products.jsp
    request.getRequestDispatcher("/WEB-INF/views/product/products.jsp").forward(request, response);
%>