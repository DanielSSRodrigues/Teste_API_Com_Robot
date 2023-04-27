*** Settings ***
Library   RequestsLibrary
Library   String
Library   collections



*** Keywords ***
Criar um usuário novo
    ${palavra_aleatoria}     Generate Random String    length=4      chars=[LETTERS]
    ${palavra_aleatoria}     Convert To Lower Case  ${palavra_aleatoria}
    Set Test Variable        ${EMAIL_TESTE}  ${palavra_aleatoria}@emailteste.com   
    Log    ${EMAIL_TESTE}
                
Cadastrar o usuário criado na ServeRest
    [Arguments]    ${email}    ${status_code_desejado}
    ${body}    Create Dictionary     
    ...    nome=Fulano da Silva   
    ...    email=${EMAIL_TESTE}    
    ...    password=1234    
    ...    administrador=true
    Log    ${body}
    Criar Sessão na ServeRest
    ${resposta}    POST On Session    #será usada pois foi criada uma sessão.. o psot será na sessão criada
    ...    alias=ServeRest     
    ...    url=/usuarios     
    ...    json=${body}    
    ...    expected_status=${status_code_desejado}

    Log    ${resposta.json()}
    Set Test Variable    ${ID_USUARIO}    ${resposta.json()["_id"]}
    Set Test Variable  ${RESPOSTA}  ${resposta.json}

Criar Sessão na ServeRest
    ${headers}    Create Dictionary  accept=application/json  Content-Type=application/json

        Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    Log      message=${RESPOSTA}

Vou repetir o cadastro do usuário
    Cadastrar o usuário criado na ServeRest    ${EMAIL_TESTE}     status_code_desejado=400

Consultar os dados do novo usuário
    ${resposta_consulta}  GET On Session    alias=ServeRest    url=/usuarios/${ID_USUARIO}
    Set Test Variable    ${RESPOSTA_CONSULTA}    ${resposta_consulta.json()}

Conferir os dados retornados
    Log    ${RESP_CONSULTA}
