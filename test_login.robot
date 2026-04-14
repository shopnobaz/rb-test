*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}         https://the-internet.herokuapp.com/login
${BROWSER}           chrome
${VALID_USERNAME}    tomsmith
${VALID_PASSWORD}    SuperSecretPassword!
${INVALID_PASSWORD}  wrongpassword
${ERROR_MESSAGE}     Invalid credentials
${SUCCESS_MESSAGE}   Welcome

*** Test Cases ***
Successful Login With Valid Credentials
    Open Login Page
    Login As    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Verify Login Success
    Close Browser



Failed Login With Wrong Password
    Open Login Page
    Login As    ${VALID_USERNAME}    ${INVALID_PASSWORD}
    Verify Login Error    Your password is invalid!
    Close Browser




Failed Login With Empty Username
    Open Login Page
    Input Password    ${VALID_PASSWORD}
    Click Login Button
    Verify Login Error    Your username is invalid!
    Close Browser






*** Keywords ***
Open Login Page
    [Documentation]    Navigate to login page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=username    timeout=10s

Login As
    [Arguments]    ${username}    ${password}
    [Documentation]    Fill in login form
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Click Login Button

Input Password
    [Arguments]    ${password}
    Input Text    id=password    ${password}


Click Login Button
    Click Button    css:button[type="submit"]
    Wait Until Page Contains Element    id=flash    timeout=10s

Verify Login Success
    Wait Until Element Is Visible    id=flash    timeout=10s
    Element Should Contain    id=flash    You logged into a secure area!


Verify Login Error
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    id=flash    timeout=10s
    Element Should Contain    id=flash    ${expected_message}


