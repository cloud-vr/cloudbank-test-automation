*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${cloudbank_logo}    

*** Variables ***
${errors}    xpath=//*[@class='errorlist']/li

*** Test Cases ***
Negative Scenario - Blank Fields
    Create Client    \    \    \    \    \
    ${element}    Get WebElement    ${client_first_name}
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
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com 
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}  
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Element Attribute Value Should Be    ${client_email_addr}    value    yuffie@kisaragi.com  
    Click Element    ${form_btn_back_to_list}
                 
Update
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com                
    Update Client    ${row}    i_mobile=69 
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Element Attribute Value Should Be    ${client_mobile_number}    value    69  
    Click Element    ${form_btn_back_to_list}

    
Delete
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com  
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}                 
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Click Element    ${form_btn_delete}    
    Click Element    ${form_btn_confirm_delete_yes}    
    Page Should Contain Element    //h1[contains(text(),'Client List')]
    # create client again because it is needed for the transactions
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com