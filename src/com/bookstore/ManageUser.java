package com.bookstore;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ManageUser
 */
@WebServlet("/manageUserServlet")
public class ManageUser extends HttpServlet {


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userID = request.getParameter("userID");
        String changeType = request.getParameter("userType");
        String query = "SELECT * FROM bookstore.user WHERE user_id='" + userID + "';";
        String query1 = "";
        PrintWriter out = response.getWriter();
        Boolean flag = false;
        String customerStatus = "";
        String userStatus = "";
        try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
			Statement st = con.createStatement();
			ResultSet rs =st.executeQuery(query);
			Statement st1 = con.createStatement();
			
			if(rs.next()) {
				//System.out.println(rs.getString(1));
				flag = true;
				userStatus = rs.getString(5);
			} else {
				out.println("<script>");
	            out.println("alert('User ID is incorrect, Try again');");
	            out.println("</script>");
	        	
			}
			
        
        
	        if (flag) {
	        	if (changeType.equals("s")) {
	        		if (userStatus.equals("C")) {
	        			query1 = "Update bookstore.customer set status = 'S' where user_id='" + userID +"';";
	        			st1.executeUpdate(query1);
	        			
	        			
	        		} else {
	        			out.println("<script>");
	    	            out.println("alert('Only Customer can be suspended or unsuspended, Try again');");
	    	            out.println("</script>");
	    	        	
	        		}
	        	} else if (changeType.equals("us")) {
	        		
	        		if (userStatus.equals("C")) {
	        			query1 = "Update bookstore.customer set status = 'A' where user_id='" + userID +"';";
	        			st1.executeUpdate(query1);
	        			
	        			
	        		} else {
	        			out.println("<script>");
	    	            out.println("alert('Only Customer can be suspended or unsuspended, Try again');");
	    	            out.println("</script>");
	    	        	
	        		}
	        		
	        		
	        	} else if (changeType.equals("a")) {
	        		
	        		query1 = "update bookstore.user set User_type = 'A' where user_id = '" + userID + "';";
	        		st1.executeUpdate(query1);
	        		
	        	} else if (changeType.equals("ua")) {
	        		query1 = "update bookstore.user set User_type = 'C' where user_id = '" + userID + "';";
	        		st1.executeUpdate(query1);
	        		
	        	} else if (changeType.equals("e")) {
	        		query1 = "update bookstore.user set User_type = 'E' where user_id = '" + userID + "';";
	        		st1.executeUpdate(query1);
	        	}
	        }
	        
	        RequestDispatcher rd = request.getRequestDispatcher("manageUsers.jsp");
            rd.include(request, response);
        
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
  
	}

}
