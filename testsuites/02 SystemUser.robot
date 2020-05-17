*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}


*** Variables ***
${errors}    xpath=//*[@class='errorlist']/li

*** Test Cases ***
Profile Check
    Click Element    ${Topbar.Profile.ProfileIcon.Link}    
    Click Element    ${Topbar.Profile.ProfileLink.Link}       
    Element Attribute Value Should Be    ${Form.SystemUser.Username.Txt}    value    tester    
    
Negative Scenario - Blank Fields
    Create System User    ${EMPTY}    ${EMPTY}    ${EMPTY}
    ${element}    Get WebElement    ${Form.SystemUser.Username.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create System User')]
    
Negative Scenario - Password Confirmation Empty
    Create System User    tester2    password@1234    ${EMPTY}
    ${element}    Get WebElement    ${Form.SystemUser.PasswordConfirmation.Txt}
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
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.SystemUserList.Link}    
    Click Element    ${Sidebar.StaticData.SystemUserList.Link}  
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Element Attribute Value Should Be    ${Form.SystemUser.Username.Txt}    value    tester2  
    Click Element    ${Form.Common.BackToList.Btn}
    
Update
    &{row}    Create Dictionary
    ...    Username:=tester2               
    Update System User    ${row}    i_username=tester2_updated    i_password=password@1234    i_password_confirmation=password@1234
    Page Should Contain Element    //h1[contains(text(),'System User List')]   
    Set To Dictionary    ${row}    Username:=tester2_updated
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a
    Element Attribute Value Should Be    ${Form.SystemUser.Username.Txt}    value    tester2_updated  
    Click Element    ${Form.Common.BackToList.Btn}
    
Delete
    &{row}    Create Dictionary
    ...    Username:=tester2_updated    
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.SystemUserList.Link}    
    Click Element    ${Sidebar.StaticData.SystemUserList.Link}                 
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Click Element    ${Form.Common.Delete.Btn}    
    Click Element    ${Page.DeleteConfirmation.YesImSure.Btn}    
    Page Should Contain Element    //h1[contains(text(),'System User List')] 