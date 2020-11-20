<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <meta name="description" content="Online Bookstore">
  <meta name="keywords" content="bookstore, shopping, ecommerce, books, shop">
  <meta name="author" content="Avery Davis">
  <title>Admin | Books</title>
  <link rel="stylesheet" href="./css/adminstylesheet.css">
  <script src="scritps.js"></script>
</head>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <meta name="description" content="Online Bookstore">
  <meta name="keywords" content="bookstore, shopping, ecommerce, books, shop">
  <meta name="author" content="Avery Davis">
  <title>Admin | Books</title>
  <link rel="stylesheet" href="./css/adminstylesheet.css">
  <script src="scritps.js"></script>
</head>

<body>

<%
  
    String query = "SELECT book_id, isbn, category, title, edition, publisher, publication_year FROM bookstore.book;";
    
    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookstore","root","4122");
	//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Bookstore","root","lkjhlkjh");
	Statement st = con.createStatement();
	ResultSet rs =st.executeQuery(query);
	Statement st2 = con.createStatement();
	Statement st3 = con.createStatement();
	//ResultSet rs2 = st.executeQuery(query2);
  
  
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
    <a href="managePromotions.html">Manage Promotions</a>
    <a href="manageUsers.jsp">Manage Users</a>
    <a href="index.html">Logout</a>
  </div>

  <div id="main">
    <h2>Manage Books</h2>
    <hr>
    <h4>Book Catalog</h4>
    <div class="tables" id="bookTable">
      <table>
        <tr>
          <th>Book ID</th>
          <th>ISBN</th>
          <th>Category</th>
          <th>Title</th>
          <th>Edition</th>
          <th>Publisher</th>
          <th>Publication Year</th>
          <th>Author First Name</th>
          <th>Author Last Name</th>
          <th>Stock on Hand</th>
          <th>MSRP</th>
          <th>Availability</th>
        </tr>
   
		        <%
		while (rs.next()) {
			int bookID = rs.getInt(1);
		%>
		<TR>
		<TD><%=bookID%></TD>
		<TD><%=rs.getString(2)%></TD>
		<TD><%=rs.getString(3)%></TD>
		<TD><%=rs.getString(4)%></TD>
		<TD><%=rs.getString(5)%></TD>
		<TD><%=rs.getString(6)%></TD>
		<TD><%=rs.getString(7)%></TD>
		<%
		String query2 = "SELECT first_name, last_name FROM bookstore.author WHERE book_id = '" + bookID +"';";
		ResultSet rs2 = st2.executeQuery(query2);
		while (rs2.next()) {
			%>
			<td> <%= rs2.getString(1) %>
			<td> <%= rs2.getString(2) %>
			<%
		}
		String query3 = "SELECT quantity, price, Book_Status FROM bookstore.inventory WHERE book_id = '" + bookID + "';";
		ResultSet rs3 = st3.executeQuery(query3);
		while (rs3.next()) {
			%>
			<td> <%= rs3.getString(1) %>
			<td> <%= rs3.getString(2) %>
			<td> <%= rs3.getString(3) %>
			<%
		}
		%>
		</TR>
		<% } %>
		        
		

      </table>
   
    </div>
    <hr>
    <div class="admintool" id="addBook">
      <label for="newbook" class="input-label"> <b>Add New Book</b></label>
      <br>
      <form action="AddBook" method="post">
      <!--Book Table-->
      <input type="text" class="ISBN" placeholder="ISBN *" name="ISBN" required>
      <select name="category" id="category" required>
        <option value="AA">Action and Adventure</option>
        <option value="BA">Biographies and Autobiographies</option>
        <option value="CL">Classics</option>
        <option value="CO">Comics</option>
        <option value="DM">Detective and Mystery</option>
        <option value="FA">Fantasy</option>
        <option value="FI">Fiction</option>
        <option value="HF">Historical Fiction</option>
        <option value="HO">Horror</option>
        <option value="RO">Romance</option>
        <option value="SF">Science Fiction</option>
        <option value="SS">Short Stories</option>
      </select>
      <input type="text" class="title" placeholder="Title *" name="title" required>
      <input type="text" class="edition" placeholder="Edition *" name="edition" required>
      <input type="text" class="publisher" placeholder="Publisher" name="publisher" required>
      <input type="number" class="publication_year" placeholder="Publication Year *" name="publication_year" step="1" required>
      <br>
      <!--Author Table-->
      <input type="text" class="author_firstname" placeholder="Author First Name *" name="author_first" required>
      <input type="text" class="author_lastname" placeholder="Author Last Name *" name="author_last" required>
      <br>
      <!--Inventory Table-->
      <input type="number" class="title" placeholder="Stock on Hand *" name="stock" step="1" required>
      <input type="number" class="title" placeholder="MSRP *" name="MSRP" step=".01" required>
      <select name="Book Status" id="Book Status" required>
        <option value="A">Available</option>
        <option value="L">Low Stock</option>
        <option value="O">Out of Stock</option>
      </select>
      <br>
      <button type="submit" class="Add">Add New Book</button>
      </form>
    </div>
    <hr>
    <div class="adminTool" id="editBook">
      <label for="newbook" class="input-label"> <b>Edit Existing Book</b></label>
      <br>
      <form action="EditBook" method="post">
      <input type="text" class="book_id" placeholder="Book ID*" name="book_id" required>
      <br>
      <input type="text" class="ISBN" placeholder="ISBN" name="ISBN">
     <!-- <input type="text" class="category" placeholder="Category" name="category"> -->
      <select name="category" id="category">
      	<option value="DEFAULT">Select a Category</option>
        <option value="AA">Action and Adventure</option>
        <option value="BA">Biographies and Autobiographies</option>
        <option value="CL">Classics</option>
        <option value="CO">Comics</option>
        <option value="DM">Detective and Mystery</option>
        <option value="FA">Fantasy</option>
        <option value="FI">Fiction</option>
        <option value="HF">Historical Fiction</option>
        <option value="HO">Horror</option>
        <option value="RO">Romance</option>
        <option value="SF">Science Fiction</option>
        <option value="SS">Short Stories</option>
      </select>
      <input type="text" class="title" placeholder="Title" name="title">
      <input type="text" class="edition" placeholder="Edition" name="edition">
      <input type="text" class="publisher" placeholder="Publisher" name="publisher">
      <input type="number" class="publication_year" placeholder="Publication Year" name="publication_year" step="1">
      <br>
      <input type="text" class="author_firstname" placeholder="Author First Name" name="author_first">
      <input type="text" class="author_lastname" placeholder="Author Last Name" name="author_last">
      <br>
      <input type="number" class="title" placeholder="Stock on Hand" name="stock" step="1">
      <input type="number" class="title" placeholder="MSRP" name="MSRP" step=".01">
      <select name="Book Status" id="Book Status">
      	<option value="DEFAULT">Select Availability</option>
        <option value="A">Available</option>
        <option value="L">Low Stock</option>
        <option value="O">Out of Stock</option>
      </select>
      <br>

      <button type="submit" class="adminTool">Submit Changes</button>
      </form>
    </div>
    <hr>
    <div class="adminTool" id="deleteBook">
      <label for="newbook" class="input-label"> <b>Delete Existing Book</b></label>
      <br>
      <form action="DeleteBook" method="post">
      <input type="text" class="book_id" placeholder="Book ID*" name="book_id" required>
      <br>
      <button type="submit" class="adminTool">Delete</button>
      </form>
    </div>

  </div>

  </div>
