CREATE SCHEMA IF NOT EXISTS techfab;

CREATE TABLE IF NOT EXISTS techfab.dim_customer 
(
    sk_cliente integer NOT NULL,
    id_cliente integer NOT NULL,
    nome character varying(50) NOT NULL,
    tipo character varying(50),
    CONSTRAINT dim_customer_pkey PRIMARY KEY (sk_cliente)
);

CREATE TABLE IF NOT EXISTS techfab.dim_localidade
(
    sk_localidade integer NOT NULL,
    id_localidade integer NOT NULL,
    pais character varying(50) NOT NULL,
    regiao character varying(50) NOT NULL,
    estado character varying(50) NOT NULL,
    cidade character varying(50) NOT NULL,
    CONSTRAINT dim_localidade_pkey PRIMARY KEY (sk_localidade)
);

CREATE TABLE IF NOT EXISTS techfab.dim_product
(
    sk_produto integer NOT NULL,
    id_produto integer NOT NULL,
    nome_produto character varying(50) NOT NULL,
    categoria character varying(50) NOT NULL,
    subcategoria character varying(50) NOT NULL,
    CONSTRAINT dim_product_pkey PRIMARY KEY (sk_produto)
);

CREATE TABLE IF NOT EXISTS techfab.dim_time
(
    sk_tempo integer NOT NULL,
    data_completa date,
    ano integer NOT NULL,
    mes integer NOT NULL,
    dia integer NOT NULL,
    CONSTRAINT dim_time_pkey PRIMARY KEY (sk_tempo)
);

CREATE TABLE IF NOT EXISTS techfab.fact_sales
(
    sk_produto integer NOT NULL,
    sk_cliente integer NOT NULL,
    sk_localidade integer NOT NULL,
    sk_tempo integer NOT NULL,
    quantidade integer NOT NULL,
    preco_venda numeric(10,2) NOT NULL,
    custo_produto numeric(10,2) NOT NULL,
    receita_vendas numeric(10,2) NOT NULL,
    CONSTRAINT fact_sales_pkey PRIMARY KEY (sk_produto, sk_cliente, sk_localidade, sk_tempo),
    CONSTRAINT fact_sales_sk_cliente_fkey FOREIGN KEY (sk_cliente) REFERENCES techfab.dim_customer (sk_cliente),
    CONSTRAINT fact_sales_sk_localidade_fkey FOREIGN KEY (sk_localidade) REFERENCES techfab.dim_localidade (sk_localidade),
    CONSTRAINT fact_sales_sk_produto_fkey FOREIGN KEY (sk_produto) REFERENCES techfab.dim_product (sk_produto),
    CONSTRAINT fact_sales_sk_tempo_fkey FOREIGN KEY (sk_tempo) REFERENCES techfab.dim_time (sk_tempo)
);

COPY techfab.dim_customer
FROM 's3://dsa-projeto2/dados/dim_customer.csv'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'

CSV;

COPY techfab.dim_localidade
FROM 's3://dsa-projeto2/dados/dim_localidade.csv'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'

CSV;

COPY techfab.dim_product
FROM 's3://dsa-projeto2/dados/dim_product.csv'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'

CSV;

COPY techfab.dim_time
FROM 's3://dsa-projeto2/dados/dim_time.csv'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'

CSV;

COPY techfab.fact_sales
FROM 's3://dsa-projeto2/dados/fact_sales.csv'
IAM_ROLE 'arn:aws:iam::<YOUR_AWS_ACCOUNT_ID>:role/<YOUR_ROLE_NAME>'

CSV;
