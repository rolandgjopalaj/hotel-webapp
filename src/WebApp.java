

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.xml.bind.v2.schemagen.xmlschema.List;

import java.util.ArrayList;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

/**
 * Servlet implementation class WebApp
 */
@WebServlet("/WebApp")
public class WebApp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Connection conn = null;
	private String URL_myDB = "jdbc:mysql://localhost:3306/hotel";
	private String dbuser="root"; 
	private String dbpassw="";
	
	HttpSession sessione;
       
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WebApp() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init(ServletConfig config) throws ServletException 
	{
		String DRIVER = "com.mysql.jdbc.Driver";

	    try 
	    {
	      Class.forName(DRIVER);
	      System.out.println("Driver Connector/J trovato!");
	    }
	    catch (ClassNotFoundException e)
	    {
	      System.out.println("WARNING: driver Connector/J NON trovato!");
	      System.out.println("Error! Driver Connector/J trovato!");
	    }

	}
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		///////////////////////////////////////////////////////////
		response.setContentType("text/html");
		PrintWriter pr = response.getWriter();
		
		sessione = request.getSession(); 
		
		try {
			int value = Integer.parseInt(sessione.getAttribute("value").toString());
			String username=(String)sessione.getAttribute("user");
			
			/*pr.println("<div class=\'\'>");
			pr.println("<p><h1 class=\'text-center mb-0\' >Hello "+username+" "+value+"</h1></p>");
			pr.println("</div>");
			*/
			request.getRequestDispatcher("admin.jsp").include(request, response);
		
		
		} catch(Exception e) {
			
			request.getRequestDispatcher("home.html").include(request, response);
		}
		///////////////////////////////////////////////////////////
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		boolean flag=true;
		////////////////////////////////////////////////////////
		PrintWriter pr = response.getWriter();
		
		String idH = request.getParameter("idH");
		
		if(idH.equals("login"))
		{
		
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			if(controllo(username,password,pr))
			{
				flag=true;
				try {
					sessione.setAttribute("value", 1111);
					sessione.setAttribute("user", username);
				}catch(Exception e) {
					//sessione.invalidate();
				}
			}else {
				flag=false;
				//sessione.invalidate();
				System.out.println(" non correte");
				request.getRequestDispatcher("login.html").include(request, response);
			}
		
		
		}else if(idH.equals("logout")){
			sessione.invalidate();
		}else if(idH.equals("reservation"))
		{
			ArrayList<Integer> room = rooms();
			
			
			if(!room.isEmpty())
			{
				int roomCodice = room.size();
				
				updateRoom(roomCodice);
				
				String email=request.getParameter("email");
				
				String name=request.getParameter("name");
				String phone=request.getParameter("phone");
				int nrAdult= Integer.parseInt(request.getParameter("nrAdult"));
				String day=request.getParameter("day");
				String month=request.getParameter("month");
				String year=request.getParameter("year");
				int nrDays=Integer.parseInt(request.getParameter("nrDays"));
				String msg=request.getParameter("msg");
				
				String date = year+"-"+month+"-"+day;
				
				String mailBodyText = "Dear "+name+ ", \n Thank you for choosing us as your preferred accomodation. "
						+ "\n Date: "+date+". \n Hotel Relax.";
				
				
				
				insertClient(email, name, phone);
				
				insertReservation(date, nrDays, nrAdult, 30, roomCodice, email);
				
				sendMail(email ,mailBodyText);
				
				email=null;
			}
			
		}else if(idH.equals("contact"))
		{
			String email=request.getParameter("email");
			String name=request.getParameter("name");
			String phone=request.getParameter("phone");
			String msg=request.getParameter("message");
			
			String mailBodyText = "Client message,"
					+ "\n The client "+name+ " with the relative email "+email+" and phone number "+phone+" wrote the following message. "
							+ "\n \n "+msg+"";
			
			sendMail("programmit2@gmail.com",mailBodyText);
		}
		
		////////////////////////////////////////////////////////
		
		if(flag)
		{
			doGet(request, response);
		}
	}
	
	public void updateRoom(int cod)
	{
		try
	    {
	    	conn = DriverManager.getConnection(URL_myDB, dbuser, dbpassw);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di apertura connessione");
	    	conn = null;
	    }
		// Insert
	    String insertCommand = "UPDATE rooms SET rooms.rservated=1 WHERE rooms.codice = "+cod+";" ;
	    System.out.println(insertCommand);
	    try
	    {
	    	Statement cmd = conn.createStatement();
	    	cmd.executeUpdate(insertCommand);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di inserimento");
	    } 
	    if(conn != null)
	    {
	    	try 
	    	{
				conn.close();
			} 
	    	catch (SQLException e) 
	    	{
				e.printStackTrace();
			}
	    }
	}
	
	public ArrayList<Integer> rooms()
	{
		ArrayList<Integer> list = new ArrayList<Integer>();
		
		try
	    {
	    	conn = DriverManager.getConnection(URL_myDB, dbuser, dbpassw);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di apertura connessione");
	    	conn = null;
	    }
		
		String query = "select rooms.codice from rooms where rooms.rservated=0;";
		
		try
	    {
	    	Statement cmd = conn.createStatement();
	    	ResultSet tabellaRis = cmd.executeQuery(query);
	    	 
            while (tabellaRis.next()) 
            {  
                int codice = Integer.parseInt(tabellaRis.getString("codice"));  
                list.add(codice);
            }  

            
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di inserimento");
	    } 
	    if(conn != null)
	    {
	    	try 
	    	{
				conn.close();
			} 
	    	catch (SQLException e) 
	    	{
				e.printStackTrace();
			}
	    }
		
		return list;
	}
	
	private void insertClient(String email, String name, String phone)
	{
		try
	    {
	    	conn = DriverManager.getConnection(URL_myDB, dbuser, dbpassw);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di apertura connessione");
	    	conn = null;
	    }
		// Insert
	    String insertCommand = "insert into clients (email, name, phone) value ( \'"+email+"\', \'"+name+"\', \'"+phone+"\');" ;
	    System.out.println(insertCommand);
	    try
	    {
	    	Statement cmd = conn.createStatement();
	    	cmd.executeUpdate(insertCommand);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di inserimento");
	    } 
	    if(conn != null)
	    {
	    	try 
	    	{
				conn.close();
			} 
	    	catch (SQLException e) 
	    	{
				e.printStackTrace();
			}
	    }
	}
	
	private void insertReservation(String date, int nrDays, int nrAdults, int cost, int room, String client)
	{
		try
	    {
	    	conn = DriverManager.getConnection(URL_myDB, dbuser, dbpassw);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di apertura connessione");
	    	conn = null;
	    }
		// Insert
	    String insertCommand = "insert into reservations (date, nrdays, nradult, cost, room, client) value ( \'"+date+"\', \'"+nrDays+"\', \'"+nrAdults+"\', \'"+cost+"\', \'"+room+"\', \'"+client+"\');";
	    System.out.println(insertCommand);
	    try
	    {
	    	Statement cmd = conn.createStatement();
	    	cmd.executeUpdate(insertCommand);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di inserimento");
	    } 
	    if(conn != null)
	    {
	    	try 
	    	{
				conn.close();
			} 
	    	catch (SQLException e) 
	    	{
				e.printStackTrace();
			}
	    }
	}
	
	private boolean controllo(String username, String password, PrintWriter pr)
	{
		boolean flag =false;
		try
	    {
	    	conn = DriverManager.getConnection(URL_myDB, dbuser, dbpassw);
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di apertura connessione" +e);
	    	conn = null;
	    }
		
		String query = "select username from users where \'"+username+"\' = username and \'"+password+"\' = password ";
		
		try
	    {
	    	Statement cmd = conn.createStatement();
	    	ResultSet tabellaRis = cmd.executeQuery(query);
	    	
	    	while (tabellaRis.next()) 
            {
	    		if(tabellaRis.getString("username").equals(username))
		    	{
		    		flag=true;
		    	}
            }
            
	    }
	    catch (Exception e)
	    {
	    	System.out.println("Errore di querry");
	    } 
	    if(conn != null)
	    {
	    	try 
	    	{
				conn.close();
			} 
	    	catch (SQLException e) 
	    	{
				e.printStackTrace();
			}
	    }
		
		
		return flag;
	}
	
	private void sendMail(String clientEMail ,String mailBodyText)
	{
		String host = "smtp.gmail.com";
		  final String user = "programmit2@gmail.com";
		  final String password = "Jamandi11";
		  
		  String to = clientEMail;
		  // Get the session object
		  Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.auth", "true");
		  // props.put("mail.smtp.auth", "true");
		  props.put("mail.smtp.starttls.enable", "true");
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", "587");
		  
		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
		    return new PasswordAuthentication(user, password);
		   }
		  });
		  // Compose the message
		  try {
		   MimeMessage message = new MimeMessage(session);
		   
		   message.setFrom(new InternetAddress(user));
		   
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		   
		   message.setSubject("Reply from Hotel Relax");
		   
		   message.setText(mailBodyText);
		   // send the message
		   Transport.send(message);
		   System.out.println("message sent successfully...");
		  
		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
	}
	
	
}

