package com.bookstore;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
 * Servlet implementation class checkout2
 */
@WebServlet("/checkout2")
public class checkout2 extends HttpServlet {
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uname = request.getParameter("uname");
		String cusId = request.getParameter("cusId");
		String amount = request.getParameter("amount");
		String cardId = request.getParameter("cardId");
		String promoId = request.getParameter("promoId");
		if(promoId == null || promoId.trim().isEmpty()) {
			promoId = null;
		}
		String name = request.getParameter("name");
		long millis=System.currentTimeMillis();
		Date today = new java.sql.Date(millis);
		String currentDate = today.toString();
		String query1 = "INSERT INTO bookstore.order (customer_id, promotion_id, card_id, date_created, date_shipped, amount) values"
				+ "('"+cusId+"', "+promoId+", '"+cardId+"', '"+currentDate+"', '"+currentDate+"', '"+amount+"');";
		
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
			Statement st1 = con.createStatement();
			st1.executeUpdate(query1);
			
			String query2 = "SELECT * FROM bookstore.cart JOIN bookstore.inventory USING (book_id) WHERE customer_id = '"+cusId+"';";
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery(query2);
			String query3 = "SELECT max(order_id) FROM bookstore.order;";
			Statement st3 = con.createStatement();
			ResultSet rs3 = st3.executeQuery(query3);
			String orderId = "";
			while (rs3.next()) {
				orderId = rs3.getString(1);
			}
			String bookId = "";
			int bookQuantity = 0;
			int invQuantity = 0;
			int updateQuantity = 0;
			while (rs2.next()) {
				bookId = rs2.getString(1);
				bookQuantity = rs2.getInt(3);
				invQuantity = rs2.getInt(4);
				updateQuantity = invQuantity - bookQuantity;
				String query4 = "INSERT INTO bookstore.order_item (order_id, book_id, quantity) "
						+ "VALUES ('"+orderId+"', '"+bookId+"', '"+bookQuantity+"');";
				Statement st4 = con.createStatement();
				st4.executeUpdate(query4);
				
				String query5 = "UPDATE bookstore.inventory SET quantity = '"+updateQuantity+"' WHERE book_id = '"+bookId+"'; ";
				Statement st5 = con.createStatement();
				st5.executeUpdate(query5);
			}
			
			String query6 = "DELETE FROM bookstore.cart WHERE customer_id = '"+cusId+"';";
			Statement st6 = con.createStatement();
			st6.executeUpdate(query6);
			
			String query7 = "SELECT * FROM bookstore.customer WHERE customer_id = '"+cusId+"';";
			Statement st7 = con.createStatement();
			ResultSet rs7 = st7.executeQuery(query7);
			String email = "";
			while(rs7.next()) {
				email = rs7.getString(3);
			}
			
			String conNum = cusId + "-" + orderId;
			
			String query8 = "SELECT * FROM bookstore.address WHERE customer_id='" + cusId + "' AND address_type='S';";
			Statement st8 = con.createStatement();
			ResultSet rs8 =st8.executeQuery(query8);
			String streetS = "";
			String cityS = "";
			String stateS = "";
			String zipS = "";
			while (rs8.next()) {
				streetS = rs8.getString(3);
				cityS = rs8.getString(4);
				stateS = rs8.getString(5);
				zipS = rs8.getString(6);
			}
			String Shipping = "Shipping Address: \n\t"+streetS+"\n\t"+cityS+" "+stateS+" "+zipS;
			
			String query9 = "SELECT * FROM bookstore.order_item JOIN bookstore.book USING (book_id) WHERE order_id = '"+orderId+"';";
			Statement st9 = con.createStatement();
			ResultSet rs9 =st9.executeQuery(query9);
			String orderItem = "Order Items:";
			while (rs9.next()) {
				orderItem = orderItem + "\n\t" + rs9.getString(4) + " X " + rs9.getString(7); 
			}

			String host = "smtp.gmail.com";
	        String port = "587";
	        String emailId = "bookstore9c@gmail.com";
	        String password = "Bookpassword9C";
	        String toAddress = email;
	        String subject = "Your Online Bookstore Order confirmation ";
	        String message = "Customer Name: " + name + "\n\nConfirmation number: " +conNum+ "\n\nOrder ID: "
	        		+ orderId + "\n\nOrder Date: " + currentDate + "\n\n" + Shipping + "\n\n" + orderItem + "\n\nTotal Amount: $" 
	        		+ amount;
	        
	        try {
				EmailUtility.sendEmail(host, port, emailId, password, toAddress, subject, message);
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        RequestDispatcher rs = request.getRequestDispatcher("orderConfirmation.html");
            rs.include(request, response);
	
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
