*** Settings ***
Documentation           Essa suíte testa o site da Amazon.com.br
Resource                amazon_resources_gherkin_bdd.robot

Test Setup              Abrir o navegador
Test Teardown           Fechar o navegador 


*** Test Cases ***

Caso de Teste 01 - Acesso ao menu "Eletrônicos"
    [Documentation]      Esse teste verifica o menu eletrônicos do site Amazon.com.br
    ...                  e verifica a categoria Computadores e Informática
    [Tags]               menus  categorias
    Dado que estou na home page da Amazon.com.br
    Quando acessar o menu "Eletrônicos"
    Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    E a categoria "Computadores e Informática" deve ser exibida na página

Caso de Teste 02 - Pesquisa de um Produto
    [Documentation]      Esse teste verifica a busca de um produto
    [Tags]               busca_produtos  lista_busca
    Dado que estou na home page da Amazon.com.br
    Quando pesquisar pelo produto "Console Xbox Series S"
    Então um produto da linha "Console Xbox Series S" deve ser mostrado na página

Caso de Teste 03 - Adição de um produto no Carrinho
    Dado que estou na home page da Amazon.com.br
    Quando pesquisar pelo produto "Console Xbox Series S"
    E adicionar o produto "Console Xbox Series S" no carrinho
    Então o produto "Console Xbox Series S" deve ser mostrado no carrinho

Caso de Teste 04 - Remoção de um produto do Carrinho
    Dado que estou na home page da Amazon.com.br
    E existe um produto "Console Xbox Series S" no carrinho
    Quando remover o produto "Console Xbox Series S" do carrinho
    Então o carrinho deve ficar vazio

