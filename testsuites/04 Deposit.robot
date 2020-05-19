*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${s_deposit_trx_ref}

*** Test Cases ***
Negative Scenario - Blank Deposit Transaction Fields
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

Positive Scenario - All Deposit Fields Populated
    # Dashboard Initial Values
    GoTo Dashboard
    ${l_initial_dep_amt}    Get Dashboard Aggregate Deposit Value  
    ${l_initial_number_of_trx}    Get Dashboard Number Of Transactions Value    
    
    # Client Initial Values
    GoTo Client List Page
    &{row}    Create Dictionary    First Name:=Yuffie    Last Name:=Kisaragi
    ${row_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    &{header_dict}    Create Dictionary    
    ${header_count}    Get Element Count    ${Page.Common.ObjectListTable.Tbl}/thead/tr/th
    FOR    ${header_index}    IN RANGE    1    ${header_count}+1    # +1 because ending range is exclusive
        ${header_text}    Get Text    ${Page.Common.ObjectListTable.Tbl}/thead/tr/th[${header_index}]
        Set To Dictionary    ${header_dict}    ${header_text}=${header_index}
    END
    ${col_index}    Set Variable    &{header_dict}[Balance:]  
    ${initial_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${row_index+1}    ${col_index}  
    ${initial_balance}    Convert To Number    ${initial_balance} 
                
    # Deposit Transaction  
    ${l_trx_ref}    Create Deposit Transaction    Yuffie Kisaragi    1000
    Set Suite Variable    ${s_deposit_trx_ref}    ${l_trx_ref}

    @{args}    Create List    //h1[contains(text(),'Deposit Transaction List')]
    VERIFY    Page Should Contain Element    ${args}    
    ...    i_pass_message=User was transitioned to the Deposit Transaction List page.
    ...    i_fail_message=User was not transitioned to the Deposit Transaction List page. 
    
    # Dashboard Post Values
    GoTo Dashboard
    ${l_post_dep_amt}    Get Dashboard Aggregate Deposit Value  
    ${l_post_number_of_trx}    Get Dashboard Number Of Transactions Value
    
    @{args}    Create List    ${l_initial_dep_amt+1000}    ${l_post_dep_amt}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Aggregate Deposit Amount updated correctly.
    ...    i_fail_message=Dashboard Aggregate Deposit Amount not updated correctly.       
        
    @{args}    Create List    ${l_initial_number_of_trx+1}    ${l_post_number_of_trx}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Number Of Transactions updated correctly.
    ...    i_fail_message=Dashboard Number Of Transactions not updated correctly.       

    # Client Post Values  
    GoTo Client List Page
    ${post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${row_index+1}    ${col_index}
    ${post_balance}    Convert To Number    ${post_balance}
         
    @{args}    Create List    ${initial_balance-100}    ${post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly.       
    
Positive Scenario - View Deposit Transaction
    &{l_row}    Create Dictionary    Trx ref:=${s_deposit_trx_ref}
    View Deposit Transaction    ${l_row}    i_client=Yuffie Kisaragi    i_amt=1000.0     
    