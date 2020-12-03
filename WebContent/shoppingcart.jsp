<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>BookStore | Shopping Cart</title>

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
          <li><a href="shoppingcart.jsp" class="current">Shopping Cart</a></li>
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
        if (cookie == null) {
        	window.location = "login.html";
        } else {
          document.getElementById('session').innerHTML = cookie;
          document.getElementById('log').innerHTML = "Log Out";  
          document.getElementById("register").innerHTML = "";
        }
  </script>

    <section id="main">
      <div class="container">
      	<h1 class="page-title">Shopping Cart</h1>
      	
      	<% 
      	Class.forName("com.mysql.jdbc.Driver");
    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
    	//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore","root","lkjhlkjh");
    	Statement st = con.createStatement();
    	ResultSet rs = st.executeQuery("select * from cart, book, author, inventory "+
    	"where cart.book_id = book.book_id and cart.book_id = author.book_id and cart.book_id = inventory.book_id;");
    	
    	while (rs.next()) {
      	%>
      	<div class="item">
      		
      			
      			<div class="cover">
      				<img src="./img/books/default.jpg">
      			</div>
      			<div class="description">
            		<p><%=rs.getString(7) + " by " + rs.getString(14) + ", " + rs.getString(13)%></p>
          		</div>
          		<form action="UpdateQuantityInCart" method="post">
          		<div class="quantity">
              		<input type="number" min="1" step="1" value="<%=rs.getString(3) %>" name="quantity" oninput="validity.valid||(value='');" required><br>
              		<input type="hidden" name="bookID" value="<%=rs.getString(2)%>">
              		<input type="submit" value="Update Quantity" name="update">

          		</div>
          		</form>
          		<div class="price">
		            <p><%= "$" + rs.getString(17) + " each" %></p>
		        </div>
	          	<form action="DeleteFromCart" method="post">
	          	<div class="submit">
	          		<input type="hidden" name="bookID" value="<%=rs.getString(2)%>">
	        		<input type="submit" value="Delete" name="delete">
	          	
	          	</div>
      		</form>
      	</div>
      	<%} %>
      </div>

       <div class="container" >
        <form action="./checkout1.html">
          <button type="submit" class="button_2" style="float: right;">Continue to Checkout</button>
        </form>
      </div>
    </section>

<footer>
  <p>CSCI4050 Team 9, Copyright &copy; 2020</p>
</footer>
</body>

</html>
