*** Settings ***
Resource    ../../templates/05 Withdraw/template_Withdraw.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}        
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***
01 - Negative Scenario - Withdraw Transaction - All Fields Are Empty
    [Template]    Withdraw Transaction Create With Field Error Template    
    ${CURDIR}\\data\\01.json

02 - Positive Scenario - Withdraw Transaction - All Fields Are Populated Correctly
    [Template]    Withdraw Transaction Create Template    
    ${CURDIR}\\data\\02.json     
    
03 - Positive Scenario - Withdraw Transaction - View
    [Template]    Withdraw Transaction View Template    
    ${CURDIR}\\data\\03.json    
    