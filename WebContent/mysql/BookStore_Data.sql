

insert into user_type (code, description) values ( 'A', 'Admin' );
insert into user_type (code, description) values ( 'C', 'Customer');

insert into Customer_Status (code, description) values ( 'A', 'Active' ); 
insert into Customer_Status (code, description) values ( 'I', 'Inactive' ); 
insert into Customer_Status (code, description) values ( 'S', 'Suspended' ); 

insert into Book_Category (code, description) values ( 'AA', 'Action and Adventure');
insert into Book_Category (code, description) values ( 'BA', 'Biographies and Autobiographies');
insert into Book_Category (code, description) values ( 'CL', 'Classics');
insert into Book_Category (code, description) values ( 'CO', 'Comics');
insert into Book_Category (code, description) values ( 'DM', 'Detective and Mystery');
insert into Book_Category (code, description) values ( 'FA', 'Fantasy');
insert into Book_Category (code, description) values ( 'FI', 'Fiction');
insert into Book_Category (code, description) values ( 'HF', 'Historical Fiction');
insert into Book_Category (code, description) values ( 'HO', 'Horror');
insert into Book_Category (code, description) values ( 'RO', 'Romance');
insert into Book_Category (code, description) values ( 'SF', 'Science Fiction');
insert into Book_Category (code, description) values ( 'SS', 'Short Stories');

insert into Book_Status (code, description) values ( 'A', 'Available' ); 
insert into Book_Status (code, description) values ( 'L', 'Low Stock' ); 
insert into Book_Status (code, description) values ( 'O', 'Out of stock' ); 

insert into Card_Type (code, description) values ( 'M', 'Mastercard' ); 
insert into Card_Type (code, description) values ( 'V', 'Visa' ); 
insert into Card_Type (code, description) values ( 'D', 'Discover' ); 
insert into Card_Type (code, description) values ( 'A', 'American Express' ); 

insert into Address_Type (code, description) values ( 'B', 'Billing' ); 
insert into Address_Type (code, description) values ( 'S', 'Shipping' ); 



insert into user (user_id, password, first_name, last_name, User_Type)
	values ( 'admin', aes_encrypt('admin4050', '4050'), 'AdminFirst', 'AdminLast', 'A');
insert into user (user_id, password, first_name, last_name, User_Type)
	values ( 'user1', aes_encrypt('user14050', '4050'), 'user1First', 'user1Last', 'C');	
insert into user (user_id, password, first_name, last_name, User_Type)
	values ( 'user2', aes_encrypt('user24050', '4050'), 'user2First', 'user2Last', 'C');


insert into Customer (customer_id, user_id, email_address, phone_number, status)
	values (3001, 'user1', 'aa@abc.com', '3451725123', 'A');
 insert into Customer (customer_id, user_id, email_address, phone_number, status)
	values (3002, 'user2', 'bb@abc.com', '7517315223', 'A'); 
  

insert into Address ( addess_id, customer_id, street, city, state, zip, address_type)
	values (6001, 3001, '123 Avenue', 'Duluth', 'GA', 30074, 'B');
insert into Address ( addess_id, customer_id, street, city, state, zip, address_type)
	values (6002, 3001, '123 Fifth Avenue', 'Duluth', 'GA', 30074, 'S');
insert into Address ( addess_id, customer_id, street, city, state, zip, address_type)
	values (6003, 3002, '982 Main Street', 'Cumming', 'GA', 30041, 'B');
insert into Address ( addess_id, customer_id, street, city, state, zip, address_type)
	values (6004, 3002, '450 ACrter Road', 'Cumming', 'GA', 30041, 'S');	
 

insert into Payment_Card ( card_id, customer_id, card_number, expiration_date, card_type)
	values( 7001, 3001, aes_encrypt('3445236567825647', '4050'), '2024-06-25', 'M');
insert into Payment_Card ( card_id, customer_id, card_number, expiration_date, card_type)
	values( 7002, 3002, aes_encrypt('6777236567829821', '4050'), '2024-08-25', 'V');
insert into Payment_Card ( card_id, customer_id, card_number, expiration_date, card_type)
	values( 7003, 3002, aes_encrypt('7733236567826721', '4050'), '2025-09-25', 'D');	
	
  
 
insert into book (book_id, isbn, category, title, edition, publisher, publication_year, cover_picture)
      values( 1001, '9780143131991', 'SF', 'Ice', '1st', 'Peter Owen Publishers', 1967, '1001.png');	  

insert into book (book_id, isbn, category, title, edition, publisher, publication_year, cover_picture)
      values( 1002, '9781621067429', 'HF', 'Mostly True', '3rd', 'Microcosm Publishing', 2012, '1002.png');
	  
insert into book (book_id, isbn, category, title, edition, publisher, publication_year, cover_picture)
      values( 1003, '9780593396957', 'SF', 'Ready Player One', '2nd', 'Ballantine Books', 2020, '1003.png');	  

insert into book (book_id, isbn, category, title, edition, publisher, publication_year, cover_picture)
      values( 1004, '9781770462243', 'FI', 'Big Kids', '2nd', 'Drawn and Quarterly', 2016, '1004.png');
	  

insert into author (book_id, first_name, last_name) values (1001, 'Anna', 'Kavan');
insert into author (book_id, first_name, last_name) values (1002, 'Bil', 'Daniel');
insert into author (book_id, first_name, last_name) values (1003, 'Ernest', 'Cline');
insert into author (book_id, first_name, last_name) values (1004, 'Michael', 'DeForge');


insert into Inventory ( book_id, quantity, price, Book_Status) values ( 1001, 15, 14.99, 'A');	
insert into Inventory ( book_id, quantity, price, Book_Status) values ( 1002, 3, 8.95, 'L');
insert into Inventory ( book_id, quantity, price, Book_Status) values ( 1003, 10, 9.99, 'A');	
insert into Inventory ( book_id, quantity, price, Book_Status) values ( 1004, 12, 24.95, 'A');


insert into promotion (promotion_id, promo_code, percentage, start_date, end_date, delivered)
	values( 8001, 'GET15', 15, '2020-06-01', '2020-06-30', 'Y');
insert into promotion (promotion_id, promo_code, percentage, start_date, end_date, delivered)
	values( 8002, 'FALL20', 20, '2020-10-01', '2020-11-30', 'Y');	





