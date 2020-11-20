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

@WebServlet("/AddBook")
public class AddBook extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//out.println("<script>");
		//out.println("TEST");
		//out.println("</script>");
		
		String isbn = request.getParameter("ISBN");
		String category = request.getParameter("category");
		String title = request.getParameter("title");
		String edition = request.getParameter("edition");
		String publisher = request.getParameter("publisher");
		String pubYear = request.getParameter("publication_year");
		String authorFirst = request.getParameter("author_first");
		String authorLast = request.getParameter("author_last");
		String stock = request.getParameter("stock");
		String msrp = request.getParameter("MSRP");
		String status = request.getParameter("Book Status");
		String image = "default.jpg";
		
		try {

			//Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore", "root", "lkjhlkjh");
			Statement st = con.createStatement();
			
			ResultSet rsI = st.executeQuery("SELECT * from Book where isbn='" + isbn + "'");
			
			String duplicate = null;
			
			while (rsI.next()) {
				duplicate = rsI.getString(1);
			}
			
			if (duplicate == null) {
				
				ResultSet rs = st.executeQuery("SELECT max(book_id) FROM bookstore.book;");
				rs.next();
				int bookID = rs.getInt(1) + 1;
				
				PreparedStatement ps = con
						.prepareStatement("insert into Book (book_id, isbn, category, title, edition, publisher, publication_year, cover_picture)\r\n"
								+ "		values(?,?,?,?,?,?,?,?)");
				ps.setInt(1, bookID);
				ps.setString(2, isbn);
				ps.setString(3, category);
				ps.setString(4, title);
				ps.setString(5, edition);
				ps.setString(6, publisher);
				ps.setInt(7, Integer.parseInt(pubYear));
				ps.setString(8, "1001.png");
				
				PreparedStatement psA = con
						.prepareStatement("insert into author (book_id, first_name, last_name)\r\n"
								+ "		values(?,?,?)");
				
				psA.setInt(1, bookID);
				psA.setString(2, authorFirst);
				psA.setString(3, authorLast);
				
				PreparedStatement psI = con
						.prepareStatement("insert into Inventory (book_id, quantity, price, Book_Status)\r\n"
								+ "		values(?,?,?,?)");	
				
				psI.setInt(1, bookID);
				psI.setInt(2, Integer.parseInt(stock));
				psI.setDouble(3, Double.parseDouble(msrp));
				psI.setString(4, status);
				
				ps.executeUpdate();
				psA.executeUpdate();
				psI.executeUpdate();
				
				out.println("<script>");
				out.println(
						"alert('Your book has been added to the Database');");
				out.println("</script>");
				RequestDispatcher rd = request.getRequestDispatcher("managebooks.jsp");
				rd.include(request, response);
				
			} else {
				
				out.println("<script>");
				out.println(
						"alert('This ISBN is assigned to another book, please try again.');");
				out.println("</script>");
				RequestDispatcher rd = request.getRequestDispatcher("managebooks.jsp");
				rd.include(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}

}
