*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${cloudbank_logo}    

*** Test Cases ***
Negative Scenario - Blank Fields
    New Transfer    ---------    ---------    \
    ${element}    Get WebElement    ${transfer_trx_from_client}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please select an item in the list.
    Run Keyword And Continue On Failure    Page Should Contain Element    ${withdraw_trx_date}     

Positive Scenario - All Field Populated   
    # Dashboard Initial Values
    Click Element    ${navlink_dashboard}
    ${raw_amt}    Get Text    ${dashboard_aggregate_transfer}
    ${initial_transfer_amt}    Remove String    ${raw_amt}     PHP
    ${initial_transfer_amt}    Convert To Number    ${initial_transfer_amt}  
    ${initial_number_trx}    Get Text    ${dashboard_number_trx}
    ${initial_number_trx}    Convert To Number    ${initial_number_trx}        
    # Client Initial Values
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}  
    &{header_dict}    Create Dictionary    
    ${header_count}    Get Element Count    ${table_in_list_page}/thead/tr/th
    FOR    ${header_index}    IN RANGE    1    ${header_count}+1    # +1 because ending range is exclusive
        ${header_text}    Get Text    ${table_in_list_page}/thead/tr/th[${header_index}]
        Set To Dictionary    ${header_dict}    ${header_text}=${header_index}
    END
    # from client
    &{row}    Create Dictionary    First Name:=Yuffie    Last Name:=Kisaragi
    ${from_client_row_index}    Table Keyword    ${table_in_list_page}    ${row}
    ${col_index}    Set Variable    &{header_dict}[Balance:]  
    ${from_client_initial_balance}    Get Table Cell    ${table_in_list_page}    ${from_client_row_index+1}    ${col_index}  
    ${from_client_initial_balance}    Convert To Number    ${from_client_initial_balance}
    # to client  
    &{row}    Create Dictionary    First Name:=Cloud    Last Name:=Strife
    ${to_client_row_index}    Table Keyword    ${table_in_list_page}    ${row}
    ${to_client_initial_balance}    Get Table Cell    ${table_in_list_page}    ${to_client_row_index+1}    ${col_index}  
    ${to_client_initial_balance}    Convert To Number    ${to_client_initial_balance}    
    # Transfer
    New Transfer    Yuffie Kisaragi    Cloud Strife    100
    Page Should Contain Element    //h1[contains(text(),'Transfer Transaction List')]
    # Dashboard Post Values
    Click Element    ${navlink_dashboard}
    ${raw_amt}    Get Text    ${dashboard_aggregate_transfer}
    ${post_transfer_amt}    Remove String    ${raw_amt}     PHP
    ${post_transfer_amt}    Convert To Number    ${post_transfer_amt} 
    Should Be Equal    ${initial_transfer_amt+100}    ${post_transfer_amt}     
    ${post_number_trx}    Get Text    ${dashboard_number_trx}
    ${post_number_trx}    Convert To Number    ${post_number_trx}        
    # Client Post Values
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}  
    # from client 
    ${from_client_post_balance}    Get Table Cell    ${table_in_list_page}    ${from_client_row_index+1}    ${col_index}  
    ${from_client_post_balance}    Convert To Number    ${from_client_post_balance}
    Should Be Equal    ${from_client_initial_balance-100}    ${from_client_post_balance}    
    # to client   
    ${to_client_post_balance}    Get Table Cell    ${table_in_list_page}    ${to_client_row_index+1}    ${col_index}  
    ${to_client_post_balance}    Convert To Number    ${to_client_post_balance}  
    Should Be Equal    ${to_client_initial_balance+100}    ${to_client_post_balance}         

View
    Click Element    ${navlink_transfer_collapsed}    
    Wait Until Element Is Visible    ${navlink_transfer_list}    
    Click Element    ${navlink_transfer_list}
    Click Element    ${table_in_list_page}/tbody/tr[1]/td[1]/a 
    Element Should Be Disabled    ${transfer_trx_date}
    Element Should Be Disabled    ${transfer_trx_ref}
    Element Should Be Disabled    ${transfer_trx_status}
    Element Should Be Disabled    ${transfer_trx_curr}
    Element Should Be Disabled    ${transfer_trx_from_client}
    Element Should Be Disabled    ${transfer_trx_to_client}
    Element Should Be Disabled    ${transfer_trx_transfer_amt}
    Click Element    ${form_btn_back_to_list} 