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

@WebServlet("/UpdateQuantityInCart")
public class UpdateQuantityInCart extends HttpServlet{
	public void doPost(HttpServletRequest request, HttpServletResponse response)
		      throws ServletException, IOException {

	    int bookID = Integer.parseInt(request.getParameter("bookID"));
	    int quantity = Integer.parseInt(request.getParameter("quantity"));
	    
	    try {

			Class.forName("com.mysql.jdbc.Driver");
//			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore", "root", "lkjhlkjh");

			Statement st = con.createStatement();
			PreparedStatement ps = con.prepareStatement(
					"UPDATE cart SET quantity = "+ quantity +" WHERE book_id = " + bookID);
			ps.executeUpdate();
			
			RequestDispatcher rd = request.getRequestDispatcher("shoppingcart.jsp");
	 		rd.include(request, response);
	 		
	    } catch (Exception e) {
			e.printStackTrace();
		}
	    
	}
}
