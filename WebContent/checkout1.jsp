<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.text.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <meta name="description" content="Online Bookstore">
  <meta name="keywords"
    content="bookstore, shopping, ecommerce, books, shop">
  <meta name="author" content="Shreenal Patel">
  <title>BookStore | Checkout</title>
  <link rel="stylesheet" href="./css/checkoutstyle.css">
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
          <li><a href="shoppingcart.html" class="current">Shopping Cart</a></li>
          <li><a href="profile.html" id="session">Profile</a></li>
          <li><input type="text" placeholder="Search..."></li>
          <li><button type="submit" class="search_button" onclick="window.location.href='search.html';">Search</button>
          </li>
        </ul>
      </nav>
    </div>
  </header>
  
  <script>
        var cookie = getCookie("uname");
        if (cookie == null) {
        	window.location = "login.html";
        } else {
          document.getElementById('session').innerHTML = cookie;
          document.getElementById('log').innerHTML = "Log Out";
          document.getElementById("register").innerHTML = "";
        }
  </script>
  
  <%
	  Cookie cookie = null;
	  Cookie[] cookies = null;
	  String uname = "";
	  
	  // Get an array of Cookies associated with the this domain
	  cookies = request.getCookies();
	  
	  if( cookies != null ) {
	     for (int i = 0; i < cookies.length; i++) {
	        cookie = cookies[i];
	        if(cookie.getName().equals("uname")) {
	        	uname = cookie.getValue();
	        }
	     }
	  }
	  Class.forName("com.mysql.jdbc.Driver");
	  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
	  String query1 = "SELECT first_name, last_name, customer_id FROM bookstore.user JOIN bookstore.customer USING (user_id) WHERE user_id ='" + uname + "';";
	  Statement st1 = con.createStatement();
	  ResultSet rs1 =st1.executeQuery(query1);
	  String fname = "";
	  String lname = "";
	  String cusId = "";
	  while (rs1.next()){
		  fname = rs1.getString(1);
		  lname = rs1.getString(2);
		  cusId = rs1.getString(3);
	  }
	  
	  String query2 = "SELECT * FROM bookstore.address WHERE customer_id='" + cusId + "' AND address_type='S';";
	  Statement st2 = con.createStatement();
	  ResultSet rs2 =st2.executeQuery(query2);
	  String streetS = "";
	  String cityS = "";
	  String stateS = "";
	  String zipS = "";
	  while (rs2.next()) {
		  streetS = rs2.getString(3);
		  cityS = rs2.getString(4);
		  stateS = rs2.getString(5);
		  zipS = rs2.getString(6);
	  }
	  
	  String query3 = "SELECT * FROM bookstore.address WHERE customer_id='" + cusId + "' AND address_type='B';";
	  Statement st3 = con.createStatement();
	  ResultSet rs3 =st3.executeQuery(query3);
	  String streetB = "";
	  String cityB = "";
	  String stateB = "";
	  String zipB = "";
	  while (rs3.next()) {
		  streetB = rs3.getString(3);
		  cityB = rs3.getString(4);
		  stateB = rs3.getString(5);
		  zipB = rs3.getString(6);
	  }
	  
	  String query4 = "SELECT phone_number FROM bookstore.customer WHERE customer_id = '"+ cusId +"';";
	  Statement st4 = con.createStatement();
	  ResultSet rs4 =st4.executeQuery(query4);
	  String phone = "";
	  while(rs4.next()){
		  phone = rs4.getString(1);
	  }
	  
	  String query5 = "SELECT cast(aes_decrypt(card_number, '4050') as char), expiration_date, card_type FROM bookstore.payment_card WHERE customer_id = '" + cusId + "';";
	  Statement st5 = con.createStatement();
	  ResultSet rs5 =st5.executeQuery(query5);
	  String cardNum = "";
	  String exDate = "";
	  String cardType = "";
	  while(rs5.next()){
		  cardNum = rs5.getString(1);
		  exDate = rs5.getString(2);
		  cardType = rs5.getString(3);
	  }
	  
	  if(cardType.equals("A")) {
		  cardType = "American Express";
	  } else if(cardType.equals("D")) {
		  cardType = "Discover";
	  } else if(cardType.equals("M")) {
		  cardType = "Mastercard";
	  } else if(cardType.equals("V")) {
		  cardType = "Visa";
	  }
	  
	  
	  
	  
	  	
  
  %>

  

  <section id="main">
    
    <div class="container" >
        <div id="main_con">
        <h1 class="page-title">Personal Information</h1><br>
        
        <form action="checkout2.jsp" id="address">
          <fieldset>
            <legend><h3>Billing Address</h3></legend>
            <label for="f_name">First Name: </label>
            <input type="text" name="f_name" placeholder="Enter First Name here" value="<%= fname %>" required><br><br>
            <label for="l_name">Last Name: </label>
            <input type="text" name="l_name" placeholder="Enter Last Name here" value="<%= lname %>" required><br><br>
            <label for="address">Street Address: </label>
            <input type="text" name="streetB" placeholder="Enter Street Address here" value="<%= streetB %>" required><br><br>
            <label for="city">City: </label>
            <input type="text" name="cityB" placeholder="Enter City here" value="<%= cityB %>" required><br><br>
            <label for="zip">Zip Code: </label>
            <input type="text" name="zipB" placeholder="Enter Zip Code here" value="<%= zipB %>" required><br><br>
            <label for="state">State: </label>
            <input type="text" name="stateB" placeholder="Enter State Name here" value="<%= stateS %>" required><br><br>
            <label for="number">Phone Number: </label>
            <input type="text" name="number" placeholder="Enter Phone Number here" value="<%= phone %>"><br><br>
          </fieldset>
            <br>
          
          <fieldset>
            <legend><h3>Shipping Address</h3></legend>
            <label for="f_name">First Name: </label>
            <input type="text" name="f_name" placeholder="Enter First Name here" value="<%= fname %>" required><br><br>
            <label for="l_name">Last Name: </label>
            <input type="text" name="l_name" placeholder="Enter Last Name here" value="<%= lname %>" required><br><br>
            <label for="address">Street Address: </label>
            <input type="text" name="streetS" placeholder="Enter Street Address here" value="<%= streetS %>" required><br><br>
            <label for="city">City: </label>
            <input type="text" name="cityS" placeholder="Enter City here" value="<%= cityS %>" required><br><br>
            <label for="zip">Zip Code: </label>
            <input type="text" name="zipS" placeholder="Enter Zip Code here" value="<%= zipS %>" required><br><br>
            <label for="state">State: </label>
            <input type="text" name="stateS" placeholder="Enter State Name here" value="<%= stateS %>" required><br><br>
            <label for="number">Phone Number: </label>
            <input type="text" name="number" placeholder="Enter Phone Number here" value="<%= phone %>"><br><br>
          </fieldset>
          <br>

          <fieldset>
            <legend><h3>Payment Information</h3></legend>
            <label for="card">Credit Card No:</label>
            <input type="text" name="cardNo" placeholder="Enter 16 Digit No" value="<%= cardNum %>" required><br><br>
            <label for="Exp_Date">Exp Date:</label>
            <input type="date" name="Exp_date" value="<%= exDate %>" required><br><br>
            <label for="cardTypr">CardType:</label>
            <select name="cardType" id="cardType">
              <option value="A">American Express</option>
              <option value="D">Discover</option>
              <option value="M">Mastercard</option>
              <option value="V">Visa</option>
            </select>
          </fieldset>
          <br><br>

          <button type="submit" class="button_2">Continue to Checkout</button>
        </form>
      </div>

      <div id="side_bar" class="dark">
        <h3 style="margin-left: 3em;">Order Summary</h3>
        <label for="cost">Original Price:</label>$32.97 <br>
        <label for="tax">Estimated Sales Tax:</label>$2.3 <br>
        <label for="cvc">Order Total:</label>$35.27 <br>
        <br>
        <form action="./shoppingcart.html">
          <button type="submit" class="button_2">Edit or View Cart</button>
        </form>
      </div>

    </div>
    
  </section>

  <script>
    function setSelectedIndex(select, value) {
      for ( var i = 0; i < select.options.length; i++ ) {
        if ( select.options[i].text == value ) {
            select.options[i].selected = true;
            return;
        }
      }
    }

    setSelectedIndex(document.getElementById('cardType'), "<%= cardType %>");
  </script>

  <footer>
    <p>CSCI4050 Team 9, Copyright &copy; 2020</p>
  </footer>
</body>

</html>