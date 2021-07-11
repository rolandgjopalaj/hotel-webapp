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
	
		<h1>Room States</h1>
		<table>
			<tr>
			<td>codice</td>
			<td>State</td>
			</tr>
			<%
				try{
					connection = DriverManager.getConnection(connectionUrl+database, userid, password);
					statement=connection.createStatement();
					String sql ="select rooms.codice, rooms.rservated from rooms";
					resultSet = statement.executeQuery(sql);
				while(resultSet.next()){
			%>
			<tr>
			<td><%=resultSet.getString("codice") %></td>
			<td><%if(resultSet.getString("rservated").equals("0")){%>available<%}else{%>occupied<%} %></td>
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