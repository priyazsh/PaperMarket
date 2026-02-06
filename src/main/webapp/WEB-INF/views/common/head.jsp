<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    Header Component - Common head section for all pages
    Usage: <jsp:include page="/WEB-INF/views/common/head.jsp">
               <jsp:param name="title" value="Page Title"/>
               <jsp:param name="extraStyles" value="additional-styles"/>
           </jsp:include>
--%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<base href="<%= request.getContextPath() %>/">
<title>${param.title} - Paper Market</title>

<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- Favicon -->
<link rel="icon" type="image/svg+xml" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%2310b981'%3E%3Cpath d='M13 7h8m0 0v8m0-8l-8 8-4-4-6 6'/%3E%3C/svg%3E">

<!-- Base URL for JS -->
<script>
    const contextPath = '<%= request.getContextPath() %>';
</script>
