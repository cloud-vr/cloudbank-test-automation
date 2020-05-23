*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page and Login    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}        
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Test Cases ***
[Positive Scenario] Search - System Users
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}      
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewSystemUser.Link}       
    Click Element    ${Sidebar.StaticData.SystemUserList.Link}
    Input Text    ${Page.Common.SearchFor.Txt}    1
    Click Element    ${Page.Common.SearchFor.Btn}
    Page Should Contain Element    //h1[contains(text(),'System User List')]

[Positive Scenario] Search - Clients
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}
    Input Text    ${Page.Common.SearchFor.Txt}    1
    Click Element    ${Page.Common.SearchFor.Btn}
    Page Should Contain Element    //h1[contains(text(),'Client List')]
    
[Positive Scenario] Search - Deposit
    Click Element    ${Sidebar.Transactions.Deposit.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.DepositTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.DepositTransactionList.Link}
    Input Text    ${Page.Common.SearchFor.Txt}    1
    Click Element    ${Page.Common.SearchFor.Btn}
    Page Should Contain Element    //h1[contains(text(),'Deposit Transaction List')]
   
[Positive Scenario] Search - Withdrawal
    Click Element    ${Sidebar.Transactions.Withdraw.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.WithdrawTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.WithdrawTransactionList.Link}
    Input Text    ${Page.Common.SearchFor.Txt}    1
    Click Element    ${Page.Common.SearchFor.Btn}
    Page Should Contain Element    //h1[contains(text(),'Withdraw Transaction List')]
    
[Positive Scenario] Search - Transfer
    Click Element    ${Sidebar.Transactions.Transfer.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.TransferTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.TransferTransactionList.Link}    
    Input Text    ${Page.Common.SearchFor.Txt}    1
    Click Element    ${Page.Common.SearchFor.Btn}
    Page Should Contain Element    //h1[contains(text(),'Transfer Transaction List')]