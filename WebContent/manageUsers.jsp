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
  <title>Admin | Users</title>
  <link rel="stylesheet" href="./css/adminstylesheet.css">
  <script src="scripts.js"></script>
</head>

<body>
  <%
  
    String query = "SELECT user_id, first_name, last_name, User_Type FROM bookstore.user;";
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
	Statement st = con.createStatement();
	ResultSet rs =st.executeQuery(query);
	Statement st2 = con.createStatement();
  
  
  %>
  
  <script>
        
        var userType = getCookie("userType");
        if(userType == "A") {
        	
        } else {
        	alert ('Only Admin can access Manage Users');
        	window.location = "admin.jsp";
        }
        
    </script>
    
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
    <h2>Manage Users</h2>
    <hr>
    <h4>Users</h4>
    <div class="tables" id="userTable">
      <table>
        <tr>
          <th>User ID</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>User Type</th>
          <th>Customer Status</th>
        </tr>
        <% while(rs.next()) { 
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
      
      <p>(User Type: A = Admin; E = Employee; C = Customer)</p>
      <p>(Customer Status: A = Active; I = Inactive; S = Suspended)</p>
      
    </div>
    <hr>
    <div class="admintool" id="addBook">
      <label for="manage users" class="input-label"> <b>Manage Users</b></label>
      <br> <!--Book Table-->
      <form action="manageUserServlet" method="post">
        <input type="text" class="userid" name="userID" placeholder="User ID" required>
        <select name="userType" id="userType">
          <option value="select" disabled>Select User Action</option>
          <option value="s">Suspend a Customer</option>
          <option value="us">Unsuspend a Customer</option>
          <option value="a">Promote a User to Admin</option>
          <option value="ua">Depromote Admin/Employee to User</option>
          <option value="e">Change User type to Employee</option>
          
        </select>

        <button type="submit" class="change">Change User Status</button>
      </form>
      <br>
    </div>

  </div>


</body>

</html>