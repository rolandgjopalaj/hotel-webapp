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
	
		<h1>Rooms reserved on <%=request.getParameter("date") %> </h1>
		<table >
			<tr>
			<td>codice</td>
			<td>date</td>
			<td>room</td>
			<td>client mail</td>
			<td>NR Days</td>
			<td>NR adults</td>
			</tr>
			<%
			String _date=request.getParameter("date");
				try{
					connection = DriverManager.getConnection(connectionUrl+database, userid, password);
					statement=connection.createStatement();
					String sql ="select * from reservations where date=\'"+_date+"\';";
					resultSet = statement.executeQuery(sql);
				while(resultSet.next()){
			%>
			<tr>
			<td><%=resultSet.getString("codice") %></td>
			<td><%=resultSet.getString("date") %></td>
			<td><%=resultSet.getString("room") %></td>
			<td><%=resultSet.getString("client") %></td>
			<td><%=resultSet.getString("nrdays") %></td>
			<td><%=resultSet.getString("nradult") %></td>
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