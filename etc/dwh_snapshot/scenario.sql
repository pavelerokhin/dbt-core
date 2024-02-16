SELECT * FROM fact;

SELECT * FROM dimension;

SELECT * FROM snapshots.dimension_created_snapshot;

SELECT * FROM snapshots.dimension_no_created_snapshot;

TRUNCATE snapshots.dimension_created_snapshot;

TRUNCATE snapshots.dimension_no_created_snapshot;

TRUNCATE dimension CASCADE;

TRUNCATE fact;


CREATE TABLE dimension
(
    product_id   SERIAL
        PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category     VARCHAR(50),
    price        NUMERIC(10, 2),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fact
(
    transaction_id SERIAL
        PRIMARY KEY,
    product_id     INTEGER
        REFERENCES dimension
            ON UPDATE CASCADE ON DELETE CASCADE,
    quantity       INTEGER,
    total_amount   NUMERIC(10, 2),
    sale_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dimension (product_id, product_name, category, price, created_at, updated_at) VALUES
    (1, 'vacuum cleaner', 'e', 119.99, '2024-02-06 14:40:00.000000', '2024-02-06 14:40:00.000000');

INSERT INTO fact (transaction_id, product_id, quantity, total_amount, sale_date) VALUES
    (1, 1, 1, 120.00, '2024-02-06 14:45:00.000000');

UPDATE dimension SET category = 'EE', updated_at = '2024-02-06 14:50:00.000000' WHERE product_id = 1;

-- snapshot

INSERT INTO fact (transaction_id, product_id, quantity, total_amount, sale_date) VALUES
    (2, 1, 1, 120.00, '2024-02-06 14:51:00.000000');

UPDATE dimension SET category = 'EEE', updated_at = '2024-02-06 14:55:00.000000' WHERE product_id = 1;

-- snapshot

INSERT INTO fact (transaction_id, product_id, quantity, total_amount, sale_date) VALUES
    (3, 1, 1, 120.00, '2024-02-06 15:00:00.000000');

-- snapshot



SELECT *
FROM fact AS f
LEFT JOIN snapshots.dimension_created_snapshot AS s ON f.product_id = s.product_id
    AND tsrange(s.dbt_valid_from, s.dbt_valid_to, '[)') @> f.sale_date;

SELECT *
FROM fact AS f
LEFT JOIN snapshots.dimension_no_created_snapshot AS s ON f.product_id = s.product_id
    AND tsrange(s.dbt_valid_from, s.dbt_valid_to, '[)') @> f.sale_date;
