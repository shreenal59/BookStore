<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<meta name="description" content="Online Bookstore">
<meta name="keywords"
content="bookstore, shopping, ecommerce, books, shop">
<meta name="author" content="Shreenal Patel">
<title>BookStore | Order Confirmation</title>
<link rel="stylesheet" href="./css/stylesheet.css">
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
          <li class="current"><a href="index.html">Home</a></li>
          <li><a href="login.html" id = "log">Login</a></li>
          <li><a href="register.jsp" id = "register">Register</a></li>
          <li><a href="shoppingcart.html">Shopping Cart</a></li>
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

<section id="main">
    <div class="container" style="min-height: 370px;">
        <h1 class="page-title">My Orders</h1>
    
        <% 
      		Class.forName("com.mysql.jdbc.Driver");
    		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
    		Statement st = con.createStatement();
    		Cookie cookie = null;
    		Cookie[] cookies = null;
    		cookies = request.getCookies();
    		int cusID = 0;
    		String user="";
    		
    		for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("uname")) {
					user = cookies[i].getValue();
					break;
				}
			}
    		
    		PreparedStatement stmt = con.prepareStatement(
					"select customer_id from customer where user_id = '"+user+"'");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				cusID = rs.getInt(1);
			}
    		rs = st.executeQuery("select * from bookstore.order,bookstore.order_item,Book,Inventory, author" + 
			" where bookstore.order.customer_id='" + cusID + "' and bookstore.order.order_id=bookstore.order_item.order_id" +
    		" and bookstore.order_item.book_id=Book.book_id and bookstore.order_item.book_id=bookstore.author.book_id" + 
    		" and bookstore.order_item.book_id=bookstore.inventory.book_id;");
    		
    		while(rs.next()){
    	%>
    		<div class="box">
			<div class="cover">
      				<img src="./img/books/rs.getString(19)">
      		</div>
      		
      		<div class="description">
            	<p><%="Item Ordered: " + rs.getString(15) + " " + rs.getString(16) + " Edition by " 
      			+ rs.getString(26) + ", " + rs.getString(25)%></p>
           	</div>	
          	
          	<div class="orderNum">
          		<p><%="Order Number: " + rs.getInt(1)%></p>
         	</div>
          	<div class="orderDates">
          		<p1><%="Ordered On: " +  rs.getDate(5) + ", Order Shipped On: " +  rs.getDate(6)%></p1>
          	</div>
          	
          	<div class="price">
          		<p2><%="Item Quantity: " + rs.getInt(11) + ", Item Price: " + rs.getString(22)%></p2>
          	</div>
          	
          	<form action="?">
            <div class="button">  
                <select name="rate" id="rate" class="button_3" style="margin-top: 16px;">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
            </div>
             <div class="button">
                <p><button class="button_3">Rate</button></p>    
            </div>
       		</form>
          	
          	<div class="button">
            <form action="AddToCart" method = "post">  
            	<input type="hidden" name="bookID" value="<%=rs.getString(10)%>">
            	<input type="hidden" step="1" value="<%=rs.getString(11) %>" 
            	name="quantity" oninput="validity.valid||(value='');" required><br>
                <p><button class="button_3">Reorder</button></p>
            </form>
			</div>
		
        	
        	<div class="button">
            <form action="./return.html">
                <p><button class="button_3">Return</button></p>
            </form>
        	</div>
        </div>
        <hr>
		<%} %>
    
    </div>

    
</section>

<footer>
<p>CSCI4030 Team X, Copyright &copy; 2020</p>
</footer>
</body>

</html>
