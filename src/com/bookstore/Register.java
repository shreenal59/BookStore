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

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Register")
public class Register extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		boolean test = true;

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		String nameF = request.getParameter("name-first");
		String nameL = request.getParameter("name-last");
		String email = request.getParameter("email");
		// String uname = request.getParameter("uname");
		String pass = request.getParameter("psw");
		String phone = request.getParameter("phone");
		pass = "aes_encrypt('" + pass + "', '4050')";

		/* String street = request.getParameter("street");
		String city = request.getParameter("city");
		String state = request.getParameter("State");
		String zip = request.getParameter("zip");

		String ccnum = request.getParameter("ccnum");
		String cvc = request.getParameter("cvc");
		String expDate = request.getParameter("expDate");
		String ccname = request.getParameter("ccname"); */

		try {

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore", "root", "4122");
			Statement st = con.createStatement();
			ResultSet rsE = st.executeQuery("SELECT * from Customer where email_address='" + email + "'");

			String duplicate = null;

			while (rsE.next()) {
				duplicate = rsE.getString(1);
			}

			if (duplicate == null) {

				CallableStatement cs = con.prepareCall("{? = call create_user(?,?,?,?,?)}");

				cs.registerOutParameter(1, Types.VARCHAR);
				cs.setString(2, nameF);
				cs.setString(3, nameL);
				cs.setString(4, email);
				cs.setString(5, pass);
				cs.setString(6, phone);
				cs.execute();
				String uId = cs.getString(1);

				st = con.createStatement();
				ResultSet rs = st.executeQuery("SELECT max(customer_id) FROM bookstore.customer;");
				rs.next();
				int cusId = rs.getInt(1) + 1;

				
				PreparedStatement ps = con
						.prepareStatement("insert into user (user_id, password, first_name, last_name, User_Type)\r\n"
								+ "	values ( ?, ?, ?, ?, 'C');");

				ps.setString(1, uId);
				ps.setString(2, pass);
				ps.setString(3, nameF);
				ps.setString(4, nameL);

				PreparedStatement psc = con.prepareStatement(
						"insert into Customer (customer_id, user_id, email_address, phone_number, status)\r\n"
								+ "	values (?, ?, ?, ?, 'A');");

				psc.setInt(1, cusId);
				psc.setString(2, uId);
				psc.setString(3, email);
				psc.setString(4, phone);

				/* PreparedStatement psa = con.prepareStatement(
						"insert into Address (addess_id, customer_id, street, city, state, zip, address_type)\r\n"
								+ "values (?, ?, ?, ?, ?, ?, ?)");

				
				Statement st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery("SELECT max(addess_id) FROM bookstore.address;");
				rs1.next();
				int addId = rs1.getInt(1) + 1;
				psa.setInt(1, addId);
				
				Statement stm1 = con.createStatement();
				ResultSet rsc1 =stm1.executeQuery("SELECT max(customer_id) FROM bookstore.customer;");
				rsc1.next();
				int addCusId1 = rsc1.getInt(1);
				
				psa.setInt(2, addCusId1);
				psa.setString(3, street);
				psa.setString(4, city);
				psa.setString(5, state);
				psa.setString(6, zip);
				psa.setString(7, "'S'");
				

				PreparedStatement pscc = con.prepareStatement(
						"insert into Payment_Card (card_id, customer_id, card_number, expiration_date, card_type)\r\n"
								+ "values (?, ?, ?, ?, ?)");

				Statement st2 = con.createStatement();
				ResultSet rs2 = st2.executeQuery("SELECT max(card_id) FROM bookstore.Payment_Card;");
				rs2.next();
				int cardId = rs2.getInt(1) + 1;
				pscc.setInt(1, cardId);
				
				Statement stm2 = con.createStatement();
				ResultSet rsc2 =stm2.executeQuery("SELECT max(customer_id) FROM bookstore.customer;");
				rsc2.next();
				int addCusId2 = rsc2.getInt(1);
				pscc.setInt(2, addCusId2);
				pscc.setString(3, ccnum);
				pscc.setString(4, expDate);
				pscc.setString(5, getCardType(ccnum)); */

				//ps.executeUpdate();
				//psc.executeUpdate();
				//psa.executeUpdate();
				//pscc.executeUpdate();

			} else {
				test = false;
				out.println("<script>");
				out.println(
						"alert('This email is already in the database; please try again with a different email address.');");
				out.println("</script>");
				RequestDispatcher rd = request.getRequestDispatcher("registration.jsp");
				rd.include(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		if (test = true) {
			String host = "smtp.gmail.com";
			String port = "587";
			String emailId = "bookstore9c@gmail.com";
			String password = "Bookpassword9C";
			String toAddress = email;
			String subject = "Thank You For Registering With Us!";
			String message = "Thank you for registering with our Bookstore. You now have access to our site!";

			try {
				EmailUtility.sendEmail(host, port, emailId, password, toAddress, subject, message);
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			RequestDispatcher rd = request.getRequestDispatcher("register-confirmation.html");
			rd.include(request, response);
		}

	}

	public String getCardType(String ccnum) {

		String type = "";
		if (ccnum.charAt(0) == '3') {
			type = "'A'";
		}
		if (ccnum.charAt(0) == '4') {
			type = "'V'";
		}
		if (ccnum.charAt(0) == '5') {
			type = "'M'";
		}
		if (ccnum.charAt(0) == '6') {
			type = "'D'";
		}

		return type;

	}
}
