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
<meta name="author" content="Avery Davis, Shreenal Patel">
<title>BookStore | Search</title>

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
          <li><a href="shoppingcart.html">Shopping Cart</a></li>
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
        	
        } else {
          document.getElementById('session').innerHTML = cookie;
          document.getElementById('log').innerHTML = "Log Out";
          document.getElementById("register").innerHTML = "";
        }
  </script>

    <section id="main">
      
      <div class="container">
        <h1 class="page-title">Search Results</h1>
        <h3 class="Results">Results found:</h3>

        <% 
	        String text = request.getParameter("search");
	    	String text2 = request.getParameter("order");
	    	String query = "";
	        Class.forName("com.mysql.jdbc.Driver");
	    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
	    	//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore","root","lkjhlkjh");
	    	if (text == null || text.equals("")) {
	        	query = "SELECT * FROM bookstore.book, bookstore.author, bookstore.inventory WHERE book.book_id = author.book_id AND inventory.book_id = author.book_id ORDER BY "+text2+";";
	    	} else {
	    		query = "SELECT * FROM bookstore.book, bookstore.author, bookstore.inventory WHERE book.book_id = author.book_id AND inventory.book_id = author.book_id AND (author.first_name LIKE '%"+text+"%' OR author.last_name LIKE '%"+text+"%' OR book.title LIKE '%"+text+"%') ORDER BY "+text2+";";
	    	}
	    	Statement st = con.createStatement();
	    	ResultSet rs =st.executeQuery(query);
	      	while (rs.next()) { %>
        <div class="item">
        <form action="AddToCart" method="post">
        <input type="hidden" name="bookID" value="<%=rs.getString(1)%>">
          <div class="cover">
            <img src="./img/books/default.jpg">
          </div>
          <div class="description">
            <p><%=rs.getString(4) + " by " + rs.getString(11) + ", " + rs.getString(10)%></p>
          </div>
          <div class="quantity">
            <p>
              <%=rs.getString(13) + " in Stock" %>
            </p>
          </div>
          <div class="price">
            <p><%= "$" + rs.getString(14) %></p>
          </div>
          <div class="submit">
          	
          		<input type="number" min="1" step="1" name="quantity" oninput="validity.valid||(value='');" required>
          		<input type="submit" value="Add to Cart" name="add">
          	
          </div>
          </form>
        </div> 
        <%} %>
      </div>
    
    </section>

<footer>
  <p>CSCI4050 Team 9, Copyright &copy; 2020</p>
</footer>
</body>

</html>
