*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}        
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${errors}    /..//*[@class='errorlist']/li

*** Test Cases ***
[Negative Scenario] Client - All Fields Are Empty
    Create Client    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}

    ${l_validation_message}    Get Validation Message    ${Form.Client.FirstName.Txt}

    @{args}    Create List    ${l_validation_message}    Please fill out this field.        
    VERIFY    Should Be Equal    ${args}    
    ...    i_pass_message=Validation message "Please fill out this field." displayed successfully.
    ...    i_fail_message=Validation message "Please fill out this field." not displayed successfully.

    @{args}    Create List    //h1[contains(text(),'Create Client')]        
    VERIFY    Page Should Contain Element    ${args}
    ...    i_pass_message=User remained in the Create Client page.
    ...    i_fail_message=User was transitioned to a different page.      

[Positive Scenario] Client - All Fields Are Populated Correctly 
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    
    @{args}    Create List    //h1[contains(text(),'Client List')]        
    VERIFY    Page Should Contain Element    ${args}
    ...    i_pass_message=User was transitioned to the Client List page. 
    ...    i_fail_message=User was not transitioned to the Client List page. 
    
[Negative Scenario] Client - Existing Client
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    
    @{args}    Create List    ${Form.Client.EmailAddress.Txt}${errors}    Client with this Email Address already exists.
    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed.          
    
[Positive Scenario] Client - View
    &{l_row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com
    View Client    ${l_row}    i_fname=Yuffie    i_lname=Kisaragi    i_addr=Wutai    i_mobile=4    i_email_addr=yuffie@kisaragi.com        
                 
[Positive Scenario] Client - Update
    &{l_row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com                
    Update Client    ${l_row}    i_fname=Yuffie    i_lname=Kisaragi    i_mobile=69    i_email_addr=yuffie@kisaragi.com  
    
[Positive Scenario] Client - Delete
    &{l_row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com  
    Delete Client    ${l_row}
    # create client again because it is needed for the transactions
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    