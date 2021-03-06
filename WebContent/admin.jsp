<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <meta name="description" content="Online Bookstore">
  <meta name="keywords" content="bookstore, shopping, ecommerce, books, shop">
  <meta name="author" content="Avery Davis">
  <title>Admin | Dashboard</title>
  <link rel="stylesheet" href="./css/adminstylesheet.css">
  <script src="scritps.js"></script>
</head>

<body>

  <%
  	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
    String userQuery = "SELECT user_id, first_name, last_name, User_Type FROM bookstore.user;";
	Statement st = con.createStatement();
	Statement st2 = con.createStatement();
	
  %>
  <header>
    <div class="container">
      <div id="branding">
        <h1><span class="highlight">BookStore</span> Online Admin Portal</h1>
      </div>
    </div>
  </header>

  <div id="mySidenav" class="sidenav">
    <a href="admin.jsp">Dashboard</a>
    <a href="managebooks.jsp">Manage Books</a>
    <a href="managePromotions.jsp">Manage Promotions</a>
    <a href="manageUsers.jsp">Manage Users</a>
    <a href="index.html">Logout</a>
  </div>


  <!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
  <div id="main">
    <h2>Admin Dashboard</h2>
    <hr>
    <h4>Recently Sold Books</h4>
    <div class="tables" id="bookTable">
      <div style="overflow-x:auto;">
        <!--
        <table>
          <th>Serial #</th>
          <th>Book Title</th>
          <th>Author</th>
          <th>MSRP</th>
          <th>In Stock</th>
          <th>Purchased</th>
          <th>Returned</th>
          </tr>
          <tr>
            <td>AR001</td>
            <td>The Fountainhead</td>
            <td>Ayn Rand</td>
            <td>$12.00</td>
            <td>100</td>
            <td>50</td>
            <td>1</td>
          </tr>
          <tr>
            <td>HM001</td>
            <td>Norwegian Wood</td>
            <td>Haruki Murakami</td>
            <td>$14.00</td>
            <td>100</td>
            <td>94</td>
            <td>8</td>
          </tr>
          <tr>
            <td>WG001</td>
            <td>Neuromancer</td>
            <td>William Gibson</td>
            <td>$14.00</td>
            <td>100</td>
            <td>67</td>
            <td>3</td>
          </tr>
          <tr>
            <td>HM002</td>
            <td>Moby Dick</td>
            <td>Herman Melville</td>
            <td>$12.00</td>
            <td>100</td>
            <td>30</td>
            <td>2</td>
        </table>
        -->
      </div>
    </div>
    <div class="tables" id="promotionsTable">
      <h4>Active Promotions</h4>
      <div style="overflow-x:auto;">
        <!--
        <table>
          <tr>
            <th>Title</th>
            <th>Books Discounted</th>
            <th>Discount</th>
            <th>Promo Code</th>
            <th>Ending</th>
          </tr>
          <tr>
            <td>Sci-Fi Discount</td>
            <td>WG001</td>
            <td>15%</td>
            <td>XXX1-23XX-X321</td>
            <td>01/01/2021</td>
          </tr>
        </table>
      -->
<%
	String query = "SELECT promo_code, percentage,start_date,end_date FROM promotion;";
	ResultSet rs = st.executeQuery(query);
%>
	<table>
  	<tr>
  		<th>Promo Code</th>
  		<th>Percentage</th>
  		<th>Start Date</th>
  		<th>End Date</th>
  		<% while(rs.next()) { 
    	
   		 %>
   		 <tr>
   		 	<td> <%= rs.getString(1) %> </td>
   		 	<td> <%= rs.getInt(2) %> </td>
   		 	<td> <%= rs.getDate(3) %> </td>
   		 	<td> <%= rs.getDate(4) %> </td>
   		 </tr>
   		 <% 
			 }%>
      </div>
    </div>
    
    <div class="tables" id="usersTable">
      <h4>Users</h4>
      <div style="overflow-x:auto;">
      	<table>
        <tr>
          <th>User ID</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>User Type</th>
          <th>Customer Status</th>
        </tr>
        <% 
    	rs =st.executeQuery(userQuery);
        while(rs.next()) { 
        	String userID = rs.getString(1);
        %>
        <tr>
          <td> <%= userID %> </td>
          <td> <%= rs.getString(2) %> </td>
          <td> <%= rs.getString(3) %> </td>
          <% String userType = rs.getString(4); %>
          <td> <%= userType %> </td>
          <% 
          	String query2 = "SELECT status FROM bookstore.customer WHERE user_id='" + userID + "';";
          	if (userType.equals("C")) {
          		ResultSet rs2 = st2.executeQuery(query2);
          		rs2.next();
          		String status = rs2.getString(1);
          	%>
          	<td> <%= status %> </td>
          	<% 
 				
          	} else {
          	%>
          	<td> </td>
          	<% } %>
        </tr>
		<% } %>
      </table>
        <!--
        <table>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Verified</th>
            <th>Date Created</th>
          </tr>
          <tr>
            <td>Avery</td>
            <td>Davis</td>
            <td>adavis@mail.com</td>
            <td>Yes</td>
            <td>9/01/2001</td>
          </tr>
          <tr>
            <td>Simon</td>
            <td>Gallup</td>
            <td>sgallup@mail.com</td>
            <td>No</td>
            <td>8/26/2020</td>
          </tr>
          <tr>
            <td>Lol</td>
            <td>Tolhurst</td>
            <td>ltolhurst@mail.com</td>
            <td>No</td>
            <td>8/25/2020</td>
          </tr>
          <tr>
            <td>Jim</td>
            <td>Gunthrie</td>
            <td>jgunthrie@mail.com</td>
            <td>Yes</td>
            <td>8/21/2020</td>
          </tr>
          <tr>
            <td>Kate</td>
            <td>Bush</td>
            <td>kbush@mail.com</td>
            <td>Yes</td>
            <td>8/12/2020</td>
          </tr>
        </table>
      -->
      </div>
    </div>
  </div>
</body>


</html>
