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

@WebServlet("/VerifyCode")
public class VerifyCode extends HttpServlet{

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String code = request.getParameter("code");
		PrintWriter out = response.getWriter();

		try {
			Class.forName("com.mysql.jdbc.Driver");
  		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore", "root", "lkjhlkjh");

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * from Customer where verification_code='" + code + "'");


			if (rs.next() == true) {

					if (rs.getString(6) != null) {
						PreparedStatement ps = con.prepareStatement(
								"UPDATE customer SET status='A', verification_code = NULL WHERE customer_id = " + rs.getInt(1));
						ps.executeUpdate();
						out.println("<script>");
						out.println(
								"alert('Thank you! You now have access to the site!');");
						out.println("</script>");
						RequestDispatcher rd = request.getRequestDispatcher("login.html");
						rd.include(request, response);
					} 
				
			} else {
				out.println("<script>");
				out.println(
						"alert('The verification code you entered is incorrect, please try again');");
				out.println("</script>");
				RequestDispatcher rd = request.getRequestDispatcher("register-confirmation.html");
				rd.include(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
