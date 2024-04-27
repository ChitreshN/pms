CREATE OR REPLACE FUNCTION calculate_total_price(mem_id INT) RETURNS INT AS $$
DECLARE
    total_price INT := 0;
BEGIN
    SELECT SUM(book_price)
    INTO total_price
    FROM send_request sr
    JOIN books b ON sr.book_id = b.book_id
    WHERE sr.mem_id = mem_id;
    RETURN total_price;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE update_book_status(book_id INT, new_status INT) AS $$
BEGIN
    UPDATE books
    SET status = new_status
    WHERE book_id = book_id;
END;
$$ LANGUAGE plpgsql;
