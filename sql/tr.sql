CREATE OR REPLACE FUNCTION issue_book()
RETURNS TRIGGER AS
$$
BEGIN
    UPDATE books
    SET book_count = book_count - 1
    WHERE book_id = NEW.book_id;
    RAISE NOTICE 'Payment has been done for the sale of book %.', NEW.book_name;

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;
CREATE TRIGGER update_book_count_trigger
AFTER INSERT ON sales
FOR EACH ROW
EXECUTE FUNCTION issue_book();