</body>

</html>

<body>
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
    <a href="managePromotions.html">Manage Promotions</a>
    <a href="manageUsers.jsp">Manage Users</a>
    <a href="index.html">Logout</a>
  </div>

  <div id="main">
    <h2>Manage Books</h2>
    <hr>
    <h4>Book Catalog</h4>
    <div class="tables" id="bookTable">
      <!--
      <div style="overflow-x:auto;">
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
      </div>
    -->
    </div>
    <hr>
    <div class="admintool" id="addBook">
      <label for="newbook" class="input-label"> <b>Add New Book</b></label>
      <br>
      <form action="AddBook" method="post">
      <!--Book Table-->
      <input type="text" class="ISBN" placeholder="ISBN" name="ISBN">
      <input type="text" class="category" placeholder="Category*" name="category" required>
      <input type="text" class="title" placeholder="Title*" name="title" required>
      <input type="text" class="edition" placeholder="Edition" name="edition">
      <input type="text" class="publisher" placeholder="Publisher" name="publisher">
      <input type="number" class="publication_year" placeholder="Publication Year" name="publication_year">
      <br>
      <!--Author Table-->
      <input type="text" class="author_firstname" placeholder="Author First Name" name="author_first" required>
      <input type="text" class="author_lastname" placeholder="Author Last Name" name="author_last" required>
      <br>
      <!--Inventory Table-->
      <input type="number" class="title" placeholder="Stock on Hand" name="stock">
      <input type="number" class="title" placeholder="MSRP" name="MSRP">
      <select name="Book Status" id="Book Status">
        <option value="A">Available</option>
        <option value="L">Low Stock</option>
        <option value="O">Out of Stock</option>
      </select>
      <br>
      <button type="submit" class="Add">Add New Book</button>
      </form>
    </div>
    <hr>
    <div class="adminTool" id="editBook">
      <label for="newbook" class="input-label"> <b>Edit Existing Book</b></label>
      <br>
      <form action="EditBook" method="post">
      <input type="text" class="book_id" placeholder="Book ID*" name="book_id" required>
      <br>
      <input type="text" class="ISBN" placeholder="ISBN" name="ISBN">
      <input type="text" class="category" placeholder="Category" name="category">
      <input type="text" class="title" placeholder="Title" name="title">
      <input type="text" class="edition" placeholder="Edition" name="edition">
      <input type="text" class="publisher" placeholder="Publisher" name="publisher">
      <input type="number" class="publication_year" placeholder="Publication Year" name="publication_year">
      <br>
      <input type="text" class="author_firstname" placeholder="Author First Name" name="author_first">
      <input type="text" class="author_lastname" placeholder="Author Last Name" name="author_last">
      <br>
      <input type="number" class="title" placeholder="Stock on Hand" name="stock">
      <input type="number" class="title" placeholder="MSRP" name="MSRP">
      <select name="Book Status" id="Book Status">
        <option value="A">Available</option>
        <option value="L">Low Stock</option>
        <option value="O">Out of Stock</option>
      </select>
      <br>

      <button type="submit" class="adminTool">Submit Changes</button>
      </form>
    </div>
    <hr>
    <div class="adminTool" id="deleteBook">
      <label for="newbook" class="input-label"> <b>Delete Existing Book</b></label>
      <br>
      <form action="DeleteBook" method="post">
      <input type="text" class="book_id" placeholder="Book ID*" name="book_id" required>
      <br>
      <button type="submit" class="adminTool">Delete</button>
      </form>
    </div>

  </div>

  </div>
</body>

</html>
