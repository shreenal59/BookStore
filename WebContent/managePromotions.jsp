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
  <title>Admin | Promotions</title>
  <link rel="stylesheet" href="./css/adminstylesheet.css">
  <script src="./js/scritps.js"></script>
</head>

<body>

<%
	String query = "SELECT promo_code, percentage,start_date,end_date FROM promotion;";
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
	Statement st = con.createStatement();
	ResultSet rs =st.executeQuery(query);
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
    <a href="admin.html">Dashboard</a>
    <a href="managebooks.html">Manage Books</a>
    <a href="managePromotions.html">Manage Promotions</a>
    <a href="manageUsers.html">Manage Users</a>
    <a href="index.html">Logout</a>
  </div>


  <!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
  <div id="main">
    <h2>Manage Promotions</h2>
    <hr>
    <h4>Promotion Catalog</h4>
    <div class="tables" id="promotionsTable">
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
      	</tr>
      </table>
    </div>
    <hr>
    <div class="admintool" id="addPromotion">
      <label for="newPromotion" class="input-label"> <b>Add New Promotion</b></label>
      <form action="addPromotion" method="post">
      <br> <!--Promotion Table-->
      <input type="text" class="promo_code" name="promo_code" placeholder="Promo Code">
      <br>
      <label for="percentage">Discount Rate in %:</label>
      <input type="number" id="quantity" name="quantity" min="1" max="100">
      <br>
      <label for="start_date">Start Date:</label>
      <input type="date" name="start_date">
      <br>
      <label for="end_date">End Date:</label>
      <input type="date" name="end_date">
      <br>
      <button type="submit" class="Add">Add and Send New Promotion</button>
      </form>
    </div>
    <hr>
    

  </div>
  
</body>

</html>