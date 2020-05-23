*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${s_transfer_trx_ref}

*** Test Cases ***
[Negative Scenario] Transfer Transaction - All Fields Are Empty
    Create Transfer Transaction    ---------    ---------    ${EMPTY}

    ${l_validation_message}    Get Validation Message    ${Form.TransferTransaction.FromClient.Cbo}    

    @{args}    Create List    ${l_validation_message}    Please select an item in the list.
    VERIFY    Should Be Equal    ${args}    
    ...    i_pass_message=Validation message "Please fill out this field." displayed successfully.
    ...    i_fail_message=Validation message "Please fill out this field." not displayed successfully.

    @{args}    Create List    //h1[contains(text(),'Transfer Transaction')]
    VERIFY    Page Should Contain Element    ${args}    
    ...    i_pass_message=User remained in the Withdraw Transaction page.
    ...    i_fail_message=User was transitioned to a different page. 

[Positive Scenario] Transfer Transaction - All Fields Are Populated Correctly
    # Dashboard Initial Values
    GoTo Dashboard
    ${l_initial_trans_amt}    Get Dashboard Aggregate Transfer Value  
    ${l_initial_number_of_trx}    Get Dashboard Number Of Transactions Value            

    # Client Initial Values
    GoTo Client List Page
    # from client
    &{l_from_client_dict}    Create Dictionary    First Name:=Yuffie    Last Name:=Kisaragi
    ${l_from_client_initial_balance}    Get Client Balance    ${l_from_client_dict}
    # to client
    &{l_to_client_dict}    Create Dictionary    First Name:=Cloud    Last Name:=Strife
    ${l_to_client_initial_balance}    Get Client Balance    ${l_to_client_dict}

    # Transfer Transaction
    ${l_transfer_amt}    Set Variable    100
    ${l_trx_ref}    Create Transfer Transaction    Yuffie Kisaragi    Cloud Strife    ${l_transfer_amt}
    Set Suite Variable    ${s_transfer_trx_ref}    ${l_trx_ref}
    Page Should Contain Element    //h1[contains(text(),'Transfer Transaction List')]

    # Dashboard Post Values
    GoTo Dashboard
    ${l_post_trans_amt}    Get Dashboard Aggregate Transfer Value  
    ${l_post_number_of_trx}    Get Dashboard Number Of Transactions Value    
  
    @{args}    Create List    ${l_initial_trans_amt+${l_transfer_amt}}    ${l_post_trans_amt}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Aggregate Transfer Amount updated correctly.
    ...    i_fail_message=Dashboard Aggregate Transfer Amount not updated correctly.       
        
    @{args}    Create List    ${l_initial_number_of_trx+1}    ${l_post_number_of_trx}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Number Of Transactions updated correctly.
    ...    i_fail_message=Dashboard Number Of Transactions not updated correctly.       

    # Client Post Values
    GoTo Client List Page
    # from client
    ${l_from_client_post_balance}    Get Client Balance    ${l_from_client_dict}
    
    @{args}    Create List    ${l_from_client_initial_balance-${l_transfer_amt}}    ${l_from_client_post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly. 
    # to client
    ${l_to_client_post_balance}    Get Client Balance    ${l_to_client_dict}

    @{args}    Create List    ${l_to_client_initial_balance+${l_transfer_amt}}    ${l_to_client_post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly.

[Positive Scenario] Transfer Transaction - View
    &{l_row}    Create Dictionary    Trx ref:=${s_transfer_trx_ref}
    View Transfer Transaction    ${l_row}    i_from_client=Yuffie Kisaragi    i_to_client=Cloud Strife    i_amt=100.0  