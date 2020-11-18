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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBook")
public class DeleteBook extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { 
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String bID = request.getParameter("book_id");
		int bookID = Integer.parseInt(bID);
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore", "root", "lkjhlkjh");
			Statement st = con.createStatement();
			
			String query = "DELETE FROM author WHERE book_id = " + bookID;
			System.out.println(query);
			
			PreparedStatement ps = con.prepareStatement(query);
			ps.executeUpdate();
			
			query = "DELETE FROM inventory WHERE book_id = " + bookID;
			
			ps = con.prepareStatement(query);
			ps.executeUpdate();
			
			query ="DELETE FROM book WHERE book_id = " + bookID;
			
			ps = con.prepareStatement(query);
			ps.executeUpdate();
			
			out.println("<script>");
			out.println(
					"alert('Your book has been deleted from the Database');");
			out.println("</script>");
			RequestDispatcher rd = request.getRequestDispatcher("managebooks.jsp");
			rd.include(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
	}
}
