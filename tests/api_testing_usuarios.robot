*** Settings ***
Resource  ../resources/api_testing_usuarios.resource



*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  email=${EMAIL_TESTE}  status_code_desejado=201
    Conferir se o usuário foi cadastrado corretamente

Cénario 02: Cadastrar um usuário já esistente
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  email=${EMAIL_TESTE}  status_code_desejado=201
    Vou repetir o cadastro do usuário              


Cénario 03: Consultar os dados de um novo usuário
    Criar um usuário novo
    Cadastrar o usuário criado na ServeRest  email=${EMAIL_TESTE}  status_code_desejado=201
    Consultar os dados do novo usuário


