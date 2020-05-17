*** Settings ***
Library    SeleniumLibrary
Library    String      
Library    Collections          
Resource    pageobjects.robot

*** Keywords ***
Launch Cloud Bank
    Open Browser    http://cloudvr.pythonanywhere.com/bank/login    chrome
    Maximize Browser Window

Input Username and Password Then Click Login
    [Arguments]    ${i_username}    ${i_password}
    Input Text    ${Page.Login.Username.Txt}    ${i_username}
    Input Text    ${Page.Login.Password.Txt}    ${i_password}
    Click Button    ${Page.Login.Login.Btn}
    
Launch Cloud Bank and Login
    [Arguments]    ${i_username}    ${i_password}
    Launch Cloud Bank
    Input Username and Password Then Click Login    ${i_username}    ${i_password}
    
Create System User
    [Arguments]    ${i_username}    ${i_password}    ${i_password_confirmation}
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}      
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewSystemUser.Link}       
    Click Element    ${Sidebar.StaticData.NewSystemUser.Link} 
    Input Text    ${Form.SystemUser.Username.Txt}    ${i_username}
    Input Text    ${Form.SystemUser.Password.Txt}    ${i_password}
    Input Text    ${Form.SystemUser.PasswordConfirmation.Txt}    ${i_password_confirmation}
    Click Element    ${Form.Common.Confirm.Btn}
    
Update System User
    [Arguments]    ${row}    ${i_username}=${EMPTY}    ${i_password}=${EMPTY}    ${i_password_confirmation}=${EMPTY}
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}      
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewSystemUser.Link}       
    Click Element    ${Sidebar.StaticData.SystemUserList.Link}
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Run Keyword If    '${i_username}'!='${EMPTY}'    Input Text    ${Form.SystemUser.Username.Txt}    ${i_username}
    Run Keyword If    '${i_password}'!='${EMPTY}'    Input Text    ${Form.SystemUser.Password.Txt}    ${i_password}
    Run Keyword If    '${i_password_confirmation}'!='${EMPTY}'    Input Text    ${Form.SystemUser.PasswordConfirmation.Txt}    ${i_password_confirmation}
    Click Element    ${Form.Common.Confirm.Btn}
        
   
Create Client
    [Arguments]    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewClient.Link}    
    Click Element    ${Sidebar.StaticData.NewClient.Link}
    Element Should Be Disabled    ${Form.Client.AccountNum.Txt}
    Element Should Be Disabled    ${Form.Client.Balance.Txt}
    Element Attribute Value Should Be    ${Form.Client.Balance.Txt}    value    0      
    # Element Text Should Be    ${Form.Client.Balance.Txt}    0     
    Input Text    ${Form.Client.FirstName.Txt}    ${i_fname}
    Input Text    ${Form.Client.LastName.Txt}    ${i_lname}    
    Input Text    ${Form.Client.Address.Txt}    ${i_addr}    
	Input Text    ${Form.Client.MobileNumber.Txt}    ${i_mobile}
	Input Text    ${Form.Client.EmailAddress.Txt}    ${i_email_addr}
	Click Element    ${Form.Common.Confirm.Btn}
	
Update Client
    [Arguments]    ${row}    ${i_fname}=${EMPTY}    ${i_lname}=${EMPTY}    ${i_addr}=${EMPTY}    ${i_mobile}=${EMPTY}    ${i_email_addr}=${EMPTY}
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}    
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Run Keyword If    '${i_fname}'!='${EMPTY}'    Input Text    ${Form.Client.FirstName.Txt}    ${i_fname}
    Run Keyword If    '${i_lname}'!='${EMPTY}'    Input Text    ${Form.Client.LastName.Txt}    ${i_lname}    
    Run Keyword If    '${i_addr}'!='${EMPTY}'    Input Text    ${Form.Client.Address.Txt}    ${i_addr}    
	Run Keyword If    '${i_mobile}'!='${EMPTY}'    Input Text    ${Form.Client.MobileNumber.Txt}    ${i_mobile}
	Run Keyword If    '${i_email_addr}'!='${EMPTY}'    Input Text    ${Form.Client.EmailAddress.Txt}    ${i_email_addr}
	Click Element    ${Form.Common.Confirm.Btn}
                	
New Deposit
    [Arguments]    ${i_client}    ${i_amt}    
    Click Element    ${Sidebar.Transactions.Deposit.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.NewDeposit.Link}    
    Click Element    ${Sidebar.Transactions.NewDeposit.Link}
    Element Should Be Disabled    ${Form.DepositTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Currency.Txt}
    Select From List By Label    ${Form.DepositTransaction.Client.Cbo}    ${i_client}
    Input Text    ${Form.DepositTransaction.DepositAmount.Txt}    ${i_amt}
	Click Element    ${Form.Common.Confirm.Btn}     
	
