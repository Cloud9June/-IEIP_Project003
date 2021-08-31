<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String sql = "update course_tbl_02 set sub_id=?, sub_name=?, credit=?,"
			+ "lec_id=?, week=?, start_hour=?, end_hour=? where sub_id=" + request.getParameter("sub_id");

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, request.getParameter("sub_id"));
	pstmt.setString(2, request.getParameter("sub_name"));
	pstmt.setInt(3, Integer.parseInt(request.getParameter("credit")));
	pstmt.setInt(4, Integer.parseInt(request.getParameter("lec_id")));
	pstmt.setInt(5, Integer.parseInt(request.getParameter("week")));
	pstmt.setInt(6, Integer.parseInt(request.getParameter("start_hour")));
	pstmt.setInt(7, Integer.parseInt(request.getParameter("end_hour")));

	pstmt.executeUpdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:forward page="subList.jsp"></jsp:forward>
</body>
</html>