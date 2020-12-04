<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <meta name="description" content="Online Bookstore">
  <meta name="keywords"
    content="bookstore, shopping, ecommerce, books, shop">
  <meta name="author" content="Avery Davis">
  <title>BookStore | Home</title>
	<link rel="stylesheet" href="./css/stylesheet.css">
  <script src="scripts.js"></script>
</head>

<body>
  <header>
    <div class="container">
      <div id="branding">
        <h1><span class="highlight">BookStore</span> Online</h1>
      </div>
  	  <nav>
        <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="login.html" id = "log">Login</a></li>
          <li><a href="register.jsp" id = "register">Register</a></li>
          <li><a href="shoppingcart.jsp">Shopping Cart</a></li>
          <li><a href="profile.html" id="session">Profile</a></li>
          <li><form action="search.jsp">
          	<input type="text" name="search" placeholder="Search...">
          	<label for="order">Sort: </label>
          	<select name="order" id="order">
        		<option value="book.title">Title</option>
        		<option value="author.last_name">Author</option>
        		<option value="book.isbn">ISBN</option>
        		<option value="book.category">Category</option>
        	</select>
          	<button type="submit" class="search_button" >Search</button>
          </form></li>
        </ul>
      </nav>
    </div>
  </header>
  
  <script>
        var cookie = getCookie("uname");
        if (cookie === null ) {
        	window.location = "login.html";
        } else {
          document.getElementById('session').innerHTML = cookie;
          document.getElementById('log').innerHTML = "Log Out";
          document.getElementById("register").innerHTML = "";
          
        }
  </script>

  <section id="boxes">
    <section id="sec-reg-log">
        <div class="container">
          <main id="main-reg-log">
          <form action="EditProfile" method="post">
          <article id="art-reg-log">
            <h1 class="page-title">Edit Profile - You must be logged in to do so</h1>    
            <hr>
            <%
        		Class.forName("com.mysql.jdbc.Driver");
        		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
        
            	Cookie cookie = null;
            	Cookie[] cookies= null;
            	cookies = request.getCookies();
            	cookie = cookies[0];
            	String uname = "";
         		uname = cookie.getValue();
            	String query = "SELECT first_name,last_name FROM user WHERE user_id='" + uname + "'";
            	Statement st = con.createStatement();
            	ResultSet rs = st.executeQuery(query);
            	
            	String fName = "";
            	String lName = "";
            	while(rs.next()){
            		fName = rs.getString(1);
            		lName = rs.getString(2);
            	}
            %>
            <label for="name" class="reg-label"> <b>Name</b></label>
            <input type="text" class="name" placeholder=<%=fName%> name="name-first" id="name-first" required>
            <input type="text" class="name" placeholder=<%=lName %> name="name-last" id="name-last" required>

			<%
			int customerID = 0;
			rs = st.executeQuery("SELECT customer_id, user_id FROM bookstore.customer;");
        	while(rs.next()) {
        		if(rs.getString(2).equals(uname)) {
        			customerID = rs.getInt(1);
        			break;
        		}
        	}
        	rs = st.executeQuery("SELECT phone_number FROM bookstore.customer WHERE customer_id='" + customerID + "';");
        	String phoneNumber="";
        	while(rs.next()){
        		phoneNumber=rs.getString(1);
        	}
			%>
            <label for="phone" class="reg-label"><b>Phone Number</b></label>
            <input type="text" placeholder=<%=phoneNumber %> name="number" id="number" required>
    
            <label for="psw" class="reg-label"><b>Change Password</b></label>
            <input type="password" placeholder="Enter Existing Password" name="psw" id="psw" required>
    
            <label for="psw-repeat" class="reg-label"><b>New Password</b></label>
            <input type="password" placeholder="New Password" name="psw-repeat" id="psw-repeat" required>
            <input type="password" placeholder="Repeat New Password" name="psw-repeat" id="psw-repeat" required>

			<%
			rs =st.executeQuery("SELECT street,city,state,zip FROM bookstore.Address WHERE customer_id='" + customerID + "';");
            String street = "";
            String city = "";
            String state="";
            int zip = 0;
            while(rs.next()){
            	street = rs.getString(1);
            	city = rs.getString(2);
            	state = rs.getString(3);
            	zip = rs.getInt(4);
            }
			%>
            <label for="street" class="reg-label"><b>Street Address</b></label>
            <input type="text" placeholder=<%=street %> name="street" id="street" required>

			<label for="city" class="reg-label"><b>City</b></label>
            <input type="text" placeholder=<%=city %> name="city" id="city" required>
            
            <label for="state" class="reg-label"><b>State</b></label>
            <input type="text" placeholder=<%=state %> name="state" id="state" required>
            
            <label for="zip" class="reg-label"><b>Zip Code</b></label>
            <input type="number" placeholder=<%=zip %> name="zip" id="zip" required>
            
            <label for="card-number" class="reg-label"><b>Card Number</b></label>
            <input type="text" placeholder="Enter 16-Digit Card Number" name="card-number" id="card-number" required>
            
            <label for="expiration-date" class="reg-label"><b>Card Expiration Date</b></label>
            <input type="date" placeholder="Enter Exipration Date" name="expiration-date" id="expiration-date" required>
            
            <input type="checkbox" id="subscription" name="subscription" value ="subscription">
            <label for="subscription"> Opt in for subscription</label>
            
            <hr>                
            <button type="submit" class="submitbtn" >Submit Changes</button>
           </form>
          </article>
        </main>
    
        </div>
      </section>
  </section>
  <footer>
    <p>CSCI4050 Team 9, Copyright &copy; 2020</p>
  </footer>
</body>

</html>
