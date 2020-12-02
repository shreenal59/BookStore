package com.bookstore;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class checkout1
 */
@WebServlet("/checkout1")
public class checkout1 extends HttpServlet {
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String streetB = request.getParameter("streetB");
		String cityB = request.getParameter("cityB");
		String stateB = request.getParameter("stateB");
		String zipB = request.getParameter("zipB");
		
		String streetS = request.getParameter("streetS");
		String cityS = request.getParameter("cityS");
		String stateS = request.getParameter("stateS");
		String zipS = request.getParameter("zipS");
		
		String uname = request.getParameter("uname");
		String cusId = request.getParameter("cusId");
		String shipping = request.getParameter("shipping");
		String billing = request.getParameter("billing");
		String card = request.getParameter("card");
		
		String cardNo = request.getParameter("cardNo");
		String exDate = request.getParameter("Exp_date");
		String cardType = request.getParameter("cardType");
		
		String promo = request.getParameter("promo");
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
			String query1 = "";
			String query2 = "";
			String query3 = "";
			if (billing.equals("true")) {
				query1 = "UPDATE bookstore.address SET street = '" + streetB + "', city = '" + cityB +"', state = '"
						+ stateB +"', zip = '"+ zipB +"' Where customer_id = '"+cusId+ "' AND address_type = 'B';";
			} else {
				query1 = "insert into Address ( customer_id, street, city, state, zip, address_type) "
						+ "	values ( '"+ cusId +"', '"+streetB +"', '"+cityB+"', '"+stateB+"', '"+zipB+"', 'B');";
			}
			
			if (shipping.equals("true")) {
				query2 = "UPDATE bookstore.address SET street = '" + streetS + "', city = '" + cityS +"', state = '"
						+ stateS +"', zip = '"+ zipS +"' Where customer_id = '"+cusId+ "' AND address_type = 'S';";
			} else {
				query2 = "insert into Address ( customer_id, street, city, state, zip, address_type) "
						+ "	values ( '"+ cusId +"', '"+streetS +"', '"+cityS+"', '"+stateS+"', '"+zipS+"', 'S');";
			}
			
			if (card.equals("true")) {
				query3 = "UPDATE bookstore.payment_card SET card_number = aes_encrypt('"+cardNo+"', '4050'), "
						+ "expiration_date = '"+exDate+"', card_type = '"+cardType+"' Where customer_id = '"+cusId+"';";
			} else {
				String query4 = "Select max(card_id) FROM bookstore.payment_card;";
				Statement st4 = con.createStatement();
				ResultSet rs4 =st4.executeQuery(query4);
				int cardId = -1;
				while(rs4.next()) {
					cardId = rs4.getInt(1) + 1; 
				}
				query3 = "insert into Payment_Card ( card_id, customer_id, card_number, expiration_date, card_type)"
						+ "	values( '"+cardId+"', '"+cusId+"', aes_encrypt('"+cardNo+"', '4050'), '"+exDate+"', '"+cardType+"');";
				
			}
			
			
			Statement st1 = con.createStatement();
			st1.executeUpdate(query1);
			
			Statement st2 = con.createStatement();
			st2.executeUpdate(query2);
			
			Statement st3 = con.createStatement();
			st3.executeUpdate(query3);
			
			//Cookie cookie = new Cookie("promo", promo);
			//response.addCookie(cookie);
			HttpSession session = request.getSession();
			session.setAttribute("promo", promo);
			
			RequestDispatcher rd = request.getRequestDispatcher("checkout2.jsp");
            rd.include(request, response);

			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
