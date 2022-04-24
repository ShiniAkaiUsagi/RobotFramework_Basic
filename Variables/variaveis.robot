*** Settings ***

Library          BuiltIn


*** Variables ***

@{NUMEROS}             1  2  3  4  5  6  7  8  9  10


*** Test Cases ***

Imprimir numeros certos
    Teste Numeros
    

*** Keywords ***

Teste Numeros
  Log To Console  ${\n}
  FOR    ${numero}    IN   @{NUMEROS}
      IF  ${numero} in (5, 10)
          Log To Console    Eu sou o número ${numero}!
      ELSE
          Log To Console    Eu não sou o número 5 e nem o 10!
      END              
  END