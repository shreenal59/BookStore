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

@WebServlet("/EditBook")
public class EditBook extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException { 
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String bID = request.getParameter("book_id");
		int bookID = Integer.parseInt(bID);
		String isbn = request.getParameter("ISBN");
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String edition = request.getParameter("edition");
		String publisher = request.getParameter("publisher");
		String pubYear = request.getParameter("publication_year");
		String authorFirst = request.getParameter("author_first");
		String authorLast = request.getParameter("author_last");
		String stock = request.getParameter("stock");
		//int quantity = Integer.parseInt(stock);
		String msrp = request.getParameter("MSRP");
		String status = request.getParameter("Book Status");
		
		String[] bookAttArr = {"isbn", "category", "title", "edition", "publisher", "publication_year"};
		String[] editBookArr = {isbn, category, title, edition, publisher, pubYear};
		
		String[] authorAttArr = {"first_name", "last_name"};
		String[] editAuthorArr = {authorFirst, authorLast};
		
		String[] inventAttArr = {"quantity", "price", "Book_Status"};
		String[] editInventArr = {stock, msrp, status };
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore", "root", "lkjhlkjh");
			Statement st = con.createStatement();
			
			
			String queryBook = "UPDATE book set ";
			
			for (int i = 0; i < bookAttArr.length; i++) {
				if (!editBookArr[i].equals("")) {
					queryBook = queryBook + bookAttArr[i] + "='" + editBookArr[i] + "', ";
				}
				
			}
			
			queryBook = queryBook.substring(0, queryBook.length()- 2);
			queryBook += " where book_id = " + bookID;
			
			String queryAuthor = "UPDATE author set ";
					
			for (int i = 0; i < authorAttArr.length; i++) {
				if (!editAuthorArr[i].equals("")) {
					queryAuthor = queryAuthor + authorAttArr[i] + "='" + editAuthorArr[i]  + "', ";
				}
			}
			
			queryAuthor = queryAuthor.substring(0, queryAuthor.length()- 2);
			queryAuthor += " where book_id = " + bookID;
			
			String queryInvent = "UPDATE inventory set ";
			
			for (int i = 0; i < inventAttArr.length; i++) {
				if (!editInventArr[i].equals("")) {
					queryInvent = queryInvent + inventAttArr[i] + "='" + editInventArr[i] + "', ";
				}
				
			}
			
			queryInvent = queryInvent.substring(0, queryInvent.length()- 2);
			queryInvent += " where book_id = " + bookID;
			
			System.out.println(queryBook);
			System.out.println(queryAuthor);
			System.out.println(queryInvent);
			
//			PreparedStatement psB;
//			psB = con.prepareStatement(queryBook);
//			psB.executeUpdate();
			
			
			PreparedStatement psA;
			psA = con.prepareStatement(queryAuthor);
			psA.executeUpdate();
			
			PreparedStatement psI;
			psI = con.prepareStatement(queryInvent);
			psI.executeUpdate();
			
			PreparedStatement psB;
			psB = con.prepareStatement(queryBook);
			psB.executeUpdate();
			
			out.println("<script>");
			out.println(
					"alert('Your book has been edited in the Database');");
			out.println("</script>");
			RequestDispatcher rd = request.getRequestDispatcher("managebooks.jsp");
			rd.include(request, response);
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
