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
	<body>
			<%
				try{
					connection = DriverManager.getConnection(connectionUrl+database, userid, password);
					statement=connection.createStatement();
					
					int cod=Integer.parseInt(request.getParameter("block"));
					
					String sql ="update rooms set rooms.rservated=1 where rooms.codice = "+cod+";";
					boolean res= statement.execute(sql);
				
					connection.close();
					
					request.getRequestDispatcher("availableRooms.jsp").include(request, response);
					
				} catch (Exception e) {
					e.printStackTrace();
					
					request.getRequestDispatcher("availableRooms.jsp").include(request, response);
				}
			%>

	</body>
</html>