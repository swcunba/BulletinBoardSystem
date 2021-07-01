<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");	
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");//이전 페이지로.
			script.println("</script>");
		}
		//입력이 없는 경우에 대한 예외처리.
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 항목이 존재합니다.')");
			script.println("history.back()");//이전 페이지로.
			script.println("</script>");
		}
		//UserDAO 클래스에서 객체, 메소드 가져와서 작업 처리 과정 구현.
		else{
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				//db error. 기본키 제약조건 위배하는 경우밖에 없음.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 ID입니다.')");
				script.println("history.back()");//이전 페이지로.
				script.println("</script>");
			}
			else {
				//가입 성공시 main으로.
				session.setAttribute(user.getUserID(), user.getUserPassword());//세션(고유번호) 부여.
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>