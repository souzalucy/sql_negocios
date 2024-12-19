# sql_negocios
Uso de comandos SQL para resolução de perguntas de negócios.

## Resumo do Dataset de E-commerce Brasileiro da Olist
Este é um conjunto de dados público de pedidos realizados na Olist Store, abrangendo cerca de 100 mil pedidos feitos entre 2016 e 2018 em diferentes marketplaces no Brasil. O dataset oferece uma visão detalhada sobre cada pedido, incluindo:

* Status do pedido, preços, pagamentos e desempenho de frete.
* Localização dos clientes.
* Atributos dos produtos e avaliações escritas pelos clientes.
* Um conjunto adicional de dados relaciona CEPs brasileiros com coordenadas geográficas (latitude/longitude).

## Contexto
A Olist é a maior loja de departamentos de marketplaces no Brasil, conectando pequenas empresas de todo o país a canais de vendas com um contrato único e sem burocracia. Os produtos vendidos na Olist Store são enviados diretamente pelos parceiros logísticos da Olist. Após a entrega ou a data estimada, o cliente recebe uma pesquisa de satisfação, podendo avaliar a experiência e escrever comentários.

Observação:
* Um pedido pode conter múltiplos itens.
* Cada item pode ser atendido por um vendedor diferente.
* Os nomes de lojas e parceiros foram substituídos por referências às casas nobres de Game of Thrones.

## Integração com o Funil de Marketing
A Olist também disponibilizou um conjunto de dados sobre o Funil de Marketing, permitindo a análise de pedidos sob a perspectiva de marketing. As instruções para integração estão disponíveis no material fornecido.

## Destaques
Este conjunto de dados representa informações comerciais reais, devidamente anonimizadas, e é uma oportunidade para explorar diversos aspectos do comércio eletrônico no Brasil.

## 1. Categoria com maior número de dias entre primeira compra e entrega
### Objetivo: Determinar a categoria cujo produto teve o maior intervalo de dias entre a data da primeira compra na categoria e a data limite de entrega.

### Técnica: Utilização de uma subquery para calcular a data da primeira compra por categoria e outra para calcular a diferença em dias até a entrega.

### Resultado: Categoria com maior diferença foi identificada por meio de um MAX sobre os dias calculados.

## 2. Categoria com maior número de pedidos
### Objetivo: Identificar a categoria com o maior volume de pedidos no banco de dados.

### Técnica: Contagem de IDs únicos de pedidos (COUNT(DISTINCT)) agrupados por categoria.

### Resultado: A categoria com mais pedidos foi ordenada em ordem decrescente, retornando o maior valor.

## 3. Categoria com maior soma de preços dos produtos
### Objetivo: Determinar a categoria com maior soma dos valores de produtos.

### Técnica: Cálculo do SUM dos preços dos produtos agrupados por categoria.

### Resultado: A categoria foi identificada com base no maior valor total.

## 4. Produto mais caro da categoria "agro indústria & comércio"
### Objetivo: Descobrir o código do produto mais caro dentro da categoria "agro indústria & comércio".

### Técnica: Aplicação de MAX no preço dentro da categoria.

### Resultado: Código do produto mais caro foi identificado.

## 5. Ranking das 3 categorias com os produtos mais caros
### Objetivo: Identificar as 3 categorias com os produtos mais caros.

### Técnica: Uso de MAX para determinar os preços mais altos por categoria, com ordenação decrescente.

### Resultado: Retorno das 3 primeiras categorias no ranking.

## 6. Produtos mais caros das categorias específicas
### Objetivo: Descobrir o valor mais alto dos produtos nas categorias "bebês", "flores" e "seguros e serviços".

### Técnica: Filtro com WHERE IN para categorias e aplicação de MAX por grupo.

### Resultado: Valores máximos retornados para cada categoria.

## 7. Pedidos únicos com condições específicas
### Objetivo: Contar pedidos com um comprador único, 3 produtos e pagamento em 10 parcelas.

### Técnica: Agrupamento e condições em HAVING para atender os critérios especificados.

### Resultado: Total de pedidos foi contabilizado.

## 8. Pedidos parcelados em mais de 10 vezes
### Objetivo: Contar o número de pedidos com parcelas superiores a 10.

### Técnica: Uso de COUNT e filtro de parcelas em WHERE.

### Resultado: Total de pedidos foi identificado.

## 9. Avaliações de pedidos por estrelas
### Objetivo: Contar quantos clientes avaliaram os pedidos com 1, 2, 3, 4 e 5 estrelas.

### Técnica: Filtros com WHERE baseados na pontuação (review_score) e contagem de IDs únicos de clientes.

### Resultado: Contagens separadas para cada pontuação.

## 10. Clientes que avaliaram com 4 estrelas
### Objetivo: Contar os clientes que atribuíram 4 estrelas.

### Técnica: Junção entre tabelas ORDERS e ORDER_REVIEWS. Aplicação de um filtro (WHERE review_score = 4). Contagem de clientes distintos (COUNT(DISTINCT customer_id)).

### Resultado: Número total de clientes que deram essa avaliação foi identificado.

## 11. Clientes que avaliaram com 3 estrelas
### Objetivo: Contar os clientes que atribuíram 3 estrelas.

### Técnica: Semelhante ao item 10, mas filtrando review_score = 3.

### Resultado: Contagem de clientes realizada com sucesso.

## 12. Clientes que avaliaram com 2 estrelas
### Objetivo: Contar os clientes que atribuíram 2 estrelas.

### Técnica: Mesmo método do item anterior, alterando o filtro para review_score = 2.

### Resultado: Quantidade de clientes registrada.

## 13. Clientes que avaliaram com 1 estrela
### Objetivo: Determinar a quantidade de clientes que deram 1 estrela.

### Técnica: Similar aos itens acima, com filtro em review_score = 1.

### Resultado: Número total de clientes foi calculado.

## 14. Média móvel de 7 dias em 02/10/2016
### Objetivo: Calcular a média móvel dos valores de pedidos nos últimos 7 dias até 02/10/2016.

### Técnica: Cálculo diário do total e uso de AVG para média no intervalo especificado.

### Resultado: Valor da média móvel foi retornado.

## 15. Média móvel de 14 dias em 05/10/2016
### Objetivo: Determinar a média móvel de 14 dias até o horário e data específicos.

### Técnica: Similar ao cálculo anterior, ajustando o período para 14 dias.

### Resultado: Valor foi calculado.

## 16. Produto da 5ª posição no ranking "agro indústria & comércio"
### Objetivo: Identificar o produto na 5ª posição do ranking de preços dessa categoria.

### Técnica: Uso de ROW_NUMBER() para ordenação e seleção do 5º item.

### Resultado: Produto foi identificado.

## 17. Produto mais caro na categoria "artes"
### Objetivo: Descobrir o código do produto mais caro na categoria "artes".

### Técnica: Soma dos valores por produto e ordenação decrescente.

### Resultado: Produto de maior valor foi identificado.

## 18. Soma dos produtos acima da 5ª posição na categoria "brinquedos"
### Objetivo: Calcular a soma dos valores de produtos além da 5ª posição no ranking de preços na categoria "brinquedos".

### Técnica: Uso de ROW_NUMBER() e SUM para acumular valores superiores à posição 5.

### Resultado: Soma foi retornada.

# Cada análise utiliza técnicas SQL eficientes para extração e manipulação de dados, priorizando clareza nos filtros e agrupamentos.

Para mais detalhamentos sobre a base de dados utilizada: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
