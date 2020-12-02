package com.bookstore;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.text.*;

@WebServlet("/EditProfile")
public class EditProfile extends HttpServlet{

	//grabs the customer info and displays it
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//set up and introduce file
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		//get the information needed
		String firstName = request.getParameter("name-first");
		String lastName = request.getParameter("name-last");
		String ePassword = request.getParameter("psw");
		String password = request.getParameter("psw-repeat");
		String password2 = request.getParameter("psw-repeat");
		String phone = request.getParameter("number");
		
		String street = request.getParameter("street");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		int zip = Integer.parseInt(request.getParameter("zip")); 
			
		String cardNum = request.getParameter("card-number");
		Date expirationDate = null;
		try {
			expirationDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("expiration-date"));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		
		String[] subscription = request.getParameterValues("subscription");
		
		String userID = "";
		int customerID = 0;
		Cookie cookies[] = request.getCookies();
		
		for(Cookie c : cookies) {
			if(c.getName().equals("uname")) {
				userID = c.getValue();
				break;
			}
		}
		
		try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT cast(aes_decrypt(password, \"4050\") as char) FROM user WHERE user_id=" + "'" + userID +"';");
            String checkPass = "";
            while(rs.next()) {
            	checkPass = rs.getString(1);
            	System.out.println(checkPass);
            }
            
            //check for same password and correct current password
            System.out.println(ePassword.equals(checkPass));
            System.out.println(cardNum);
            if(password.equals(password2) && ePassword.equals(checkPass)) {
            
            	//Gets customer_id for use
            	rs = st.executeQuery("SELECT customer_id, user_id FROM bookstore.customer;");
            	while(rs.next()) {
            		if(rs.getString(2).equals(userID)) {
            			customerID = rs.getInt(1);
            			break;
            		}
            	}
          
            	//Update user table in db(First and last names, password
            	String query3 = "UPDATE user set first_name=?,last_name=?,password=AES_ENCRYPT(?,'4050') WHERE user_id=?";
            	PreparedStatement stmt1 = con.prepareStatement(query3);
            	stmt1.setString(1,firstName);
            	stmt1.setString(2,lastName);
            	stmt1.setString(3,password);
            	stmt1.setString(4, userID);
            	int i = stmt1.executeUpdate();
            	
            	//Update Customer table in db(phone number and email)
            	PreparedStatement stmt2 = con.prepareStatement("UPDATE customer set phone_number=? WHERE customer_id=?");
            	stmt2.setString(1,phone);
            	stmt2.setInt(2, customerID);
            	int j = stmt2.executeUpdate();
            	
            	//Update Address
            	PreparedStatement stmt3 = con.prepareStatement("UPDATE Address SET street=?,city=?,state=?,zip=? WHERE customer_id=?");
            	stmt3.setString(1,street);
            	stmt3.setString(2,city);
            	stmt3.setString(3,state);
            	stmt3.setInt(4, zip);
            	stmt3.setInt(5, customerID);
            	int k = stmt3.executeUpdate();
            	
            	//Update Payment Card
            	System.out.println(cardNum);
            	java.sql.Date sqlExpDate = new java.sql.Date(expirationDate.getTime());
            	PreparedStatement stmt4 = con.prepareStatement("UPDATE Payment_Card SET card_number=AES_ENCRYPT(?,'4050'),expiration_date=? WHERE customer_id=?");
            	stmt4.setString(1,cardNum);
            	stmt4.setDate(2,sqlExpDate);
            	stmt4.setInt(3, customerID);
            	int l = stmt4.executeUpdate();
            	
            	//Update subscription
            	
            	
            	out.println("<script>");
            	out.println("alert('Successfully Updated');");
            	out.println("<script>");
            	
            	RequestDispatcher rd = request.getRequestDispatcher("index.html");
				rd.include(request, response);	
            }
            else {
            	out.println("<script>");
            	out.println("alert('Existing password incorrect or mismatch passwords, Try again');");
            	out.println("<script>");
            	RequestDispatcher rd = request.getRequestDispatcher("index.html");
				rd.include(request, response);	
            }
        }	catch(SQLException | ClassNotFoundException e) {
        	e.printStackTrace();
        }
	}
}
