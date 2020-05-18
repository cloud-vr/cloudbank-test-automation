*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${s_withdraw_trx_ref}

*** Test Cases ***
Negative Scenario - Blank Fields
    Create Withdraw Transaction    ---------    ${EMPTY}
    ${element}    Get WebElement    ${Form.WithdrawTransaction.Client.Cbo}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please select an item in the list.
    Page Should Contain Element    ${Form.WithdrawTransaction.TrxDate.Txt}     

Positive Scenario - All Field Populated    
    # Dashboard Initial Values
    Click Element    ${Sidebar.CloudBank.Dashboard.Link}
    ${raw_amt}    Get Text    ${Page.Dashboard.AggregateWithdraw.Lbl}
    ${initial_withdraw_amt}    Remove String    ${raw_amt}     PHP
    ${initial_withdraw_amt}    Convert To Number    ${initial_withdraw_amt}  
    ${initial_number_trx}    Get Text    ${Page.Dashboard.NumberOfTransactions.Lbl}
    ${initial_number_trx}    Convert To Number    ${initial_number_trx}    
    # Client Initial Values
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}  
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
    # Withdraw
    ${l_trx_ref}    Create Withdraw Transaction    Yuffie Kisaragi    100
    Set Suite Variable    ${s_withdraw_trx_ref}    ${l_trx_ref}
    Page Should Contain Element    //h1[contains(text(),'Withdraw Transaction List')]       
    # Dashboard Post Values
    Click Element    ${Sidebar.CloudBank.Dashboard.Link}
    ${raw_amt}    Get Text    ${Page.Dashboard.AggregateWithdraw.Lbl}
    ${post_deposit_amt}    Remove String    ${raw_amt}     PHP
    ${post_deposit_amt}    Convert To Number    ${post_deposit_amt}
    Should Be Equal    ${initial_withdraw_amt+100}    ${post_deposit_amt}  
    ${post_number_trx}    Get Text    ${Page.Dashboard.NumberOfTransactions.Lbl}
    ${post_number_trx}    Convert To Number    ${post_number_trx}    
    Should Be Equal    ${initial_number_trx+1}    ${post_number_trx}  
    # Client Post Values  
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}  
    ${post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${row_index+1}    ${col_index}
    ${post_balance}    Convert To Number    ${post_balance}
    Should Be Equal    ${initial_balance-100}    ${post_balance} 
    
View
    &{l_row}    Create Dictionary    Trx ref:=${s_withdraw_trx_ref}
    View Withdraw Transaction    ${l_row}    i_client=Yuffie Kisaragi    i_amt=100.0
    