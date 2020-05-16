*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${cloudbank_logo}


*** Variables ***
${errors}    xpath=//*[@class='errorlist']/li

*** Test Cases ***
Profile Check
    Click Element    ${profile}    
    Click Element    ${profile_profile}       
    Element Attribute Value Should Be    ${form_username}    value    tester    
    
Negative Scenario - Blank Fields
    Create System User    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${element}    Get WebElement    ${form_username}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]
    
Negative Scenario - Password Confirmation Empty
    Create System User    tester2    password@1234    ${EMPTY}
    ${element}    Get WebElement    ${form_password_confirmation}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]

Negative Scenario - Username = Password
    Create System User    testuser    testuser    testuser
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    The password is too similar to the username.
        Exit For Loop If    ${is_expected_error_found}==True 
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${is_expected_error_found}    ${True}    Expected error message not found        
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]

Negative Scenario - Password Less Than 8 characters
    Create System User    testeruser    qwertyu    qwertyu
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    This password is too short. It must contain at least 8 characters.  
        Exit For Loop If    ${is_expected_error_found}==True 
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${is_expected_error_found}    ${True}    Expected error message not found 
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]
        
Negative Scenario - Password is too common
    Create System User    testeruser    password    password
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    This password is too common.  
        Exit For Loop If    ${is_expected_error_found}==True 
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${is_expected_error_found}    ${True}    Expected error message not found
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]
    
Negative Scenario - Password is entirely numeric
    Create System User    testeruser    1234567890    1234567890
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    This password is entirely numeric.  
        Exit For Loop If    ${is_expected_error_found}==True 
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${is_expected_error_found}    ${True}    Expected error message not found
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]
    
Negative Scenario - Password and Password confirmtion does not match
    Create System User    testeruser    password@1234    password@12345
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    The two password fields didn’t match.
        Exit For Loop If    ${is_expected_error_found}==True 
    END
    Run Keyword And Continue On Failure    Should Be Equal    ${is_expected_error_found}    ${True}    Expected error message not found
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]
    
Positive Scenario
    Create System User    tester2    password@1234    password@1234
    Page Should Contain Element    //h1[contains(text(),'System User List')]

Negative Scenario - Existing User
    Create System User    tester2    password@1234    password@1234
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    A user with that username already exists.
        Exit For Loop If    ${is_expected_error_found}==True 
    END
    Page Should Contain Element    //h1[contains(text(),'Create System User')]
    
View
    &{row}    Create Dictionary
    ...    Username:=tester2
    Click Element    ${navlink_system_users_collapsed}
    Wait Until Element Is Visible    ${navlink_system_users_list}    
    Click Element    ${navlink_system_users_list}  
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Element Attribute Value Should Be    ${form_username}    value    tester2  
    Click Element    ${form_btn_back_to_list}
    
Update
    &{row}    Create Dictionary
    ...    Username:=tester2               
    Update System User    ${row}    i_username=tester2_updated    i_password=password@1234    i_password_confirmation=password@1234
    Page Should Contain Element    //h1[contains(text(),'System User List')]   
    Set To Dictionary    ${row}    Username:=tester2_updated
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a
    Element Attribute Value Should Be    ${form_username}    value    tester2_updated  
    Click Element    ${form_btn_back_to_list}
    
Delete
    &{row}    Create Dictionary
    ...    Username:=tester2_updated    
    Click Element    ${navlink_system_users_collapsed}
    Wait Until Element Is Visible    ${navlink_system_users_list}    
    Click Element    ${navlink_system_users_list}                 
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Click Element    ${form_btn_delete}    
    Click Element    ${form_btn_confirm_delete_yes}    
    Page Should Contain Element    //h1[contains(text(),'System User List')] 