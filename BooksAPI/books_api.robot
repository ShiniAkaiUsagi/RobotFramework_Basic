*** Settings ***
Documentation    Documentação da API: https://fakerestapi.azurewebsites.net/index.html
Resource         resource_api.robot
Suite Setup      Conectar a minha API


*** Test Cases ***

Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros e retornar Status Code "200"
    Conferir se retorna uma lista com "200" livro(s)

Buscar um livro específico (GET de um livro específico)
    Requisitar o livro "15" e retornar Status Code "200"
    Conferir se retorna o livro "15" corretamente

Cadastrar um novo livro (POST)
    Cadastrar um livro e retornar Status Code "200"
    Conferir se o livro foi registrado corretamente
     
Atualizar um livro em específico (PUT)
    Atualizar o livro "199" e retornar Status Code "200"
    Conferir se o livro foi registrado corretamente

Deletar um livro em específico (DELETE)
    Deletar o livro "15" e retornar Status Code "200"
    Conferir se o livro "15" foi deletado com sucesso