New Withdraw
    [Arguments]    ${i_client}    ${i_amt}    
    Click Element    ${Sidebar.Transactions.Withdraw.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.NewWithdraw.Link}    
    Click Element    ${Sidebar.Transactions.NewWithdraw.Link}
    Element Should Be Disabled    ${Form.WithdrawTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Currency.Txt}
    Select From List By Label    ${Form.WithdrawTransaction.Client.Cbo}    ${i_client}
    Input Text    ${Form.WithdrawTransaction.WithdrawAmount.Txt}    ${i_amt}
	Click Element    ${Form.Common.Confirm.Btn}  
	
New Transfer
    [Arguments]    ${i_from_client}    ${i_to_client}    ${i_amt}    
    Click Element    ${Sidebar.Transactions.Transfer.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.NewTransfer.Link}    
    Click Element    ${Sidebar.Transactions.NewTransfer.Link}
    Element Should Be Disabled    ${Form.TransferTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Currency.Txt}
    Select From List By Label    ${Form.TransferTransaction.FromClient.Cbo}    ${i_from_client}
    Select From List By Label    ${Form.TransferTransaction.ToClient.Cbo}    ${i_to_client}
    Input Text    ${Form.TransferTransaction.FromClient.Cbo}    ${i_amt}
	Click Element    ${Form.Common.Confirm.Btn}  
	
Logout
    Click Element    ${Topbar.Profile.ProfileIcon.Link}    
    Wait Until Element Is Visible    ${Topbar.Profile.Logout.Link}    
    Click Element    ${Topbar.Profile.Logout.Link}  
    Wait Until Element Is Visible    ${Popup.ReadyToLeave.Logout.Btn}      
    Click Element    ${Popup.ReadyToLeave.Logout.Btn}  
    Close Browser
    
    
Table Keyword
    [Arguments]    ${table_locator}    ${dict_row}        
    &{header_dict}    Create Dictionary    
    ${header_count}    Get Element Count    ${table_locator}/thead/tr/th
    FOR    ${header_index}    IN RANGE    1    ${header_count}+1    # +1 because ending range is exclusive
        ${header_text}    Get Text    ${table_locator}/thead/tr/th[${header_index}]
        Set To Dictionary    ${header_dict}    ${header_text}=${header_index}
    END
    
    ${search_row_keys}    Get Dictionary Keys    ${dict_row}
    ${search_row_items}    Get Dictionary Values    ${dict_row}
    ${is_first_item}    ${first_row_key}    ${first_row_item}    Set Variable    ${True}    ${EMPTY}    ${EMPTY}
    FOR    ${key}    ${item}    IN ZIP    ${search_row_keys}    ${search_row_items}
        ${first_row_key}    Set Variable If    ${is_first_item}==${True}    ${key}    ${first_row_key}    
        ${first_row_item}    Set Variable If    ${is_first_item}==${True}    ${item}    ${first_row_item}
        Dictionary Should Contain Key    ${header_dict}    ${key}    The header you are searching for does not exist in the table.
        ${is_first_item}    Set Variable    ${False}
    END
                 
    ${header_index}    Set Variable    &{header_dict}[${first_row_key}]
    ${row_count}    Get Element Count    ${table_locator}/tbody/tr
    ${row_found}    Set Variable    ${False}     
    FOR    ${row_index}    IN RANGE    2    ${row_count}+2
        ${row_item}    Get Table Cell    ${table_locator}    ${row_index}    ${header_index}
        ${row_found}    Run Keyword If    '${row_item}'=='${first_row_item}'    Handle Row    ${table_locator}    ${row_index}    ${header_dict}    ${search_row_keys}    ${search_row_items}
        ...    ELSE    Set Variable    ${False}
        Exit For Loop If    ${row_found}==${True}  
    END
    Run Keyword If    ${row_found}==${False}    Fail    Row not found
    ${index}    Set Variable    ${row_index-1}     
    # Click Element    ${table_locator}/tbody/tr[${index}]/td[1]/a    
    [Return]    ${index}

Handle Row
    [Arguments]    ${locator}    ${row_index}    ${header_dict}    ${search_row_keys}    ${search_row_items}
    ${row_found}    Set Variable    ${False}
    FOR    ${row_key}    ${row_item}	IN ZIP    ${search_row_keys}    ${search_row_items}
        ${header_index}    Set Variable    &{headerDict}[${row_key}]    # gets index based on the header text 
        ${cell}    Get Table Cell    ${locator}    ${row_index}    ${header_index}              
        ${row_item_found}    Run Keyword And Return Status    Should Be Equal    ${row_item}    ${cell}
        ${row_found}    Set Variable If    ${row_item_found}==${True}    ${True}    ${False}
        Exit For Loop If    '${row_item_found}'=='False'
    END
    [Return]    ${row_found}      