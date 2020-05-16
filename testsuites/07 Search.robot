*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${cloudbank_logo}    

*** Test Cases ***
Users
    Click Element    ${navlink_system_users_collapsed}      
    Wait Until Element Is Visible    ${navlink_system_users_new}       
    Click Element    ${navlink_system_users_list}
    Input Text    ${search_bar}    1
    Click Element    ${search_btn}
    Page Should Contain Element    //h1[contains(text(),'System User List')]

Clients
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}
    Input Text    ${search_bar}    1
    Click Element    ${search_btn}
    Page Should Contain Element    //h1[contains(text(),'Client List')]
    
    
Deposit
    Click Element    ${navlink_deposit_collapsed}    
    Wait Until Element Is Visible    ${navlink_deposit_list}    
    Click Element    ${navlink_deposit_list}
    Input Text    ${search_bar}    1
    Click Element    ${search_btn}
    Page Should Contain Element    //h1[contains(text(),'Deposit Transaction List')]
   
Withdraw
    Click Element    ${navlink_withdraw_collapsed}    
    Wait Until Element Is Visible    ${navlink_withdraw_list}    
    Click Element    ${navlink_withdraw_list}
    Input Text    ${search_bar}    1
    Click Element    ${search_btn}
    Page Should Contain Element    //h1[contains(text(),'Withdraw Transaction List')]
    
Transfer
    Click Element    ${navlink_transfer_collapsed}    
    Wait Until Element Is Visible    ${navlink_transfer_list}    
    Click Element    ${navlink_transfer_list}    
    Input Text    ${search_bar}    1
    Click Element    ${search_btn}
    Page Should Contain Element    //h1[contains(text(),'Transfer Transaction List')]