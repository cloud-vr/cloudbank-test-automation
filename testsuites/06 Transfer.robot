*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${s_transfer_trx_ref}

*** Test Cases ***
Negative Scenario - Blank Transfer Fields
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

Positive Scenario - All Transfer Fields Populated   
    # Dashboard Initial Values
    GoTo Dashboard
    ${l_initial_trans_amt}    Get Dashboard Aggregate Transfer Value  
    ${l_initial_number_of_trx}    Get Dashboard Number Of Transactions Value            

    # Client Initial Values
    GoTo Client List Page
    &{header_dict}    Create Dictionary    
    ${header_count}    Get Element Count    ${Page.Common.ObjectListTable.Tbl}/thead/tr/th
    FOR    ${header_index}    IN RANGE    1    ${header_count}+1    # +1 because ending range is exclusive
        ${header_text}    Get Text    ${Page.Common.ObjectListTable.Tbl}/thead/tr/th[${header_index}]
        Set To Dictionary    ${header_dict}    ${header_text}=${header_index}
    END
    # from client
    &{row}    Create Dictionary    First Name:=Yuffie    Last Name:=Kisaragi
    ${from_client_row_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    ${col_index}    Set Variable    &{header_dict}[Balance:]  
    ${from_client_initial_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${from_client_row_index+1}    ${col_index}  
    ${from_client_initial_balance}    Convert To Number    ${from_client_initial_balance}
    # to client  
    &{row}    Create Dictionary    First Name:=Cloud    Last Name:=Strife
    ${to_client_row_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    ${to_client_initial_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${to_client_row_index+1}    ${col_index}  
    ${to_client_initial_balance}    Convert To Number    ${to_client_initial_balance}    

    # Transfer
    ${l_trx_ref}    Create Transfer Transaction    Yuffie Kisaragi    Cloud Strife    100
    Set Suite Variable    ${s_transfer_trx_ref}    ${l_trx_ref}
    Page Should Contain Element    //h1[contains(text(),'Transfer Transaction List')]

    # Dashboard Post Values
    GoTo Dashboard
    ${l_post_trans_amt}    Get Dashboard Aggregate Transfer Value  
    ${l_post_number_of_trx}    Get Dashboard Number Of Transactions Value    
  
    @{args}    Create List    ${l_initial_trans_amt+100}    ${l_post_trans_amt}    
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
    ${from_client_post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${from_client_row_index+1}    ${col_index}  
    ${from_client_post_balance}    Convert To Number    ${from_client_post_balance}
    Should Be Equal    ${from_client_initial_balance-100}    ${from_client_post_balance}    
    # to client   
    ${to_client_post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${to_client_row_index+1}    ${col_index}  
    ${to_client_post_balance}    Convert To Number    ${to_client_post_balance}  
    Should Be Equal    ${to_client_initial_balance+100}    ${to_client_post_balance}         

Positive Scenario - View Transfer Transaction
    &{l_row}    Create Dictionary    Trx ref:=${s_transfer_trx_ref}
    View Transfer Transaction    ${l_row}    i_from_client=Yuffie Kisaragi    i_to_client=Cloud Strife    i_amt=100.0  