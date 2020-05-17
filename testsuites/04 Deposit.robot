*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***
Negative Scenario - Blank Fields
    New Deposit    ---------    \
    ${element}    Get WebElement    ${Form.DepositTransaction.Client.Cbo}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please select an item in the list.
    Run Keyword And Continue On Failure    Page Should Contain Element    ${Form.DepositTransaction.TrxDate.Txt}     

Positive Scenario - All Field Populated
    # Dashboard Initial Values
    Click Element    ${Sidebar.CloudBank.Dashboard.Link}
    ${raw_amt}    Get Text    ${Page.Dashboard.AggregateDeposit.Lbl}
    ${initial_deposit_amt}    Remove String    ${raw_amt}     PHP
    ${initial_deposit_amt}    Convert To Number    ${initial_deposit_amt}  
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
    # Deposit Transaction  
    New Deposit    Yuffie Kisaragi    1000
    Page Should Contain Element    //h1[contains(text(),'Deposit Transaction List')]
    # Dashboard Post Values
    Click Element    ${Sidebar.CloudBank.Dashboard.Link}
    ${raw_amt}    Get Text    ${Page.Dashboard.AggregateDeposit.Lbl}
    ${post_deposit_amt}    Remove String    ${raw_amt}     PHP
    ${post_deposit_amt}    Convert To Number    ${post_deposit_amt}
    Should Be Equal    ${initial_deposit_amt+1000}    ${post_deposit_amt}
    ${post_number_trx}    Get Text    ${Page.Dashboard.NumberOfTransactions.Lbl}
    ${post_number_trx}    Convert To Number    ${post_number_trx}    
    Should Be Equal    ${initial_number_trx+1}    ${post_number_trx}      
    # Client Post Values  
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}  
    ${post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${row_index+1}    ${col_index}
    ${post_balance}    Convert To Number    ${post_balance}
    Should Be Equal    ${initial_balance+1000}    ${post_balance}     
    
View
    Click Element    ${Sidebar.Transactions.Deposit.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.DepositTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.DepositTransactionList.Link}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[1]/td[1]/a
    Element Should Be Disabled    ${Form.DepositTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Currency.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Client.Cbo}   
    Element Should Be Disabled    ${Form.DepositTransaction.DepositAmount.Txt}  
    Click Element    ${Form.Common.BackToList.Btn}      
    