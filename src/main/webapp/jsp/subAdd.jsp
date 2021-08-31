<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sql = "select id, name from lecturer_tbl_02";

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css?ver=1">
<script type="text/javascript">

	function chkVal() {
		var sub = document.subject;
		
		if(!sub.sub_id.value) {
			alert("과목코드를 입력하세요.");
			sub.sub_id.focus();
			return false;
		}
		if(!sub.sub_name.value) {
			alert("과목명을 입력하세요.");
			sub.sub_name.focus();
			return false;
		}
		if(sub.lec_id.value == "none") {
			alert("강사를 선택하세요.");
			sub.lec_id.focus();
			return false;
		}
		if(!sub.credit.value) {
			alert("학점을 입력하세요.");
			sub.credit.focus();
			return false;
		}
		
		var chk_radio = document.getElementsByName("week");
		var week_type = null;
		
		for(var i = 0; i<chk_radio.length; i++) {
			if (chk_radio[i].checked == true) {
				week_type = chk_radio[i].value;
			}
		}
		
		if(week_type == null) {
			alert("요일을 선택하세요.");
			return false;
		}
		
		if(!sub.start_hour.value) {
			alert("시작시간을 입력하세요.");
			sub.start_hour.focus();
			return false;
		}
		if(!sub.end_hour.value) {
			alert("종료시간을 입력하세요.");
			sub.end_hour.focus();
			return false;
		}
		
		alert("과목을 추가합니다.");
	}

</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>
	
	<section id="section">
		<h2>과목 추가</h2>
		<form action="subInsert.jsp" name="subject" method="post" onsubmit="return chkVal()">
			<table class="subTable">
				<tr>
					<th>교과목 코드</th>
					<td><input type="text" name="sub_id" size="50" ></td>
				</tr>
				<tr>
					<th>교과명</th>
					<td><input type="text" name="sub_name" size="50" ></td>
				</tr>
				<tr>
					<th>담당강사</th>
					<td>
						<select name="lec_id">
							<option value="none">담당강사선택</option>
							<%
								while(rs.next()) {
							%>	
								<option value="<%= rs.getString("id")%>"><%= rs.getString("name") %></option>				
							<%
								}
							%>
	<!-- 						<option value="1">김교수</option>					 -->
	<!-- 						<option value="2">이교수</option>					 -->
	<!-- 						<option value="3">박교수</option>					 -->
	<!-- 						<option value="4">우교수</option>					 -->
	<!-- 						<option value="5">최교수</option>					 -->
	<!-- 						<option value="6">강교수</option>					 -->
	<!-- 						<option value="7">황교수</option> -->
						</select>
					</td>
				</tr>
				<tr>
					<th>학점</th>
					<td><input type="text" name="credit" size="50"></td>
				</tr>
				<tr>
					<th>요일</th>
					<td>
						<input type="radio" name="week" value="1"><span> 월</span>
						<input type="radio" name="week" value="2"><span> 화</span>
						<input type="radio" name="week" value="3"><span> 수</span>
						<input type="radio" name="week" value="4"><span> 목</span>
						<input type="radio" name="week" value="5"><span> 금</span>
						<input type="radio" name="week" value="6"><span> 토</span>
					</td>
				</tr>
				<tr>
					<th>시작 시간</th>
					<td><input type="text" name="start_hour" size="50" ></td>
				</tr>
				<tr>
					<th>종료 시간</th>
					<td><input type="text" name="end_hour" size="50" ></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="목록" onclick="location.href='subList.jsp'">
						<input type="submit" value="등록">
					</td>
				</tr>
			</table>
		</form>
	</section>
	
	
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>