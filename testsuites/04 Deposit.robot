*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}        
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${s_deposit_trx_ref}

*** Test Cases ***
[Negative Scenario] Deposit Transaction - All Fields Are Empty
    Create Deposit Transaction    ---------    ${EMPTY}
    
    ${l_validation_message}    Get Validation Message    ${Form.DepositTransaction.Client.Cbo}    

    @{args}    Create List    ${l_validation_message}    Please select an item in the list.
    VERIFY    Should Be Equal    ${args}    
    ...    i_pass_message=Validation message "Please fill out this field." displayed successfully.
    ...    i_fail_message=Validation message "Please fill out this field." not displayed successfully.

    @{args}    Create List    //h1[contains(text(),'Deposit Transaction')]
    VERIFY    Page Should Contain Element    ${args}    
    ...    i_pass_message=User remained in the Deposit Transaction page.
    ...    i_fail_message=User was transitioned to a different page. 

[Positive Scenario] Deposit Transaction - All Fields Are Populated Correctly
    # Dashboard Initial Values
    GoTo Dashboard
    ${l_initial_dep_amt}    Get Dashboard Aggregate Deposit Value  
    ${l_initial_number_of_trx}    Get Dashboard Number Of Transactions Value    
    
    # Client Initial Values
    GoTo Client List Page
    &{l_client_dict}    Create Dictionary    First Name:=Yuffie    Last Name:=Kisaragi
    ${initial_balance}    Get Client Balance    ${l_client_dict}
                
    # Deposit Transaction
    ${l_dep_amt}    Set Variable    1000  
    ${l_trx_ref}    Create Deposit Transaction    Yuffie Kisaragi    ${l_dep_amt}
    Set Suite Variable    ${s_deposit_trx_ref}    ${l_trx_ref}

    @{args}    Create List    //h1[contains(text(),'Deposit Transaction List')]
    VERIFY    Page Should Contain Element    ${args}    
    ...    i_pass_message=User was transitioned to the Deposit Transaction List page.
    ...    i_fail_message=User was not transitioned to the Deposit Transaction List page. 
    
    # Dashboard Post Values
    GoTo Dashboard
    ${l_post_dep_amt}    Get Dashboard Aggregate Deposit Value  
    ${l_post_number_of_trx}    Get Dashboard Number Of Transactions Value
    
    @{args}    Create List    ${l_initial_dep_amt+${l_dep_amt}}    ${l_post_dep_amt}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Aggregate Deposit Amount updated correctly.
    ...    i_fail_message=Dashboard Aggregate Deposit Amount not updated correctly.       
        
    @{args}    Create List    ${l_initial_number_of_trx+1}    ${l_post_number_of_trx}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Number Of Transactions updated correctly.
    ...    i_fail_message=Dashboard Number Of Transactions not updated correctly.       

    # Client Post Values  
    GoTo Client List Page
    ${post_balance}    Get Client Balance    ${l_client_dict}
         
    @{args}    Create List    ${initial_balance+${l_dep_amt}}    ${post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly.       
    
[Positive Scenario] Deposit Transaction - View
    &{l_row}    Create Dictionary    Trx ref:=${s_deposit_trx_ref}
    View Deposit Transaction    ${l_row}    i_client=Yuffie Kisaragi    i_amt=1000.0
    