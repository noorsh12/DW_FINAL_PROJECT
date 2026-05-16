CREATE DATABASE IF NOT EXISTS dw_movierental;
USE dw_movierental;

CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_number INT,
    month_number INT,
    month_name VARCHAR(20),
    quarter_number INT,
    year_number INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    full_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_film (
    film_key INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT NOT NULL,
    title VARCHAR(255),
    category_name VARCHAR(50),
    rental_rate DECIMAL(5,2),
    release_year INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_store (
    store_key INT AUTO_INCREMENT PRIMARY KEY,
    store_id INT NOT NULL,
    city VARCHAR(50),
    manager_name VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_staff (
    staff_key INT AUTO_INCREMENT PRIMARY KEY,
    staff_id INT NOT NULL,
    full_name VARCHAR(100),
    store_id INT
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fact_payment (
    payment_key INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT NOT NULL,
    customer_key INT,
    staff_key INT,
    store_key INT,
    date_key INT,
    amount DECIMAL(10,2),

    CONSTRAINT fk_payment_customer
        FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_payment_staff
        FOREIGN KEY (staff_key) REFERENCES dim_staff(staff_key),

    CONSTRAINT fk_payment_store
        FOREIGN KEY (store_key) REFERENCES dim_store(store_key),

    CONSTRAINT fk_payment_date
        FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fact_rental (
    rental_key INT AUTO_INCREMENT PRIMARY KEY,
    rental_id INT NOT NULL,
    customer_key INT,
    film_key INT,
    staff_key INT,
    store_key INT,
    date_key INT,
    rental_count INT,

    CONSTRAINT fk_rental_customer
        FOREIGN KEY (customer_key) REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_rental_film
        FOREIGN KEY (film_key) REFERENCES dim_film(film_key),

    CONSTRAINT fk_rental_staff
        FOREIGN KEY (staff_key) REFERENCES dim_staff(staff_key),

    CONSTRAINT fk_rental_store
        FOREIGN KEY (store_key) REFERENCES dim_store(store_key),

    CONSTRAINT fk_rental_date
        FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fact_film_performance (
    performance_key INT AUTO_INCREMENT PRIMARY KEY,
    film_key INT,
    date_key INT,
    total_rentals INT,
    total_revenue DECIMAL(10,2),

    CONSTRAINT fk_performance_film
        FOREIGN KEY (film_key) REFERENCES dim_film(film_key),

    CONSTRAINT fk_performance_date
        FOREIGN KEY (date_key) REFERENCES dim_date(date_key)
) ENGINE=InnoDB;