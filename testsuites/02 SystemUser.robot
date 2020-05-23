*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}

*** Variables ***
${errors}    /..//*[@class='errorlist']/li

*** Test Cases ***
[Positive Scenario] Profile

    Click Element    ${Topbar.Profile.ProfileIcon.Link}    
    Click Element    ${Topbar.Profile.ProfileLink.Link}       
    
    @{args}    Create List    ${Form.SystemUser.Username.Txt}    tester    
    VERIFY    Textfield Value Should Be    ${args}

[Negative Scenario] System User - All Fields Are Empty    
    Create System User    ${EMPTY}    ${EMPTY}    ${EMPTY}
    
    ${l_validation_message}    Get Validation Message    ${Form.SystemUser.Username.Txt}

    @{args}    Create List    ${l_validation_message}    Please fill out this field.        
    VERIFY    Should Be Equal    ${args}    
    ...    i_pass_message=Validation message "Please fill out this field." displayed successfully.
    ...    i_fail_message=Validation message "Please fill out this field." not displayed successfully.

    @{args}    Create List    //h1[contains(text(),'Create System User')]        
    VERIFY    Page Should Contain Element    ${args}
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.

[Negative Scenario] System User - Password Confirmation Empty    
    Create System User    tester2    password@1234    ${EMPTY}
    
    ${l_validation_message}    Get Validation Message    ${Form.SystemUser.PasswordConfirmation.Txt}

    @{args}    Create List    ${l_validation_message}    Please fill out this field.        
    VERIFY    Should Be Equal    ${args}    
    ...    i_pass_message=Validation message "Please fill out this field." displayed successfully.
    ...    i_fail_message=Validation message "Please fill out this field." not displayed successfully.    

    @{args}    Create List    //h1[contains(text(),'Create System User')]        
    VERIFY    Page Should Contain Element    ${args}
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.

[Negative Scenario] System User - Username Is Too Similar To Password
    Create System User    testuser    testuser    testuser
    
    @{args}    Create List    ${Form.SystemUser.PasswordConfirmation.Txt}${errors}    The password is too similar to the username.
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
        
    @{args}    Create List   //h1[contains(text(),'Create System User')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.  

[Negative Scenario] System User - Password Less Than 8 Characters
    Create System User    testeruser    qwertyu    qwertyu
    
    @{args}    Create List    ${Form.SystemUser.PasswordConfirmation.Txt}${errors}    This password is too short. It must contain at least 8 characters.
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
    
    @{args}    Create List   //h1[contains(text(),'Create System User')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.  
        
[Negative Scenario] System User - Password Is Too Common
    Create System User    testeruser    password    password
    
    @{args}    Create List    ${Form.SystemUser.PasswordConfirmation.Txt}${errors}    This password is too common.
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
    
    @{args}    Create List   //h1[contains(text(),'Create System User')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.
    
[Negative Scenario] System User - Password Is Entirely Numeric
    Create System User    testeruser    00666066600    00666066600

    @{args}    Create List    ${Form.SystemUser.PasswordConfirmation.Txt}${errors}    This password is entirely numeric.  
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
    
    @{args}    Create List   //h1[contains(text(),'Create System User')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.
    
[Negative Scenario] System User - Password and Password Confirmation Does Not Match
    Create System User    testeruser    password@1234    password@12345

    @{args}    Create List    ${Form.SystemUser.PasswordConfirmation.Txt}${errors}    The two password fields didn’t match. 
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
    
    @{args}    Create List   //h1[contains(text(),'Create System User')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.
    
[Positive Scenario] System User - Valid Username and Password
    Create System User    tester2    password@1234    password@1234
    
    @{args}    Create List   //h1[contains(text(),'System User List')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User was transitioned to System User List page.
    ...    i_fail_message=User was not transitioned to System User List page.

[Negative Scenario] System User - Existing User
    Create System User    tester2    password@1234    password@1234
    
    @{args}    Create List    ${Form.SystemUser.Username.Txt}${errors}    A user with that username already exists. 
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
    
    @{args}    Create List   //h1[contains(text(),'Create System User')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.
    
[Positive Scenario] System User - View
    &{i_row}    Create Dictionary
    ...    Username:=tester2
    View System User   ${i_row}    tester2    
    
[Positive Scenario] System User - Update
    &{i_row}    Create Dictionary
    ...    Username:=tester2               
    Update System User    ${i_row}    i_username=tester2_updated    i_password=password@1234    i_password_confirmation=password@1234
    
[Positive Scenario] System User - Delete
    &{i_row}    Create Dictionary
    ...    Username:=tester2_updated    
    Delete System User    ${i_row}   

    @{args}    Create List   //h1[contains(text(),'System User List')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User was transitioned to System User List page.
    ...    i_fail_message=User was not transitioned to System User List page.
    