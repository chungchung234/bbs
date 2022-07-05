<%@ page import="com.example.dao.BbsDao" %>
<%@ page import="com.example.dto.BbsDto" %><%--
  Created by IntelliJ IDEA.
  User: chung
  Date: 2022/07/05
  Time: 10:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<%
    BbsDao dao = BbsDao.getInstance();
    boolean isS = dao.answer(seq, new BbsDto(id, title, content));
    if (isS) {
%>
  <script type="text/javascript">
      alert('댓글입력 성공!');
      location.href = "bbslist.jsp";

  </script>

<%
} else {
%>
<script type="text/javascript">
    alert('댓글입력 실패');
    location.href = "answer.jsp?seq="+<%= seq %>;
</script>

<%
    }
%>

</body>
</html>
