package com.bookstore;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Date;
import java.text.*;

@WebServlet("/addPromotion") 
public class AddPromotionServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest request,HttpServletResponse response) 
			throws ServletException, IOException {
		
		//set up
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String promoCode = "";
		promoCode = request.getParameter("promo_code");
		int percentage = Integer.parseInt(request.getParameter("quantity"));
		
		Date startDate = null;
		try {
			startDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("start_date"));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		
		Date endDate = null;
		try {
			endDate = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("end_date"));
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		
		boolean exists = false;
		
		String query = "select promo_code from promotion";
		try {
        	Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
			Statement st = con.createStatement();
			ResultSet rs =st.executeQuery(query);
			
			while(rs.next() && !exists) {
				if (rs.getString(1).equalsIgnoreCase(promoCode)) {
					exists = true;
				}
			}
			
			if(exists) {
				out.println("<script>");
	            out.println("alert('Promo code already exists, Try again');");
	            out.println("</script>");
	            
	            RequestDispatcher rd = request.getRequestDispatcher("managePromotions.html");
				rd.include(request, response);
			}
			
			else if(percentage < 1 || percentage > 100){
				out.println("<script>");
	            out.println("alert('Invalid percentage, Try again');");
	            out.println("</script>");
	            
	            RequestDispatcher rd = request.getRequestDispatcher("managePromotions.html");
				rd.include(request, response);
			}
			
			else if(startDate.compareTo(endDate) > 0)
			{
				out.println("<script>");
	            out.println("alert('Start Date is after End Date, Try again');");
	            out.println("</script>");
	            
	            RequestDispatcher rd = request.getRequestDispatcher("managePromotions.html");
				rd.include(request, response);
			}
			
			else {
				rs = st.executeQuery("SELECT max(promotion_id) FROM promotion;");
				rs.next();
				int promoID = rs.getInt(1) + 1;
				java.sql.Date sqlStartDate = new java.sql.Date(startDate.getTime());
				java.sql.Date sqlEndDate = new java.sql.Date(endDate.getTime());
				
				PreparedStatement ps = con.prepareStatement("insert into promotion (promotion_id, promo_code, percentage, start_date, end_date, delivered)"
								+ "	values ( ?, ?, ?, ?, ?,'Y');");
				ps.setInt(1,promoID);
				ps.setString(2, promoCode);
				ps.setInt(3, percentage);
				ps.setDate(4, sqlStartDate);
				ps.setDate(5, sqlEndDate);
				int i = ps.executeUpdate();

				out.println("<script>");
	            out.println("alert('Added Promotion');");
	            out.println("</script>");
	            
	            RequestDispatcher rd = request.getRequestDispatcher("managePromotions.html");
				rd.include(request, response);
	            
	            System.out.println(promoID + " " + promoCode + " " + percentage + " " + sqlStartDate.toString() + " " + sqlEndDate.toString());
	            
				
			}
				
		}catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
