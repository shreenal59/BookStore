<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <meta name="description" content="Online Bookstore">
  <meta name="keywords" content="bookstore, shopping, ecommerce, books, shop">
  <meta name="author" content="Nidesh">
  <title>BookStore | Home</title>
  <link rel="stylesheet" href="./css/stylesheet.css">
  <script src="scritps.js"></script>
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
          <li><a href="login.html">Login</a></li>
          <li class="current"><a href="register.jsp">Register</a></li>
          <li><a href="shoppingcart.html">Shopping Cart</a></li>
          <li><a href="profile.html">Profile</a></li>
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

  <section id="sec-reg-log">
    <div class="container">
      <main id="main-reg-log">
        <form action="Register" method="post">
      <article id="art-reg-log">
        <h1 class="page-title">Register</h1>

        <p>Please fill in this form to create an account. All fields are required. </p>
        <hr>
        <label for="name" class="reg-label"> <b>Name</b></label>
        <input type="text" class="name" placeholder="First Name *" name="name-first" id="name-first" required>
        <input type="text" class="name" placeholder="Last Name *" name="name-last" id="name-last" required>

        <label for="email" class="reg-label"><b>Email</b></label>
        <input type="email" placeholder="Enter Email *" name="email" id="email" required>
        
        <label for="phone" class="reg-label"><b>Phone Number</b></label>
        <input type="text" placeholder="Enter Phone Number (XXX-XXX-XXXX) *" name="phone" id="phone" required>

        <label for="psw" class="reg-label"><b>Password</b></label>
        <input type="password" placeholder="Enter Password *" name="psw" id="psw" required>

        <label for="psw-repeat" class="reg-label"><b>Repeat Password</b></label>
        <input type="password" placeholder="Repeat Password *" name="psw-repeat" id="psw-repeat" required>
        
        <!-- <label for="address" class="reg-label"><b>Address Information</b></label>
        <input type="text" placeholder="Enter Street Name" name="street" id="street">
        <input type="text" placeholder="Enter City Name" name="city" id="city">
        <input type="text" placeholder="Enter Zip Code" name="zip" id="zip">
        <input type="text" placeholder="Enter State Name" name="state" id="state">
        
        
        <label for="creditcard" class="reg-label"><b>Credit Card Information</b></label>
        <input type="text" placeholder="Enter Credit/Debit Card Number" name="ccnum" id="ccnum" maxlength="16">
        <input type="text" placeholder="Enter 3-Digit CVC" name="cvc" id="cvc" maxlength="3">
        <input type="text" placeholder="Enter Expiration Date (MM/YY)" name="expDate" id="expDate">
        <input type="text" placeholder="Enter Name on Card" name="ccname" id="ccname"> -->
        
        <hr>

        <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>
        <p>Already have an account? <a href="login.html">Sign In</a>.</p>
        <button type="submit" class="submitbtn">Register</button>
        
      </article>
    </form>
    </main>

    </div>
  </section>

  <footer>
    <p>CSCI4050 Team 9, Copyright &copy; 2020</p>
  </footer>
</body>

</html>
