*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page          
Suite Teardown    Logout

*** Test Cases ***
Empty Username and Password
    GoTo Cloud Bank Page and Login    ${EMPTY}    ${EMPTY}
    ${element}    Get WebElement    ${Page.Login.Username.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.

Empty Username
    GoTo Cloud Bank Page and Login    ${EMPTY}    password
    ${element}    Get WebElement    ${Page.Login.Username.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.

Empty Password
    GoTo Cloud Bank Page and Login    username    ${EMPTY}
        ${element}    Get WebElement    ${Page.Login.Password.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.

Invalid Username and Password
    GoTo Cloud Bank Page and Login    does_not_exist    password@xxxx
    Page Should Contain    Please enter a correct username and password. Note that both fields may be case-sensitive.
            
Valid Username and Wrong Password
    GoTo Cloud Bank Page and Login    tester    password@xxxx
    Page Should Contain    Please enter a correct username and password. Note that both fields may be case-sensitive.
    
Valid Username and Correct Password
    GoTo Cloud Bank Page and Login    tester    password@1234
    Page Should Contain    About the App
