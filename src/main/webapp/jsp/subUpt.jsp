<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String sql = "select sub_id, sub_name, credit, lec_id, week,"
			+ "start_hour, end_hour from course_tbl_02 where sub_id=" + request.getParameter("sub_id");
	String sql2 = "select id, name from lecturer_tbl_02";

	Connection conn = DBConnect.getConnection();

	PreparedStatement pstmt = conn.prepareStatement(sql);
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	ResultSet rs = pstmt.executeQuery();
	ResultSet rs2 = pstmt2.executeQuery();

	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
<script type="text/javascript">
	function chkVal() {
		var test = document.subject;

		if (!test.sub_id.value) {
			alert("과목코드를 입력하세요.");
			test.sub_id.focus();
			return false;
		}
		if (!test.sub_name.value) {
			alert("과목명을 입력하세요.");
			test.sub_name.focus();
			return false;
		}
		if (test.lec_id.value == "none") {
			alert("강사를 선택하세요.");
			test.lec_id.focus();
			return false;
		}
		if (!test.credit.value) {
			alert("학점을 입력하세요.");
			test.credit.focus();
			return false;
		}

		var chk_radio = document.getElementsByName("week");
		var week_type = null;

		for (var i = 0; i < chk_radio.length; i++) {
			if (chk_radio[i].checked == true) {
				week_type = chk_radio[i].value;
			}
		}

		if (week_type == null) {
			alert("요일은 선택하세요.");
			return false;
		}

		if (!test.start_hour.value) {
			alert("시작시간을 입력하세요.");
			test.start_hour.focus();
			return false;
		}
		if (!test.end_hour.value) {
			alert("종료시간을 입력하세요.");
			test.end_hour.focus();
			return false;
		}

	}
</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	<section id="section">
		<h2>교과목 수정</h2>
		<form action="subModify.jsp" name="subject" method="post" onsubmit="return chkVal()">
			<table class="inTable">
				<tr>
					<th>교과목 코드</th>
					<td><input type="text" name="sub_id" size="50"
						value="<%=rs.getString("sub_id")%>"></td>
				</tr>
				<tr>
					<th>과목명</th>
					<td><input type="text" name="sub_name" size="50"
						value="<%=rs.getString("sub_name")%>"></td>
				</tr>
				<tr>
					<th>담당강사</th>
					<td><select name="lec_id">
							<option value="none">담당강사선택</option>
							<%
								int num = 1;
								while (rs2.next()) {
									if (rs.getInt("lec_id") == num) {
							%>
							<option value="<%=rs2.getString("id")%>" selected><%=rs2.getString("name")%></option>
							<%
								} else {
							%>
							<option value="<%=rs2.getString("id")%>"><%=rs2.getString("name")%></option>
							<%
								}
									num++;
								}
							%>
					</select></td>
				</tr>
				<tr>
					<th>학점</th>
					<td><input type="text" name="credit" size="50"
						value="<%=rs.getString("credit")%>"></td>
				</tr>
				<tr>
					<th>요일</th>
					<td>
						<%
							char[] day = { '월', '화', '수', '목', '금', '토' };
							for (int i = 1; i < 7; i++) {
								if (rs.getInt("week") == i) {
						%>
									<input type="radio" name="week" value="<%=i%>" checked><span><%=day[i - 1]%></span>
						<%
								} else {
						%>
									<input type="radio" name="week" value="<%=i%>"><span><%=day[i - 1]%></span>
						<%
								}
							}
						%>
					</td>
				</tr>
				<tr>
					<th>시작 시간</th>
					<td><input type="text" name="start_hour" size="50"
						value="<%=rs.getString("start_hour")%>"></td>
				</tr>
				<tr>
					<th>종료 시간</th>
					<td><input type="text" name="end_hour" size="50"
						value="<%=rs.getString("end_hour")%>"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" value="목록"
						onclick="location.href='subList.jsp'"> <input
						type="submit" value="수정"></td>
				</tr>
			</table>
		</form>
	</section>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>