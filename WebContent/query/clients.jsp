<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String database = "hotel";
	String userid = "root";
	String password = "";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <link href="css/myStyle.css" rel="stylesheet" type="text/css" media="all">
    </head>
	<body>
	
		<h1>Available rooms</h1>
		<table>
			<tr>
			<td>name</td>
			<td>email</td>
			<td>phone</td>
			<td></td>
			</tr>
			<%
				try{
					connection = DriverManager.getConnection(connectionUrl+database, userid, password);
					statement=connection.createStatement();
					String sql ="select * from clients;";
					resultSet = statement.executeQuery(sql);
				while(resultSet.next()){
			%>
			<tr>
			<td><%=resultSet.getString("name") %></td>
			<td><%=resultSet.getString("email") %></td>
			<td><%=resultSet.getString("phone") %></td>
			<td>
				<form action="resClient.jsp" method="post" class="formno">
					<input type="hidden" id="email" name="email" value="<%=resultSet.getString("email").toString()%>">
					<input type="submit" value="Reservated">
				</form>
			</td>
			</tr>
			<%
				}
					connection.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</table>
		<a href="/webapp/admin.jsp">back</a>
	</body>
</html>