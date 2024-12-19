--1. Qual a categoria que possui o produto com o maior número de dias entre a primeira
--compra da categoria e a sua data limite de entrega?

WITH FirstPurchase AS (
    SELECT 
        p.product_category_name,
        MIN(o.order_purchase_timestamp) AS first_purchase_date
    FROM 
        ORDERS o
    JOIN 
        ORDER_ITEMS oi ON o.order_id = oi.order_id
    JOIN 
        PRODUCTS p ON oi.product_id = p.product_id
    GROUP BY 
        p.product_category_name
),
DeliveryDates AS (
    SELECT 
        p.product_category_name,
        o.order_id,
        o.order_estimated_delivery_date,
        fp.first_purchase_date,
        (julianday(o.order_estimated_delivery_date) - julianday(fp.first_purchase_date)) AS days_diff
    FROM 
        ORDERS o
    JOIN 
        ORDER_ITEMS oi ON o.order_id = oi.order_id
    JOIN 
        PRODUCTS p ON oi.product_id = p.product_id
    JOIN 
        FirstPurchase fp ON p.product_category_name = fp.product_category_name
)

SELECT 
    product_category_name,
    MAX(days_diff) AS max_days_diff
FROM 
    DeliveryDates
GROUP BY 
    product_category_name
ORDER BY 
    max_days_diff DESC
LIMIT 1;

--2. Qual o nome da categoria com o maior número de pedidos realizados no banco de dados?
SELECT 
    p.product_category_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    ORDERS o
JOIN 
    ORDER_ITEMS oi ON o.order_id = oi.order_id
JOIN 
    PRODUCTS p ON oi.product_id = p.product_id
GROUP BY 
    p.product_category_name
ORDER BY 
    total_orders DESC
LIMIT 1;

--3. Qual a categoria com maior soma dos preços de produtos?
SELECT 
    p.product_category_name,
    SUM(oi.price) AS total_price
FROM 
    ORDER_ITEMS oi
JOIN 
    PRODUCTS p ON oi.product_id = p.product_id
GROUP BY 
    p.product_category_name
ORDER BY 
    total_price DESC
LIMIT 1;

--4. Qual o código do produto mais caro da categoria agro indústria & comercio?
SELECT 
    p.product_id,
    MAX(oi.price) AS max_price
FROM 
    ORDER_ITEMS oi
JOIN 
    PRODUCTS p ON oi.product_id = p.product_id
WHERE 
    p.product_category_name = "agro_industria_e_comercio"
GROUP BY 
    p.product_id
ORDER BY 
    max_price DESC
LIMIT 1;

SELECT DISTINCT 
    p.product_category_name
FROM 
    PRODUCTS p;

--5. Qual a ordem correta das 3 categorias com os produtos mais caros?
SELECT 
    p.product_category_name,
    MAX(oi.price) AS max_price
FROM 
    ORDER_ITEMS oi
JOIN 
    PRODUCTS p ON oi.product_id = p.product_id
GROUP BY 
    p.product_category_name
ORDER BY 
    max_price DESC
LIMIT 3;

--6. Qual o valor dos produtos mais caros das categorias: bebes, flores e seguros e serviços, respectivamente:
SELECT 
    p.product_category_name,
    MAX(oi.price) AS max_price
FROM 
    ORDER_ITEMS oi
JOIN 
    PRODUCTS p ON oi.product_id = p.product_id
WHERE 
    p.product_category_name IN ("bebes", "flores", "seguros_e_servicos")
GROUP BY 
    p.product_category_name;
    
   --7.Quantos pedidos possuem um único comprador, 3 produtos e o pagamento foi dividido em 10 parcelas?
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    ORDERS o
LEFT JOIN 
    ORDER_ITEMS oi ON (o.order_id = oi.order_id)
LEFT JOIN 
    order_payments op ON (o.order_id = op.order_id) 
WHERE 
    o.order_status = 'delivered'
GROUP BY 
    o.order_id
HAVING 
    COUNT(DISTINCT oi.product_id) = 3
    AND COUNT(DISTINCT o.customer_id) = 1
    AND MAX(op.payment_installments) = 10;
    
 --8. Quantos pedidos foram parcelados em mais de 10 vezes ?
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    ORDERS o
JOIN 
    order_payments op ON o.order_id = op.order_id 
WHERE 
    op.payment_installments > 10;
    
