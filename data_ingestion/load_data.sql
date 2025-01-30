CREATE SCHEMA IF NOT EXISTS techfab;

CREATE TABLE IF NOT EXISTS techfab.dim_customer 
(
    sk_customer INTEGER NOT NULL,
    id_customer INTEGER NOT NULL,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50),
    CONSTRAINT dim_customer_pkey PRIMARY KEY (sk_customer)
);

CREATE TABLE IF NOT EXISTS techfab.dim_location
(
    sk_location INTEGER NOT NULL,
    id_location INTEGER NOT NULL,
    country VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    CONSTRAINT dim_location_pkey PRIMARY KEY (sk_location)
);

CREATE TABLE IF NOT EXISTS techfab.dim_product
(
    sk_product INTEGER NOT NULL,
    id_product INTEGER NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    subcategory VARCHAR(50) NOT NULL,
    CONSTRAINT dim_product_pkey PRIMARY KEY (sk_product)
);

CREATE TABLE IF NOT EXISTS techfab.dim_time
(
    sk_time INTEGER NOT NULL,
    full_date DATE,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    CONSTRAINT dim_time_pkey PRIMARY KEY (sk_time)
);

CREATE TABLE IF NOT EXISTS techfab.fact_sales
(
    sk_product INTEGER NOT NULL,
    sk_customer INTEGER NOT NULL,
    sk_location INTEGER NOT NULL,
    sk_time INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    sale_price NUMERIC(10,2) NOT NULL,
    product_cost NUMERIC(10,2) NOT NULL,
    sales_revenue NUMERIC(10,2) NOT NULL,
    CONSTRAINT fact_sales_pkey PRIMARY KEY (sk_product, sk_customer, sk_location, sk_time),
    CONSTRAINT fact_sales_sk_customer_fkey FOREIGN KEY (sk_customer) REFERENCES techfab.dim_customer (sk_customer),
    CONSTRAINT fact_sales_sk_location_fkey FOREIGN KEY (sk_location) REFERENCES techfab.dim_location (sk_location),
    CONSTRAINT fact_sales_sk_product_fkey FOREIGN KEY (sk_product) REFERENCES techfab.dim_product (sk_product),
    CONSTRAINT fact_sales_sk_time_fkey FOREIGN KEY (sk_time) REFERENCES techfab.dim_time (sk_time)
);

COPY techfab.dim_customer
FROM 's3://<PATH_DIM_CUSTOMER_FILE>'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'
CSV;

COPY techfab.dim_location
FROM 's3://<PATH_DIM_LOCATION_FILE>'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'
CSV;

COPY techfab.dim_product
FROM 's3://<PATH_PRODUCT_FILE>'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'
CSV;

COPY techfab.dim_time
FROM 's3://<PATH_DIM_TIME_FILE>'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'
CSV;

COPY techfab.fact_sales
FROM 's3://<PATH_FACT_SALES_FILE>'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'
CSV;
