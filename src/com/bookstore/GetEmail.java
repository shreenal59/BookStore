package com.bookstore;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetEmail
 */
@WebServlet("/GetEmail")
public class GetEmail extends HttpServlet {
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
        
        String email = request.getParameter("email");
        String query = "SELECT email_address, bookstore.user.user_id, cast(aes_decrypt(password, \"4050\") as char) FROM bookstore.customer inner join bookstore.user on bookstore.user.user_id = bookstore.customer.user_id;";
        
        String uname = "";
        String pass = "";
        boolean valid = false;
        
        try {
        	Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
			Statement st = con.createStatement();
			ResultSet rs =st.executeQuery(query);
			
			
			while(rs.next()) {
				if (rs.getString(1).equalsIgnoreCase(email)) {
					valid = true;
					uname = rs.getString(2);
					pass = rs.getString(3);
				} 
			}
			
		
			
		} catch (SQLException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (valid) {
	        String host = "smtp.gmail.com";
	        String port = "587";
	        String emailId = "bookstore9c@gmail.com";
	        String password = "Bookpassword9C";
	        String toAddress = email;
	        String subject = "Your Online Bookstore User Name and Password";
	        String message = "We received a request to retrive your Email and Password\n\n Your User Name:"
	        		+ uname +"\n Your Password: " + pass ;
	        
	        try {
				EmailUtility.sendEmail(host, port, emailId, password, toAddress, subject, message);
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        out.println("<script>");
            out.println("alert('Email sent successfully, Check your email');");
            out.println("</script>");
        	RequestDispatcher rs = request.getRequestDispatcher("login.html");
            rs.include(request, response);
        
        } else {
        	out.println("<script>");
            out.println("alert('We do not have any account with provided email, Try again');");
            out.println("</script>");
        	RequestDispatcher rs = request.getRequestDispatcher("login.html");
            rs.include(request, response);
        }
        
	}

}
