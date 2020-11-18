package com.bookstore;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 */
@WebServlet("/loginServlet")
public class Login extends HttpServlet {
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
        
        String uname = request.getParameter("uname");
        String pass = request.getParameter("psw");
        String status = "";
        String query = "select user_id, cast(aes_decrypt(password, \"4050\") as char), User_Type from bookstore.user;";
        String query2 = "SELECT email_address, cast(aes_decrypt(password, \"4050\") as char), User_Type FROM bookstore.customer inner join bookstore.user on bookstore.user.user_id = bookstore.customer.user_id;";
        String query3 = "SELECT email_address, bookstore.user.user_id FROM bookstore.customer inner join bookstore.user on bookstore.user.user_id = bookstore.customer.user_id;";
        String userType = "";
        String query4 = "";
        String query7 = "SELECT * FROM bookstore.customer WHERE user_id = '" + uname + "' OR email_address = '"+ uname +"';";
        
        boolean valid = false;
        try {
        	Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
			Statement st = con.createStatement();
			ResultSet rs =st.executeQuery(query);
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery(query2);
			Statement st4 = con.createStatement();
			
			Statement st7 = con.createStatement();
			ResultSet rs7 = st7.executeQuery(query7);
			boolean firstTime = false;
			
			if (rs7.next()) {
				String sta = rs7.getString(5);
				uname = rs7.getString(2);
				
				if (sta.equals("I")) {
					firstTime = true;
					String verCode = rs7.getString(6);
					if(verCode.equals(pass)) {
						String query8 = "Update bookstore.customer set status = 'A' where user_id='"+ uname + "';";
						Statement st8 = con.createStatement();
						st8.executeUpdate(query8);
						Cookie cookie = new Cookie("uname", uname);
		    			response.addCookie(cookie);
		    			out.println("<script>");
			            out.println("alert('First time login is successful. Now you can use your password to login.');");
			            out.println("</script>");
		        		RequestDispatcher rd = request.getRequestDispatcher("index.html");
		                rd.include(request, response);
					} else {
						out.println("<script>");
			            out.println("alert('Your verification code is incorrect, Try again');");
			            out.println("</script>");
			        	RequestDispatcher rd = request.getRequestDispatcher("login.html");
			            rd.include(request, response);
					}
				}
				
			}
			
			
			while(rs.next() && !valid) {
				if (rs.getString(1).equalsIgnoreCase(uname) && rs.getString(2).equals(pass)) {
					valid = true;
					userType = rs.getString(3);
				}
			}
			
			while(rs2.next() && !valid) {
				if (rs2.getString(1).equalsIgnoreCase(uname) && rs2.getString(2).equals(pass)) {
					valid = true;
					userType = rs2.getString(3);
					Statement st3 = con.createStatement();
					ResultSet rs3 = st3.executeQuery(query3);
					boolean valid1 = false;
					while(rs3.next() && !valid1) {
						if (rs3.getString(1).equalsIgnoreCase(uname)) {
							valid1 = true;
							uname = rs3.getString(2);
						}
					}
				}
			}
			
			

	        if (valid) {
	        	if (userType.equals("C")) {
		        	query4 = "SELECT status FROM bookstore.customer WHERE user_id='" + uname + "';";
					ResultSet rs3 = st4.executeQuery(query4);
					rs3.next();
		      		status = rs3.getString(1);
	        	}
	        	if (userType.equals("A") || userType.equals("E")) {
	        		Cookie cookie = new Cookie("userType", userType);
	    			response.addCookie(cookie);
	        		RequestDispatcher rd = request.getRequestDispatcher("admin.jsp");
	                rd.include(request, response);
	        	} else if (userType.equals("C") && status.equals("A")) {
	        		Cookie cookie = new Cookie("uname", uname);
	    			response.addCookie(cookie);
	        		RequestDispatcher rd = request.getRequestDispatcher("index.html");
	                rd.include(request, response);
	        	} else if (userType.equals("C") && status.equals("S")) {
	        		out.println("<script>");
		            out.println("alert('Sorry, You are suspended from our Site. Contect us to get more information');");
		            out.println("</script>");
		        	RequestDispatcher rd = request.getRequestDispatcher("login.html");
		            rd.include(request, response);
	        	} 
	        } else if(!firstTime) {
	        	out.println("<script>");
	            out.println("alert('Email or password incorrect, Try again');");
	            out.println("</script>");
	        	RequestDispatcher rd = request.getRequestDispatcher("login.html");
	            rd.include(request, response);
	        }
        
        } catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
