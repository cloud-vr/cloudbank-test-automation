*** Settings ***
Resource    ../../templates/04 Deposit/template_Deposit.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}        
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***
01 - Negative Scenario - Deposit Transaction - All Fields Are Empty
    [Template]    Deposit Transaction Create With Field Error Template
    ${CURDIR}\\data\\01.json

02 - Positive Scenario - Deposit Transaction - All Fields Are Populated Correctly
    [Template]    Deposit Transaction Create Template
    ${CURDIR}\\data\\02.json   
    
03 - Positive Scenario - Deposit Transaction - View
    [Template]    Deposit Transaction View Template
    ${CURDIR}\\data\\03.json  
    