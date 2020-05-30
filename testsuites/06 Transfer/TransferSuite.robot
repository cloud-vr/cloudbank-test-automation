*** Settings ***
Resource    ../../templates/06 Transfer/template_Transfer.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***
01 - Negative Scenario - Transfer Transaction - All Fields Are Empty
    [Template]    Transfer Transaction Create With Field Error Template    
    ${CURDIR}\\data\\01.json

02 - Positive Scenario - Transfer Transaction - All Fields Are Populated Correctly
    [Template]    Transfer Transaction Create Template       
    ${CURDIR}\\data\\02.json

03 - Positive Scenario - Transfer Transaction - View
    [Template]    Transfer Transaction View Template       
    ${CURDIR}\\data\\03.json  