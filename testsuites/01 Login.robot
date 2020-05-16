*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank          
Suite Teardown    Logout

*** Test Cases ***
Empty Username and Password
    Input Username and Password Then Click Login    ${EMPTY}    ${EMPTY}
    ${element}    Get WebElement    ${username}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.

Empty Username
    Input Username and Password Then Click Login    ${EMPTY}    password
        ${element}    Get WebElement    ${username}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.

Empty Password
    Input Username and Password Then Click Login    username    ${EMPTY}
        ${element}    Get WebElement    ${password}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.

Invalid Username and Password
    Input Username and Password Then Click Login    does_not_exist    password@xxxx
    Page Should Contain    Please enter a correct username and password. Note that both fields may be case-sensitive.
            
Valid Username and Wrong Password
    Input Username and Password Then Click Login    tester    password@xxxx
    Page Should Contain    Please enter a correct username and password. Note that both fields may be case-sensitive.
    
Valid Username and Correct Password
    Input Username and Password Then Click Login    tester    password@1234
    Page Should Contain    About the App

