package com.bookstore;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.text.*;

@WebServlet("/AddRating")
public class AddRating extends HttpServlet{
	//set up and introduce file
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//set up and introduce file
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int rating = 0;
		rating = Integer.parseInt(request.getParameter("rate")); 
		int bookID = 0;
		bookID = Integer.parseInt(request.getParameter("bookID"));
		boolean exists = false;
		
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
            ResultSet rs = st.executeQuery("SELECT customer_id, user_id FROM bookstore.customer;");
        	while(rs.next()) {
        		if(rs.getString(2).equals(userID)) {
        			customerID = rs.getInt(1);
        			break;
        		}
        	}
        	rs = st.executeQuery("SELECT customer_id, book_id FROM bookstore.Rating");
        	while(rs.next()) {
        		if(customerID == rs.getInt(1) && bookID == rs.getInt(2)) {
        			exists = true;
        			break;
        		}
        	}
        	
        	if(exists == true) {
        		String query = "UPDATE bookstore.Rating SET numeric_rating=? where customer_id=? and book_id=?";
        		PreparedStatement stmt1 = con.prepareStatement(query);
        		stmt1.setInt(1,rating);
        		stmt1.setInt(2, customerID);
        		stmt1.setInt(3, bookID);
        		int i = stmt1.executeUpdate();
        		
        		out.println("<script>");
            	out.println("alert('Successfully Updated');");
            	out.println("<script>");
            	
            	response.sendRedirect("myorder.jsp");
        	}
        	
        	else {
        		PreparedStatement ps = con.prepareStatement("insert into bookstore.Rating(customer_id,book_id,numeric_rating)"
        				+ "values (?,?,?);");
        		ps.setInt(1, customerID);
        		ps.setInt(2, bookID);
        		ps.setInt(3, rating);
        		ps.executeUpdate();
        		
        		out.println("<script>");
            	out.println("alert('Successfully added rating');");
            	out.println("<script>");
            	
            	response.sendRedirect("myorder.jsp");
        	}
		}catch(SQLException | ClassNotFoundException e) {
        	e.printStackTrace();
		}
	}
}
