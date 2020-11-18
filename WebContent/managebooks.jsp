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
