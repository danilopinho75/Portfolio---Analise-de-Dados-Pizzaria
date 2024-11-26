-- 1. Quais são os 5 sabores de pizza mais vendidos e seus volumes de venda?
SELECT
    pizza_name as sabores_pizza,
    SUM(quantity) quantidade_vendidas
FROM pedidos_pizzaria
GROUP BY pizza_name
ORDER BY quantidade_vendidas DESC
LIMIT 5;

-- 2. Qual é a receita mensal total da pizzaria?

SELECT
    strftime('%Y-%m', order_date) as mes,
    sum(total_price) as receita
FROM pedidos_pizzaria
GROUP BY mes
ORDER BY mes;

-- 3. Qual é o método de pagamento mais popular entre os clientes?
SELECT
    payment_method as metodo_pagamento,
    COUNT(order_id) quantidade_pedidos
FROM pedidos_pizzaria
GROUP BY metodo_pagamento
ORDER BY quantidade_pedidos DESC
LIMIT 1;

-- 4.Quantas pizzas de cada tamanho (Pequena, Média, Grande) foram vendidas em cada mês?
SELECT
    strftime('%Y-%m', order_date) as mes,
    pizza_size as tamanho,
    SUM(quantity) as quantidade_vendidas
FROM pedidos_pizzaria
GROUP BY mes, tamanho
ORDER BY mes ASC, tamanho DESC
;

-- 5. Qual é o ticket médio dos pedidos para cada tamanho de pizza?
SELECT
    pizza_size as tamanho,
    ROUND(AVG(total_price),2) as ticket_medio
FROM pedidos_pizzaria
GROUP BY tamanho
ORDER BY tamanho DESC
;

-- 6. Qual é a taxa de adesão a promoções em relação ao total de vendas?

SELECT
    ROUND(
        SUM(
            CASE WHEN promotion_applied = 1
            THEN total_price ELSE 0 END) * 100
            / SUM(total_price), 2
        ) || '%' as taxa_de_adesao
FROM pedidos_pizzaria
;

-- 7. Quais dias da semana têm maior volume de vendas?
SELECT
    CASE strftime('%w', order_date)
        WHEN '0' THEN 'Domingo'
        WHEN '1' THEN 'Segunda-feira'
        WHEN '2' THEN 'Terça-feira'
        WHEN '3' THEN 'Quarta-feira'
        WHEN '4' THEN 'Quinta-feira'
        WHEN '5' THEN 'Sexta-feira'
        WHEN '6' THEN 'Sábado'
    END as dia_da_semana,
    SUM(quantity) as quantidades_vendidas
FROM pedidos_pizzaria
GROUP BY dia_da_semana
ORDER BY quantidades_vendidas DESC
;