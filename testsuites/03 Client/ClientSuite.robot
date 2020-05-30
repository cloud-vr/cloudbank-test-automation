*** Settings ***
Resource    ../../templates/03 Client/template_Client.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}        
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***  
01 - Negative Scenario - Client - All Fields Are Empty
    [Template]    Client Create Template
    ${CURDIR}\\data\\01.json     

02 - Positive Scenario - Client - All Fields Are Populated Correctly
    [Template]    Client Create Template
    ${CURDIR}\\data\\02.json
    
03 - Negative Scenario - Client - Existing Client
    [Template]    Client Create Template
    ${CURDIR}\\data\\03.json            
    
04 - Positive Scenario - Client - View
    [Template]    Client View Template
    ${CURDIR}\\data\\04.json
                 
05 - Positive Scenario - Client - Update
    [Template]    Client Update Template
    ${CURDIR}\\data\\05.json
    
06 - Positive Scenario - Client - Delete
    Client Delete Template    ${CURDIR}\\data\\06.json  
    Client Create Template    ${CURDIR}\\data\\02.json
   
    