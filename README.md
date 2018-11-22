# API-CNP
Classe para integração com a API do Cadastro Nacional de Produtos

De acordo com a Nota Técnica 2017.001 do Projeto Nota Fiscal Eletrônica:
"O GTIN, sigla de “Global Trade Item Number” é um identificador para itens comerciais. Os GTIN, anteriormente chamados de códigos EAN, são atribuídos
para qualquer item (produto ou serviço) que pode ser precificado, pedido ou faturado em qualquer ponto da cadeia de suprimentos. O GTIN é utilizado para
recuperar informação pré-definida e abrange desde as matérias primas até produtos acabados. Os GTINs podem ter o tamanho de 8, 12, 13 ou 14 dígitos
e podem ser construídos utilizando qualquer uma das quatro estruturas de numeração dependendo da aplicação.

O Cadastro Centralizado de GTIN (CCG) é um banco de dados contendo um conjunto reduzido de informações dos produtos que possuem o código de
barras GTIN em suas embalagens, e funciona de forma integrada com o CNP (Cadastro Nacional de Produtos da GS1), que é o cadastro mantido pela
organização legalmente responsável pelo licenciamento do respectivo código de barras. Os produtos em circulação no mercado que possuem GTIN e que
são informados nos documentos fiscais eletrônicos, NF-e e NFC-e, terão suas informações validadas no CCG, de acordo com o cronograma previsto na
legislação. Portanto, os donos das marcas dos produtos que possuem GTIN deverão manter atualizados os dados cadastrais de seus produtos junto ao
CNP (em cnp.gs1br.org/), de forma a manter atualizado o Cadastro Centralizado de GTIN."

Atualmente, existem 3 maneiras de submeter um produto no portal CNP: manualmente, através de arquivo (csv ou xlsx) e através de API.

Esta classe tem a finalidade de facilitar a integração com a API desenvolvida pelo CNP (Cadastro Nacional de Produtos).

Para utilizar a API, primeiramente é necessário cadastrar sua aplicação no endereço https://apicnp.gs1br.org, obtendo assim o "Client ID" e o "Client Secret".

Através de API, é possível fazer 3 tipos de requisição: Cadastro de Produto sem GTIN, Cadastro de Produto com GTIN, e Atualização do Produto GTIN.

No header de cada requisição, também é necessário informar um token. Esse token é gerado automaticamente por esta classe aqui disponibilizada e tem validade de 4 horas.
É recomendável armazenar o token gerado - bem como sua data/hora de expiração - para utiliá-lo nas requisições futuras, evitando assim a geração de um novo token a cada requisição.
Caso o token esteja vencido, a classe também se encarrega de gerar um novo automaticamente.
