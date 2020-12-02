package com.bookstore;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet{
	
	 public void doPost(HttpServletRequest request, HttpServletResponse response)
		      throws ServletException, IOException {
		Cookie cookie = null;
	    Cookie[] cookies = null;
	    cookies = request.getCookies();
	    response.setContentType("text/html");
	    int cusID = 0;
	    String user="";

	    
	    int bookID = Integer.parseInt(request.getParameter("bookID"));
	    int quantity = Integer.parseInt(request.getParameter("quantity"));
	    System.out.println(bookID);
	    PrintWriter out = response.getWriter();
	    try {

			Class.forName("com.mysql.jdbc.Driver");
//			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore", "root", "lkjhlkjh");

			Statement st = con.createStatement();
	    
	      for (int i = 0; i < cookies.length; i++) {
	    	  System.out.println("NAME: " + cookies[i].getName());
	    	  System.out.println("VALUE: " + cookies[i].getValue());
	      }
	      
	      
	      if( cookies != null && cookies.length > 1) {
	 	    
	         for (int i = 0; i < cookies.length; i++) {
	        	 if (cookies[i].getName().equals("uname")) {
	        		 user = cookies[i].getValue();
	        		 break;
	        	 }
	         }
	        
	         
	         PreparedStatement psID = con.prepareStatement(
	        		 "select customer_id from customer where user_id = '"+user+"'");
	         System.out.println( "select customer_id from customer where user_id = '"+user+"'");
	         
	         ResultSet rs = psID.executeQuery();
	         while (rs.next()) {
	        	 cusID = rs.getInt(1);
	         }
	         
	         PreparedStatement ps = con.prepareStatement(
						"insert into Cart (customer_id, book_id, quantity)\r\n"
								+ "	values (?, ?, ?);");
	         
	         System.out.println(cusID + " " + bookID + " " + quantity);
	         ps.setInt(1, cusID);
	         ps.setInt(2, bookID);
	         ps.setInt(3, quantity);
	         
	         ps.executeUpdate();	         
	         
	         RequestDispatcher rd = request.getRequestDispatcher("shoppingcart.jsp");
		 		rd.include(request, response);
	         
	      } else {
	    	  System.out.println(cookies[0].getName());
	  	    RequestDispatcher rd = request.getRequestDispatcher("login.html");
	  		rd.include(request, response);
	      }

		} catch (Exception e) {
			e.printStackTrace();
		}

	    
//	    RequestDispatcher rd = request.getRequestDispatcher("shoppingcart.jsp");
//		rd.include(request, response);
	 }
}
