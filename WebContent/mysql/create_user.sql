
/*
    This function returns a newly created user_id based on the first_name and the last_name entered.
	e.g. if user enters John Smith as his name, it'll return jsNNN as his user_id.
	It also checks if the enterd email-id has already been used. In that case, it returns an error EMAIL_EXISTS.
*/

CREATE FUNCTION create_user (fName varchar(45), lName varchar(45), email varchar(45), passwd varchar(45), phoneNo varchar(45) ) RETURNS varchar(45) CHARSET utf8
    DETERMINISTIC
BEGIN
    DECLARE returnString VARCHAR(45) DEFAULT 'EMAIL_EXISTS';
    DECLARE new_customer_id INT;
    DECLARE new_user_id VARCHAR(45);
    DECLARE temp_user_id VARCHAR(45) DEFAULT 'NOT_FOUND';
    DECLARE temp_number INT;
    DECLARE email_1 VARCHAR(45) DEFAULT 'NotFound';

    SELECT email_address INTO email_1 from customer where email_address = email;

    IF email_1 = 'NotFound' THEN
        SET new_user_id = concat(left(fName,1), left(lName, 1));
        select user_id into temp_user_id from user where user_id like concat(new_user_id, '%') order by user_id desc limit 1;
        IF temp_user_id = 'NOT_FOUND' THEN
            SET new_user_id = concat(new_user_id, '1');
        ELSE
            SET temp_number = CONVERT(SUBSTRING(temp_user_id, 3), SIGNED INTEGER) + 1; 
            SET new_user_id = concat(new_user_id, temp_number);
        END IF;

        insert into user (user_id, password, first_name, last_name, User_Type)
            values ( new_user_id, aes_encrypt(passwd, '4050'), fName, lName, 'C');

        SELECT max(customer_id) + 1 into new_customer_id from customer;

        insert into customer(customer_id, user_id, email_address, phone_number, status)
            values(new_customer_id, new_user_id, email, phoneNo, 'I');

        SET returnString = new_user_id;
    ELSE
        SET returnString = 'EMAIL_EXISTS';
    END IF;

    RETURN returnString;
END