--9. Quantos clientes avaliaram o pedido com 5 estrelas?
SELECT 
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM 
    ORDERS o
JOIN 
    ORDER_REVIEWS r ON o.order_id = r.order_id
WHERE 
    r.review_score = 5;
    
 --10. Quantos clientes avaliaram o pedido com 4 estrelas?
SELECT 
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM 
    ORDERS o
JOIN 
    ORDER_REVIEWS r ON o.order_id = r.order_id
WHERE 
    r.review_score = 4;
    
 --11. Quantos clientes avaliaram o pedido com 3 estrelas?
SELECT 
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM 
    ORDERS o
JOIN 
    ORDER_REVIEWS r ON o.order_id = r.order_id
WHERE 
    r.review_score = 3; 
    
 --12. Quantos clientes avaliaram o pedido com 2 estrelas?
SELECT 
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM 
    ORDERS o
JOIN 
    ORDER_REVIEWS r ON o.order_id = r.order_id
WHERE 
    r.review_score = 2; 
    
 --13. Quantos clientes avaliaram o pedido com 1 estrelas?
 SELECT 
    COUNT(DISTINCT o.customer_id) AS total_customers
FROM 
    ORDERS o
JOIN 
    ORDER_REVIEWS r ON o.order_id = r.order_id
WHERE 
    r.review_score = 1; 
    
 --14. No dia 2 de Outubro de 2016, qual era o valor da média móvel dos últimos 7 dias?
WITH pedidos_totais AS (
   	SELECT 
    	DATE(o.order_purchase_timestamp) AS order_date,
    	SUM(oi.price) AS total_value
	FROM 
    	ORDERS o
	JOIN 
    	ORDER_ITEMS oi ON o.order_id = oi.order_id
	WHERE 
    	DATE(o.order_purchase_timestamp) BETWEEN '2016-09-26' AND '2016-10-02'
	GROUP BY 
    	DATE(o.order_purchase_timestamp)
)

SELECT
	AVG(total_value) AS media_movel
FROM
	pedidos_totais
WHERE
	order_date  BETWEEN '2016-09-26' AND '2016-10-02'
	




    
 --15. No dia 5 de Outubro de 2016 as 08:04:21, qual era o valor da média móvel dos últimos 14 dias?
 SELECT 
    AVG(daily_totals.total_value) AS moving_average
FROM (
    SELECT 
        DATE(o.order_purchase_timestamp) AS order_date,
        SUM(oi.price) AS total_value
    FROM 
        ORDERS o
    JOIN 
        ORDER_ITEMS oi ON o.order_id = oi.order_id
    WHERE 
        o.order_purchase_timestamp BETWEEN '2016-09-21 00:00:00' AND '2016-10-05 08:04:21'
    GROUP BY 
        DATE(o.order_purchase_timestamp)
) AS daily_totals;

--16. Qual o código do produto da categoria agro indústria e comércio que está na 5
--posição do ranking de produtos mais caros dessa categoria?
SELECT 
    p.product_id,
    p.product_category_name,
    SUM(oi.price) AS total_value
FROM 
    PRODUCTS p
JOIN 
    ORDER_ITEMS oi ON (p.product_id = oi.product_id)
WHERE 
    p.product_category_name = 'agro_industria_e_comercio'
GROUP BY 
    p.product_category_name
ORDER BY 
    total_value DESC;



--17. Qual o código do produto da categoria artes que está na posição 1 do ranking de
--produtos mais caros dessa categoria?

SELECT 
    p.product_id,
    p.product_category_name,
    SUM(oi.price) AS total_value
FROM 
    PRODUCTS p
JOIN 
    ORDER_ITEMS oi ON p.product_id = oi.product_id
WHERE 
    p.product_category_name = 'artes'
GROUP BY 
    p.product_id
ORDER BY 
    total_value DESC;
   
    
 --18. Qual o valor da soma de todos que estão acima da posição 5 do ranking de produtos
--mais caros da categoria brinquedos.
SELECT 
    SUM(total_value) AS total_sum
FROM (
    SELECT 
        SUM(oi.price) AS total_value,
        ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS rank
    FROM 
        PRODUCTS p
    JOIN 
        ORDER_ITEMS oi ON p.product_id = oi.product_id
    WHERE 
        p.product_category_name = 'brinquedos'
    GROUP BY 
        p.product_id
) AS ranked_products
WHERE 
    rank > 5;