*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${cloudbank_logo}    

*** Test Cases ***
Negative Scenario - Blank Fields
    New Deposit    ---------    \
    ${element}    Get WebElement    ${deposit_trx_client}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please select an item in the list.
    Run Keyword And Continue On Failure    Page Should Contain Element    ${deposit_trx_date}     

Positive Scenario - All Field Populated
    # Dashboard Initial Values
    Click Element    ${navlink_dashboard}
    ${raw_amt}    Get Text    ${dashboard_aggregate_deposit}
    ${initial_deposit_amt}    Remove String    ${raw_amt}     PHP
    ${initial_deposit_amt}    Convert To Number    ${initial_deposit_amt}  
    ${initial_number_trx}    Get Text    ${dashboard_number_trx}
    ${initial_number_trx}    Convert To Number    ${initial_number_trx}    
    # Client Initial Values
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}  
    &{row}    Create Dictionary    First Name:=Yuffie    Last Name:=Kisaragi
    ${row_index}    Table Keyword    ${table_in_list_page}    ${row}
    &{header_dict}    Create Dictionary    
    ${header_count}    Get Element Count    ${table_in_list_page}/thead/tr/th
    FOR    ${header_index}    IN RANGE    1    ${header_count}+1    # +1 because ending range is exclusive
        ${header_text}    Get Text    ${table_in_list_page}/thead/tr/th[${header_index}]
        Set To Dictionary    ${header_dict}    ${header_text}=${header_index}
    END
    ${col_index}    Set Variable    &{header_dict}[Balance:]  
    ${initial_balance}    Get Table Cell    ${table_in_list_page}    ${row_index+1}    ${col_index}  
    ${initial_balance}    Convert To Number    ${initial_balance}             
    # Deposit Transaction  
    New Deposit    Yuffie Kisaragi    1000
    Page Should Contain Element    //h1[contains(text(),'Deposit Transaction List')]
    # Dashboard Post Values
    Click Element    ${navlink_dashboard}
    ${raw_amt}    Get Text    ${dashboard_aggregate_deposit}
    ${post_deposit_amt}    Remove String    ${raw_amt}     PHP
    ${post_deposit_amt}    Convert To Number    ${post_deposit_amt}
    Should Be Equal    ${initial_deposit_amt+1000}    ${post_deposit_amt}
    ${post_number_trx}    Get Text    ${dashboard_number_trx}
    ${post_number_trx}    Convert To Number    ${post_number_trx}    
    Should Be Equal    ${initial_number_trx+1}    ${post_number_trx}      
    # Client Post Values  
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}  
    ${post_balance}    Get Table Cell    ${table_in_list_page}    ${row_index+1}    ${col_index}
    ${post_balance}    Convert To Number    ${post_balance}
    Should Be Equal    ${initial_balance+1000}    ${post_balance}     
    
View
    Click Element    ${navlink_deposit_collapsed}    
    Wait Until Element Is Visible    ${navlink_deposit_list}    
    Click Element    ${navlink_deposit_list}
    Click Element    ${table_in_list_page}/tbody/tr[1]/td[1]/a
    Element Should Be Disabled    ${deposit_trx_date}
    Element Should Be Disabled    ${deposit_trx_ref}
    Element Should Be Disabled    ${deposit_trx_status}
    Element Should Be Disabled    ${deposit_trx_curr}
    Element Should Be Disabled    ${deposit_trx_client}   
    Element Should Be Disabled    ${deposit_trx_deposit_amt}  
    Click Element    ${form_btn_back_to_list}      
    