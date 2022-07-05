<%@page import="java.util.List" %>
<%@ page import="com.example.dto.MemberDto" %>
<%@ page import="com.example.dao.BbsDao" %>
<%@ page import="com.example.dto.BbsDto" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%!
	public String arrow(int depth){
        String rs = "<img src='./image/reply.png' width='20px' height='20px'/>";
        String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
        String ts = "";

        for(int i = 0; i < depth; i++){
            ts +=  nbsp;
        }

        return depth==0?"":ts +rs;
    }
%>

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

<%
    String choice = request.getParameter("choice");
    String search = request.getParameter("search");
    if (choice == null) {
        choice = "";
    }
    if (search == null) {
        search = "";
    }

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

    <script type="text/javascript">
        <%-- let search = "<%=search %>";
        if(search != ""){
            let obj = document.getElementById("choice");
            obj.value = "<%=choice %>";
            obj.setAttribute("selected", "selected");
        } --%>
    </script>

</head>
<body>

<%

    BbsDao dao = BbsDao.getInstance();

// 페이지 번호
    String sPageNumber = request.getParameter("pageNumber");
    int pageNumber = 0;
    if (sPageNumber != null && !sPageNumber.equals("")) {
        pageNumber = Integer.parseInt(sPageNumber);
    }


// List<BbsDto> list = dao.getBbslist();
// List<BbsDto> list = dao.getBbsSearchlist(choice, search);
    List<BbsDto> list = dao.getBbsPagelist(choice, search, pageNumber);

// 글의 총수
    int len = dao.getAllBbs(choice, search);

// 페이지의 수		10, 15, 20
    int bbsPage = len / 10;
    if ((len % 10) > 0) {
        bbsPage = bbsPage + 1;
    }

%>

<h2>게시판</h2>

<div align="center">

    <table border="1">
        <col width="70">
        <col width="600">
        <col width="100">
        <col width="150">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>조회수</th>
            <th>작성자</th>
        </tr>

        <%
            if (list == null || list.size() == 0) {
        %>
        <tr>
            <td colspan="4">작성된 글이 없습니다</td>
        </tr>
        <%
        } else {

            for (int i = 0; i < list.size(); i++) {
                BbsDto bbs = list.get(i);
        %>
        <tr>
            <th><%=i + 1 %>
            </th>
            <%
                if (bbs.getDel() == 0) {
            %>
            <td>
                <%= arrow(bbs.getDepth())%>
                <a href="bbsdetail.jsp?seq=<%=bbs.getSeq() %>">
                    <%=bbs.getTitle() %>
                </a>
            </td>
            <%
            } else {
            %>
            <td align="center">
                <font color="#ff0000">********* 이 글은 작성자에 의해서 삭제되었습니다 *********</font>
            </td>
            <%
                }
            %>

            <td><%=bbs.getReadcount() %>
            </td>
            <td><%=bbs.getId() %>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>

    <br>

    <%
        for (int i = 0; i < bbsPage; i++) {
            if (pageNumber == i) {    // 현재 페이지
    %>
    <span style="font-size: 15pt;color: #0000ff;font-weight: bold;">
			<%=i + 1 %>
		</span>
    <%
    } else {                    // 그외의 페이지		[1] 2 [3]
    %>
    <a href="#none" title="<%=i+1 %>페이지" onclick="goPage(<%=i %>)"
       style="font-size: 15pt; color: #000; font-weight: bold;text-decoration: none;">
        [<%=i + 1 %>]
    </a>
    <%
            }
        }
    %>


    <br><br>

    <select id="choice">
        <option>검색</option>
        <option value="title">제목</option>
        <option value="content">내용</option>
        <option value="writer">작성자</option>
    </select>

    <input type="text" id="search" value="<%=search %>">

    <button type="button" onclick="searchBtn()">검색</button>

</div>

<a href="bbswrite.jsp">글쓰기</a>

<script type="text/javascript">
    let search = "<%=search %>";
    if (search != "") {
        let obj = document.getElementById("choice");
        obj.value = "<%=choice %>";
        obj.setAttribute("selected", "selected");
    }

    function searchBtn() {
        let choice = document.getElementById('choice').value;
        let search = document.getElementById('search').value;
        /*
        if(search.trim() == ''){
            alert('검색어를 입력해 주십시오');
            return;
        }
        */
        location.href = "bbslist.jsp?choice=" + choice + "&search=" + search;
    }

    function goPage(pageNumber) {
        let choice = document.getElementById('choice').value;
        let search = document.getElementById('search').value;

        location.href = "bbslist.jsp?choice=" + choice + "&search=" + search + "&pageNumber=" + pageNumber;
    }

</script>


</body>
</html>






