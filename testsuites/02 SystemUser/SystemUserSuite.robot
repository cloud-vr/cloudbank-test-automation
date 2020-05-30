*** Settings ***
Resource    ../../templates/02 SystemUser/template_SystemUser.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}

*** Test Cases ***
01 - Positive Scenario - Profile
    Click Element    ${Topbar.Profile.ProfileIcon.Link}    
    Click Element    ${Topbar.Profile.ProfileLink.Link}       
    
    @{args}    Create List    ${Form.SystemUser.Username.Txt}    tester    
    VERIFY    Textfield Value Should Be    ${args}

02 - Negative Scenario - System User - All Fields Are Empty  
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\02.json 

03 - Negative Scenario - System User - Password Confirmation Empty    
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\03.json  

04 - Negative Scenario - System User - Username Is Too Similar To Password
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\04.json  

05 - Negative Scenario - System User - Password Less Than 8 Characters
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\05.json  
        
06 - Negative Scenario - System User - Password Is Too Common
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\06.json 
    
07 - Negative Scenario - System User - Password Is Entirely Numeric
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\07.json 
    
08 - Negative Scenario - System User - Password and Password Confirmation Does Not Match
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\08.json 
    
09 - Positive Scenario - System User - Valid Username and Password
    [Template]    System User Create Template
    ${CURDIR}\\data\\09.json 

10 - Negative Scenario - System User - Existing User
    [Template]    System User Create With Field Error Template
    ${CURDIR}\\data\\10.json 
    
11 - Positive Scenario - System User - View
    [Template]    System User View Template    
    ${CURDIR}\\data\\11.json  
    
12 - Positive Scenario - System User - Update
    [Template]    System User Update Template
    ${CURDIR}\\data\\12.json    
    
13 - Positive Scenario - System User - Delete
    [Template]    System User Delete Template
    ${CURDIR}\\data\\13.json 
    