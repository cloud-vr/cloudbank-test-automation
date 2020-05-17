*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***
Negative Scenario - Blank Fields
    New Transfer    ---------    ---------    \
    ${element}    Get WebElement    ${Form.TransferTransaction.Status.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please select an item in the list.
    Run Keyword And Continue On Failure    Page Should Contain Element    ${Form.WithdrawTransaction.TrxDate.Txt}     

Positive Scenario - All Field Populated   
    # Dashboard Initial Values
    Click Element    ${Sidebar.CloudBank.Dashboard.Link}
    ${raw_amt}    Get Text    ${Page.Dashboard.AggregateTransfer.Lbl}
    ${initial_transfer_amt}    Remove String    ${raw_amt}     PHP
    ${initial_transfer_amt}    Convert To Number    ${initial_transfer_amt}  
    ${initial_number_trx}    Get Text    ${Page.Dashboard.NumberOfTransactions.Lbl}
    ${initial_number_trx}    Convert To Number    ${initial_number_trx}        
    # Client Initial Values
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}  
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
    New Transfer    Yuffie Kisaragi    Cloud Strife    100
    Page Should Contain Element    //h1[contains(text(),'Transfer Transaction List')]
    # Dashboard Post Values
    Click Element    ${Sidebar.CloudBank.Dashboard.Link}
    ${raw_amt}    Get Text    ${Page.Dashboard.AggregateTransfer.Lbl}
    ${post_transfer_amt}    Remove String    ${raw_amt}     PHP
    ${post_transfer_amt}    Convert To Number    ${post_transfer_amt} 
    Should Be Equal    ${initial_transfer_amt+100}    ${post_transfer_amt}     
    ${post_number_trx}    Get Text    ${Page.Dashboard.NumberOfTransactions.Lbl}
    ${post_number_trx}    Convert To Number    ${post_number_trx}        
    # Client Post Values
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}  
    # from client 
    ${from_client_post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${from_client_row_index+1}    ${col_index}  
    ${from_client_post_balance}    Convert To Number    ${from_client_post_balance}
    Should Be Equal    ${from_client_initial_balance-100}    ${from_client_post_balance}    
    # to client   
    ${to_client_post_balance}    Get Table Cell    ${Page.Common.ObjectListTable.Tbl}    ${to_client_row_index+1}    ${col_index}  
    ${to_client_post_balance}    Convert To Number    ${to_client_post_balance}  
    Should Be Equal    ${to_client_initial_balance+100}    ${to_client_post_balance}         

View
    Click Element    ${Sidebar.Transactions.Transfer.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.TransferTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.TransferTransactionList.Link}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[1]/td[1]/a 
    Element Should Be Disabled    ${Form.TransferTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Currency.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.FromClient.Cbo}
    Click Element    ${Form.Common.BackToList.Btn} 