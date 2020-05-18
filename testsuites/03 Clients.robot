*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${errors}    xpath=//*[@class='errorlist']/li

*** Test Cases ***
Negative Scenario - Blank Fields
    Create Client    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${element}    Get WebElement    ${Form.Client.FirstName.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create Client')]       

Positive Scenario - All Field Populated    
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    Page Should Contain Element    //h1[contains(text(),'Client List')]
    
Negative Scenario - Existing Client
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    Client with this Email Address already exists.
        Exit For Loop If    ${is_expected_error_found}==True 
    END 
    
View
    &{l_row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com
    View Client    ${l_row}    i_fname=Yuffie    i_lname=Kisaragi    i_addr=Wutai    i_mobile=4    i_email_addr=yuffie@kisaragi.com        
                 
Update
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com                
    Update Client    ${row}    i_fname=Yuffie    i_lname=Kisaragi    i_mobile=69    i_email_addr=yuffie@kisaragi.com  
    
Delete
    &{l_row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com  
    Delete Client    ${l_row}
    # create client again because it is needed for the transactions
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com