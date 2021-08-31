<%@page import="com.sungil.database.DBConnect"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	StringBuffer sb = new StringBuffer();
	sb.append("select c.sub_id, c.sub_name, c.credit, l.name,case c.week when 1 then '월요일'");
	sb.append(" when 2 then '화요일' when 3 then '수요일' when 4 then '목요일' when 5 then '금요일'");
	sb.append(" when 6 then '토요일' end week,");
	sb.append(" substr(lpad(c.start_hour,4,'0'),1,2)||':'||substr(lpad(c.start_hour,4,'0'),3,2) start_hour,");
	sb.append(" substr(lpad(c.end_hour,4,'0'),1,2)||':'||substr(lpad(c.end_hour,4,'0'),3,2) end_hour");
	sb.append(" from course_tbl_02 c, lecturer_tbl_02 l");
	sb.append(" where c.lec_id = l.id");

	String sql = sb.toString();

	Connection conn = DBConnect.getConnection();
	PreparedStatement pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
	// ResultSet을 이동하기 위한 옵션
	//  - ResultSet.TYPE_FORWARD_ONLY : 위치 이동을 다음 레코드로만 이동
	//  - ResultSet.TYPE_SCROLL_INSENSITIVE : 위치 이동을 자유롭게 하고 업데이트 내용 미반영
	//  - ResultSet.TYPE_SCROLL_SENSITIVE : 위치 이동을 자유롭게 하고 업데이트 내용 반영
	//  - ResultSet.CONCUR_READ_ONLY : 데이터 변경이 불가능 하도록
	//  - ResultSet.CONCUR_UPDATABLE : 데이터 변경이 가능 하도록
	
	// 이동에 관련된 추가 메소드
	//  - rs.next() : 다음 위치로
	//  - rs.previous() : 이전 위치로
	//  - rs.beforeFirst() : 처음 위치로
	//  - rs.afterLast() : 마지막 위치로
	//  - rs.last() : 마지막 위치로
	
	// ResultSet에서 rs.next()를 사용하게 되면 다음 결과 row를 가져오고 이전값은 사용할 수 없음.
	// ResultSet.TYPE_SCROLL_INSENSITIVE 을 사용하면 한 번 커서가 지나간 다음에 다시 되돌릴 수 있음.

	ResultSet rs = pstmt.executeQuery();
	
	rs.last();
	int num = rs.getRow();
	rs.beforeFirst();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/style.css?ver=2">
<script type="text/javascript">

	function chkDel(sub_id) {
		msg = "정말 삭제하시겠습니까?";
		if(confirm(msg)!=0) {
			alert("삭제하였습니다.");
			location.href = "subDel.jsp?sub_id="+sub_id;
		} else {
			alert("취소하셨습니다.");
		}
	}

</script>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<jsp:include page="../include/nav.jsp"></jsp:include>

	<section id="section">
		<h2>교과목 현황</h2>
		<table class="cnt_table">
			<tr>
				<td>총 <%= num%>개의 교과목이 있습니다.</td>
			</tr>
		</table>
		<table>
			<thead>
				<tr>
					<th>과목코드</th>
					<th>과목명</th>
					<th>학점</th>
					<th>담당강사</th>
					<th>요일</th>
					<th>시작시간</th>
					<th>종료시간</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<%
					while(rs.next()) {
				%>
				<tr>
					<td><%=rs.getString("sub_id")%></td>
					<td><%=rs.getString("sub_name")%></td>
					<td><%=rs.getString("credit")%></td>
					<td><%=rs.getString("name")%></td>
					<td><%=rs.getString("week")%></td>
					<td><%=rs.getString("start_hour")%></td>
					<td><%=rs.getString("end_hour")%></td>
					<td>
						<input type="button" value="수정" onclick="location.href='subUpt.jsp?sub_id=<%= rs.getString("sub_id") %>'">
						/ <input type="button" value="삭제" onclick="chkDel(<%= rs.getString("sub_id")%>)">
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		
		<table class="cnt_table table_r">
			<tr>
				<td><input type="button" value="작성" onclick="location.href='subAdd.jsp'"></td>
			</tr>
		</table>
	</section>

	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>