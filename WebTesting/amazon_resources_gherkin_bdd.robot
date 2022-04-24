*** Settings ***

# Libraries
Library          SeleniumLibrary    timeout=0:00:10    implicit_wait=0:00:01    screenshot_root_directory=Screenshots
Library          BuiltIn

# Resources
Resource         amazon_resources.robot


*** Keywords ***

# GHERKIN STEPS

# Caso de Teste 01
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Eletrônicos e Tecnologia | Amazon.com.br"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"


# Caso de Teste 02

Quando pesquisar pelo produto "Console Xbox Series S"
    Digitar o nome de produto "Console Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então um produto da linha "Console Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"


# Caso de Teste 03

E adicionar o produto "Console Xbox Series S" no carrinho
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho

Então o produto "Console Xbox Series S" deve ser mostrado no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso


# Caso de Teste 04
E existe um produto "Console Xbox Series S" no carrinho
    Digitar o nome de produto "Console Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"
    Adicionar o produto "Console Xbox Series S" no carrinho
    Verificar se o produto "Console Xbox Series S" foi adicionado com sucesso

Quando remover o produto "Console Xbox Series S" do carrinho
    Remover o produto "Console Xbox Series S" do carrinho

Então o carrinho deve ficar vazio
    Verificar se o carrinho fica vazio


