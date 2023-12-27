*** Settings ***
Library         SeleniumLibrary

Test Setup      Abrir o navegador


*** Variables ***
${URL}              https://app.homolog.floui.io/login
${EMAIL_LOCATOR}    //input[contains(@placeholder,'Entre com o e-mail')]
${SENHA_LOCATOR}    //input[contains(@type,'password')]
${EMAIL}            john@acme.com
# ${SENHA}           Digite a senha
${ENTRAR}           //button[contains(@type,'submit')]
${PAGE}             //img[contains(@alt,'Floui.io - Integração sem limites')]


*** Test Cases ***
Caso de teste 01 - Acesso a pagina https://app.floui.io/login
    Acessar a home page do site
    Selecionar o campo    CAMPO=${EMAIL_LOCATOR}    TEXTO=${EMAIL}
    Selecionar o campo    CAMPO=${SENHA_LOCATOR}    TEXTO=${SENHA}
    Verificar page https://app.homolog.floui.io/
    Pesquisar por um flow especifico e abrir ele
    Executar o flow aberto e validar sua saída 


*** Keywords ***
Abrir o navegador
    Open Browser    url=${URL}    browser=chrome
    Maximize Browser Window
    Set Selenium Speed    0.5s

Acessar a home page do site
    Go To    url=${URL}

Selecionar o campo
    [Arguments]    ${CAMPO}    ${TEXTO}
    Wait Until Element Is Visible    locator=${CAMPO}    timeout=10
    Input Text    locator=${CAMPO}    text=${TEXTO}

Verificar page https://app.homolog.floui.io/
    Click Element    locator=${ENTRAR}
    Wait Until Page Contains    text=Workspaces
    Location Should Be    url=https://app.homolog.floui.io/
    Sleep    5
    # Wait Until Element Is Visible    locator=${PAGE}
    # Sleep    5

Pesquisar por um flow especifico e abrir ele
    Click Element    locator=workspaceNavbarButton
    Sleep    6
    Click Element    locator=//button[contains(.,'Acessar workspace')]
    Sleep    6
    Input Text    locator=searchFlowInput    text=debora
    Sleep    6
    Click Element    locator=//span[contains(.,'Todos')]

Executar o flow aberto e validar sua saída 
    Sleep    6
    Click Element    locator=//div[contains(@class,'thumbnail-mask')]
    Sleep    6
    Click Element    locator=toggleDebuggerButton
    Sleep    6
    Click Element    locator=executeButton
    Sleep    6
    Click Element    locator=(//a[contains(.,'visualizar')])[2]
    Wait Until Page Contains    text=JSON
