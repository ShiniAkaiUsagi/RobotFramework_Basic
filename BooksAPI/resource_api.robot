*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Library          RequestsLibrary
Library          Collections
Library          BuiltIn
Library          String


*** Variables ***
${URL_API}        https://fakerestapi.azurewebsites.net/api/v1/
&{BOOK_15}        ID=15
...               Title=Book 15
...               PageCount=1500


*** Keywords ***

Conectar a minha API
    Create Session         fakeAPI                ${URL_API}

Requisitar todos os livros e retornar Status Code "${STATUS_CODE_DESEJADO}"
    ${RESPOSTA}            GET On Session         fakeAPI        Books
    ...                    expected_status=${STATUS_CODE_DESEJADO}              
    Log                    ${RESPOSTA}
    Set Test Variable      ${RESPOSTA}

Conferir se retorna uma lista com "${QT_LIVROS}" livro(s)
    Length Should Be       ${RESPOSTA.json()}     ${QT_LIVROS}

Requisitar o livro "${LIVRO}" e retornar Status Code "${STATUS_CODE_DESEJADO}"
    ${RESPOSTA}            GET On Session         fakeAPI        Books/${LIVRO}
    ...                    expected_status=${STATUS_CODE_DESEJADO}
    Log                    ${RESPOSTA}
    Set Test Variable      ${RESPOSTA}

Conferir se retorna o livro "${LIVRO}" corretamente
    Log                    ${RESPOSTA.json()}
    # Dictionaries Should Be Equal    ${RESPOSTA}  
    Dictionary Should Contain Item                ${RESPOSTA.json()}        id           ${BOOK_15.ID}
    Dictionary Should Contain Item                ${RESPOSTA.json()}        title        ${BOOK_15.Title}
    Dictionary Should Contain Item                ${RESPOSTA.json()}        pageCount    ${BOOK_15.PageCount}
    
    Should Not Be Empty                           ${RESPOSTA.json()["description"]}
    Should Not Be Empty                           ${RESPOSTA.json()["excerpt"]}
    Should Not Be Empty                           ${RESPOSTA.json()["publishDate"]}

Cadastrar um livro e retornar Status Code "${STATUS_CODE_DESEJADO}"
    &{BODY}                Create Dictionary      id=518
    ...                                           title=teste
    ...                                           description=Era uma vez um teste
    ...                                           pageCount=472
    ...                                           excerpt=fim
    ...                                           publishDate=2021-03-10T01:09:54.957Z
    ${HEADERS}             Create Dictionary      content-type=application/json
    ${RESPOSTA}            POST On Session        fakeAPI   Books
    ...                    data={"id": ${BODY.id}, "title": "${BODY.title}", "description": "${BODY.description}", "pageCount": ${BODY.pageCount}, "excerpt": "${BODY.excerpt}", "publishDate": "${BODY.publishDate}"}
    ...                    headers=${HEADERS}
    ...                    expected_status=${STATUS_CODE_DESEJADO}
    Log                    ${RESPOSTA.text}
    Set Test Variable      ${RESPOSTA}
    Set Test Variable      ${BODY}

Conferir se o livro foi registrado corretamente
    Should Be Equal As Strings    ${RESPOSTA.json()}[id]             ${BODY.id}
    Should Be Equal As Strings    ${RESPOSTA.json()}[title]          ${BODY.title}
    Should Be Equal As Strings    ${RESPOSTA.json()}[description]    ${BODY.description}
    Should Be Equal As Strings    ${RESPOSTA.json()}[pageCount]      ${BODY.pageCount}
    Should Be Equal As Strings    ${RESPOSTA.json()}[excerpt]        ${BODY.excerpt}
    Should Be Equal As Strings    ${RESPOSTA.json()}[publishDate]    ${BODY.publishDate}

Atualizar o livro "${LIVRO}" e retornar Status Code "${STATUS_CODE_DESEJADO}"
    &{BODY}                Create Dictionary      id=${LIVRO}
    ...                                           title=teste atualizado
    ...                                           description=Era outra vez um teste 2
    ...                                           pageCount=475
    ...                                           excerpt=fim
    ...                                           publishDate=2022-03-10T01:09:54.957Z
    ${HEADERS}             Create Dictionary      content-type=application/json
    ${RESPOSTA}            PUT On Session         fakeAPI   Books/${BODY.id}
    ...                    data={"id": ${BODY.id}, "title": "${BODY.title}", "description": "${BODY.description}", "pageCount": ${BODY.pageCount}, "excerpt": "${BODY.excerpt}", "publishDate": "${BODY.publishDate}"}
    ...                    headers=${HEADERS}
    ...                    expected_status=${STATUS_CODE_DESEJADO}
    Log                    ${RESPOSTA.text}
    Set Test Variable      ${RESPOSTA}
    Set Test Variable      ${BODY}

Deletar o livro "${LIVRO}" e retornar Status Code "${STATUS_CODE_DESEJADO}"
    ${RESPOSTA}            DELETE On Session    fakeAPI    Books/${LIVRO}
    ...                    expected_status=${STATUS_CODE_DESEJADO}
    Log                    ${RESPOSTA.text}
    Set Test Variable      ${RESPOSTA}

Conferir se o livro ${LIVRO} foi deletado com sucesso
    Requisitar o livro "${LIVRO}" e retornar Status Code "400"