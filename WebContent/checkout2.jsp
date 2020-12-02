<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.text.*, java.util.Date" %>
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
          <li><a href="shoppingcart.html" class="current" >Shopping Cart</a></li>
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
        	document.window = "login.html";
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
	  
	  String name = fname + " " + lname;
	  
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
	  
	  String query5 = "SELECT cast(aes_decrypt(card_number, '4050') as char), card_id FROM bookstore.payment_card WHERE customer_id = '" + cusId + "';";
	  Statement st5 = con.createStatement();
	  ResultSet rs5 =st5.executeQuery(query5);
	  String cardNum = "";
	  String cardId = "";
	  while(rs5.next()){
		  cardNum = rs5.getString(1);
		  cardId = rs5.getString(2);
	  }
	  String cardEnd = cardNum.substring(cardNum.length() - 4);
	  
	  String query6 = "SELECT * FROM bookstore.cart JOIN bookstore.inventory USING (book_id) WHERE customer_id = '"+cusId+"';";
	  Statement st6 = con.createStatement();
	  ResultSet rs6 =st6.executeQuery(query6);
	  String empty="true";
	  Double total = 0.0;
	  int quantity = 1;
	  while(rs6.next()){
		  quantity = rs6.getInt(3);
		  total = total + quantity*(rs6.getDouble(5));
	  }
	  
	  double tax = 0.05 * total;
	  double orderTotal = total + tax; 
	  
	  DecimalFormat df = new DecimalFormat("#.##");      
	  tax = Double.valueOf(df.format(tax));
	  orderTotal = Double.valueOf(df.format(orderTotal));
	  total = Double.valueOf(df.format(total));
	  
	  String promo = session.getAttribute("promo").toString();
	  session.removeAttribute("promo");
	  int discount = 0;
	  String promoId = "";
	  Date startDate = null;
	  Date endDate = null;
	  long millis=System.currentTimeMillis();
	  Date today = new java.sql.Date(millis);
	  
	  if(promo != null && !promo.trim().isEmpty()){
		  String query7 = "SELECT * FROM bookstore.promotion WHERE promo_code = '"+promo+"' AND delivered = 'Y';";
		  Statement st7 = con.createStatement();
		  ResultSet rs7 =st7.executeQuery(query7);
		  
		  while(rs7.next()){
			discount = rs7.getInt(3);  
			promoId = rs7.getString(1);
			startDate = rs7.getDate(4);
			endDate = rs7.getDate(5);
		  }
		  if(discount == 0) { 
			  promo = "";
			%>
			<script>
				alert("Promo code is Invalid");
		  	</script>		  
			<% 
		  } else if(today.compareTo(endDate) > 0 || startDate.compareTo(today) > 0) {
			  %>
				<script>
					alert("Promo code is Exipired or haven't started");
			  	</script>		  
			  <% 			 
			 discount = 0;
			 promoId = "";
		  }
	  }
	  
	  double deduction = discount * orderTotal * 0.01;
	  double finalPrice = orderTotal - deduction;
	  deduction = Double.valueOf(df.format(deduction));
	  finalPrice = Double.valueOf(df.format(finalPrice));
  
  	%>

  <section id="main">
    
    <div class="container" >
      <div id="main_con">
      <h1 class="page-title">confirmation </h1><br>
      <div>
        <div class="twoboxes">
          <div class="box">
        <h4>Billing Address</h4>
        <p><%= name %></p>
        <p><%= streetB %></p>
        <p><%= cityB %>, <%= stateB %> <%= zipB %></p>
        <br>
      </div>
      <div class="box">
        <h4>Shipping Address</h4>
        <p><%= name %></p>
        <p><%= streetS %></p>
        <p><%= cityS %>, <%= stateS %> <%= zipS %></p>
        <br>
      </div>
      </div>
        <h4>Payment Info</h4>
        <p>Card Ending  in <%= cardEnd %></p>
        <br>
        <div class="twoboxes">
          <div class="box">
        <form action="./checkout1.jsp">
          <button type="submit" class="button_2">Edit Personal Info</button>
        </form>
      </div>
      <div class="box">
        <form action="checkout2" method="post">
          <input type="hidden" name="uname" value="<%= uname %>">
          <input type="hidden" name="cusId" value="<%= cusId %>">
          <input type="hidden" name="amount" value="<%= finalPrice  %>">
          <input type="hidden" name="promoId" value="<%= promoId %>">
          <input type="hidden" name="cardId" value="<%= cardId %>">
          <input type="hidden" name="name" value="<%= name %>">
          <button type="submit" class="button_2">Checkout</button>
        </form>
      </div>
      </div>
      </div>
      
    </div>

    <div id="side_bar" class="dark">
      <h3 style="margin-left: 3em;">Order Summary</h3>
      <label for="cost">Original Price:</label>$<%= total %> <br>
        <label for="tax">Estimated Sales Tax:</label>$<%= tax %> <br>
        <label for="cvc">Order Total:</label>$<%= orderTotal %> <br>
        <label for="cvc">Discount:</label>$<%= deduction %> <br>
        <label for="cvc">Final Total:</label>$<%= finalPrice %> <br>
        
      <br>
      <form action="./shoppingcart.jsp">
        <button type="submit" class="button_2">Edit or View Cart</button>
      </form>
    </div>

  </div>
    
  </section>

  <footer>
    <p>CSCI4050 Team 9, Copyright &copy; 2020</p>
  </footer>
</body>

</html>