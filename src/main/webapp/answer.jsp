<%@ page import="com.example.dao.BbsDao" %>
<%@ page import="com.example.dto.BbsDto" %>
<%@ page import="com.example.dto.MemberDto" %><%--
  Created by IntelliJ IDEA.
  User: chung
  Date: 2022/07/05
  Time: 10:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%
    int seq = Integer.parseInt(request.getParameter("seq"));

    BbsDto bbs = BbsDao.getInstance().getBbs(seq);

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>Title</title>
</head>
<body>

<h2>기본 (부모)글</h2>

<div align="center">
    <table border="1">
        <col width="200">
        <col width="500">
        <tr>

            <th>작성자</th>
            <td><%=bbs.getId()%>
            </td>

        </tr>
        <tr>
            <th>
                작성일
            </th>
            <td>
                <%=bbs.getWdate()%>
            </td>
        </tr>
        <tr>
            <th>조회수</th>
            <td><%=bbs.getReadcount()%>
            </td>
        </tr>
        <tr>
            <th>
                제목
            </th>
            <td>
                <%=bbs.getTitle()%>
            </td>
        </tr>
        <tr>
            <th>
                내용
            </th>
            <td>
                <%=bbs.getContent()%>
            </td>
        </tr>

    </table>


</div>
<%
    Object obj = session.getAttribute("login");
    MemberDto mem = null;
    if (obj == null) {
%>
<script>
    alert('로그인 해 주십시오');
    location.href = "login.jsp";
</script>
<%
    }
    mem = (MemberDto) obj;
%>
<h2>댓글</h2>
<div align="center">

    <form action="answerAf.jsp" method="post" id="frm">
        <input type="hidden" name="seq" value="<%=bbs.getSeq()%>">
        <table border="1">
            <col width="200"><col width="500">
            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" name="id" size="50px" value = "<%=mem.getId()%>" readonly="readonly">
                </td>

            </tr>
            <tr>
                <th>
                    제목
                </th>
                <td>
                    <input type="text" name = "title" size="50px">

                </td>

            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea rows="20" cols="50px" name="content"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="button" id="btn">댓글추가</button>
                </td>
            </tr>
        </table>
    </form>

</div>
<script type="text/javascript">
    $(document).ready(function(){
        $("#btn").click(function() {
            if($("#title").val() ===""){
                alert("제목을 입력해주세요.")
                $("#title").focus();
            }

            $("#frm").attr("action", "answerAf.jsp").submit();
        })
    })
</script>
</body>
</html>
