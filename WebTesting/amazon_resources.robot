*** Settings ***

Library          SeleniumLibrary    timeout=8 seconds  implicit_wait=0.5 seconds  screenshot_root_directory=Screenshots
Library          BuiltIn


*** Variables ***
${BROWSER}                      chrome
${URL}                          http://www.amazon.com.br
${MENU_ELETRONICOS}             xpath=//a[contains(text(),'Eletrônicos')]
${HEADER_ELETRONICOS}           xpath=//h1[contains(., 'Eletrônicos e Tecnologia')]
${ADICIONAR_NO_CARRINHO}        xpath=//input[@id='add-to-cart-button']
${MENS_COBERTURA}               xpath=//div[@id='attach-warranty-pane']
${SAIDA_COBERTURA}              xpath=//div[contains(@class,'a-declarative attach-dss-backdrop')]
${MENS_CONFIRMA_CARRINHO}       xpath=//span[contains(.,'Adicionado ao carrinho')]
${CARRINHO}                     xpath=//div[@id='nav-cart-count-container']
${CARRINHO_VAZIO}               xpath=//h1[@class='a-spacing-mini a-spacing-top-base'][contains(.,'Seu carrinho de compras da Amazon está vazio.')]



*** Keywords ***

# Setup
Abrir o navegador
    Open Browser                browser=${BROWSER}

# Teardown
Fechar o navegador
    Capture Page Screenshot     ${SUITE NAME}_{index}.png
    Close Browser

# ACTIONS
Acessar a home page do site Amazon.com.br 
     Go To                              url=${URL}
     Maximize Browser Window

Entrar no menu "Eletrônicos"
    Wait Until Element Is Visible       ${MENU_ELETRONICOS}
    Click Element                       ${MENU_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Wait Until Page Contains Element    xpath=//head/title
    Title Should Be                     title=${TITULO}

Verificar se aparece a frase "${FRASE}"
    Wait Until Page Contains            text=${FRASE}
    Wait Until Element Is Visible       ${HEADER_ELETRONICOS}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should be Visible           locator=//a[@aria-label='${NOME_CATEGORIA}']

Digitar o nome de produto "${NOME_PRODUTO}" no campo de pesquisa
    Wait Until Element Is Visible       locator=twotabsearchtextbox
    Input Text                          locator=twotabsearchtextbox    text=${NOME_PRODUTO}

Clicar no botão de pesquisa
    Click Element                       locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Page Contains Element    xpath=(//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')])[1]

Adicionar o produto "${PRODUTO}" no carrinho
    # Acessar página do produto
    Click Element                       xpath=(//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')])[1]
    
    # Adicionar Produto
    Wait Until Element Is Visible       ${ADICIONAR_NO_CARRINHO}
    Click Element                       ${ADICIONAR_NO_CARRINHO} 
    
    # Recusar Cobertura - Nem sempre aparece
    ${c} =  Get Element Count   ${MENS_COBERTURA}
    IF  ${c}!=0
        Wait Until Keyword Succeeds     2 times    1 second    Wait Until Page Contains Element   ${SAIDA_COBERTURA}
        Click Element                   ${SAIDA_COBERTURA}
    END
    Wait Until Element Is Visible       ${MENS_CONFIRMA_CARRINHO}


Verificar se o produto "${PRODUTO}" foi adicionado com sucesso
    # Acessar página do carrinho
    Wait Until Element Is Visible       ${CARRINHO}
    Click Element                       ${CARRINHO}

    # Conferir adição do produto
    Page Should Contain Element         xpath=//div/ul//span[contains(., '${PRODUTO}')]

Remover o produto "${PRODUTO}" do carrinho
    Wait Until Page Contains Element    xpath=//div/div//input[@aria-label='Excluir ${PRODUTO}']
    Click Element                       xpath=//div/div//input[@aria-label='Excluir ${PRODUTO}']

Verificar se o carrinho fica vazio
    Wait Until Element Contains         ${CARRINHO_VAZIO}        Seu carrinho de compras da Amazon está vazio.