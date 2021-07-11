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
    <link href="query/css/myStyle.css" rel="stylesheet" type="text/css" media="all">
    </head>
	<body>
	
		<h1>Admin session</h1>
		<form action="WebApp" method="post" >
			<input type="hidden" id="idH" name="idH" value="logout"/><br>		
			<input type="submit" class="btn" value="Log Out"/>
		</form>
		
		<br><br><br><br>
		
		<form action="query/availableRooms.jsp" method="post" >	
		Show all available rooms.<br>
			<input type="submit"  value="Available Room"/>
		</form><br>
		
		<form action="query/occupiedRooms.jsp" method="post" >
		Show all occupied rooms.<br>
			<input type="submit"  value="Occupied Room"/>
		</form><br>

		<form action="query/roomStates.jsp" method="post" >	
		Show room state.<br>
			<input type="submit"  value="Room states"/>
		</form><br>
		
		<form action="query/clients.jsp" method="post" >
		Show all clients.<br>
			<input type="submit"  value="Clients"/>
		</form><br>
		
		<form action="query/reservations.jsp" method="post" >
		Show all reservations.<br>
			<input type="submit" value="See Reservations"/>
		</form><br>
		
		<form action="query/resRoom.jsp" method="post">
		Show reservations of a room.<br>
		
			<input type="text" id="room" name="room" placeholder="enter room number" required><br>
			<input type="submit" value="Search"/>
		</form><br>
		
		<form action="query/resDate.jsp" method="post" >
		Show reservations on an exact date.<br>
		
			<input type="date" id="date" name="date" placeholder="enter the date" required><br>
			<input type="submit" value="Search"/>
		</form><br>
		
	</body>
</html>