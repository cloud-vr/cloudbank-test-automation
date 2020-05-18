*** Settings ***
Library    SeleniumLibrary
Library    String      
Library    Collections          
Resource    pageobjects.robot

*** Variables ***
${URL}    http://localhost:8000/bank/login
${BROWSER}    chrome

*** Keywords ***
GoTo Cloud Bank Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Form Login Populate Fields
    [Arguments]    ${i_username}    ${i_password}
    Input Text    ${Page.Login.Username.Txt}    ${i_username}
    Input Text    ${Page.Login.Password.Txt}    ${i_password}
    
GoTo Cloud Bank Page and Login
    [Arguments]    ${i_username}    ${i_password}
    GoTo Cloud Bank Page
    Form Login Populate Fields    ${i_username}    ${i_password}
    Click Button    ${Page.Login.Login.Btn}

# System User Keywords
GoTo Create System User Form
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}      
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewSystemUser.Link}       
    Click Element    ${Sidebar.StaticData.NewSystemUser.Link} 

GoTo View/Update/Delete System User Form
    [Arguments]    ${i_row}
    Click Element    ${Sidebar.StaticData.SystemUsers.Link}      
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewSystemUser.Link}       
    Click Element    ${Sidebar.StaticData.SystemUserList.Link}
    ${l_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${i_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a
    
Form System User Populate Fields
    [Arguments]    ${i_username}=${EMPTY}    ${i_password}=${EMPTY}    ${i_password_confirmation}=${EMPTY}
    Run Keyword If    '${i_username}'!='${EMPTY}'    Input Text    ${Form.SystemUser.Username.Txt}    ${i_username}
    Run Keyword If    '${i_password}'!='${EMPTY}'    Input Text    ${Form.SystemUser.Password.Txt}    ${i_password}
    Run Keyword If    '${i_password_confirmation}'!='${EMPTY}'    Input Text    ${Form.SystemUser.PasswordConfirmation.Txt}    ${i_password_confirmation}    

Form System User Verify Fields
    [Arguments]    ${i_username}=${EMPTY}
    Run Keyword If    '${i_username}'!='${EMPTY}'    Textfield Value Should Be    ${Form.SystemUser.Username.Txt}    ${i_username} 
      
Create System User
    [Arguments]    ${i_username}=${EMPTY}    ${i_password}=${EMPTY}    ${i_password_confirmation}=${EMPTY}
    GoTo Create System User Form
    Form System User Populate Fields    ${i_username}    ${i_password}    ${i_password_confirmation}
    Click Element    ${Form.Common.Confirm.Btn}

View System User
    [Arguments]    ${i_row}    ${i_username}
    GoTo View/Update/Delete System User Form    ${i_row}
    Form System User Verify Fields    ${i_username}
    Click Element    ${Form.Common.BackToList.Btn}

Update System User
    [Arguments]    ${i_row}    ${i_username}=${EMPTY}    ${i_password}=${EMPTY}    ${i_password_confirmation}=${EMPTY}
    GoTo View/Update/Delete System User Form    ${i_row}
    Form System User Populate Fields    ${i_username}    ${i_password}    ${i_password_confirmation}
    Click Element    ${Form.Common.Confirm.Btn}
    Page Should Contain Element    //h1[contains(text(),'System User List')]
    &{i_updated_row}    Create Dictionary    Username:=${i_username}
    View System User    ${i_updated_row}    ${i_username}
    
Delete System User
    [Arguments]    ${i_row}
    GoTo View/Update/Delete System User Form    ${i_row}
    Click Element    ${Form.Common.Delete.Btn}    
    Click Element    ${Page.DeleteConfirmation.YesImSure.Btn}    
    Page Should Contain Element    //h1[contains(text(),'System User List')]             

# Client Keywords
GoTo Create Client Form
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.NewClient.Link}    
    Click Element    ${Sidebar.StaticData.NewClient.Link}

GoTo View/Update/Delete Client Form
    [Arguments]    ${i_row}
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link} 
    ${l_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${i_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a

Form Client Populate Fields
    [Arguments]    ${i_fname}=${EMPTY}    ${i_lname}=${EMPTY}    ${i_addr}=${EMPTY}    ${i_mobile}=${EMPTY}    ${i_email_addr}=${EMPTY}
    # Form Defaults
    Element Should Be Disabled    ${Form.Client.AccountNum.Txt}
    Element Should Be Disabled    ${Form.Client.Balance.Txt}    
    # Populate Actions
    Run Keyword If    '${i_fname}'!='${EMPTY}'    Input Text    ${Form.Client.FirstName.Txt}    ${i_fname}
    Run Keyword If    '${i_lname}'!='${EMPTY}'    Input Text    ${Form.Client.LastName.Txt}    ${i_lname}    
    Run Keyword If    '${i_addr}'!='${EMPTY}'    Input Text    ${Form.Client.Address.Txt}    ${i_addr}    
	Run Keyword If    '${i_mobile}'!='${EMPTY}'    Input Text    ${Form.Client.MobileNumber.Txt}    ${i_mobile}
	Run Keyword If    '${i_email_addr}'!='${EMPTY}'    Input Text    ${Form.Client.EmailAddress.Txt}    ${i_email_addr}

Form Client Verify Fields
    [Arguments]    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
    # Form Defaults
    Element Should Be Disabled    ${Form.Client.AccountNum.Txt}
    Element Should Be Disabled    ${Form.Client.Balance.Txt}
    # Verify Actions
    Run Keyword If    '${i_fname}'!='${EMPTY}'    Textfield Value Should Be    ${Form.Client.FirstName.Txt}    ${i_fname}
    Run Keyword If    '${i_lname}'!='${EMPTY}'    Textfield Value Should Be    ${Form.Client.LastName.Txt}    ${i_lname}    
    Run Keyword If    '${i_addr}'!='${EMPTY}'    Textfield Value Should Be    ${Form.Client.Address.Txt}    ${i_addr}    
	Run Keyword If    '${i_mobile}'!='${EMPTY}'    Textfield Value Should Be    ${Form.Client.MobileNumber.Txt}    ${i_mobile}
	Run Keyword If    '${i_email_addr}'!='${EMPTY}'    Textfield Value Should Be    ${Form.Client.EmailAddress.Txt}    ${i_email_addr}
                   
Create Client
    [Arguments]    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
    GoTo Create Client Form
    Form Client Populate Fields    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
	Click Element    ${Form.Common.Confirm.Btn}

View Client
    [Arguments]    ${i_row}    ${i_fname}=${EMPTY}    ${i_lname}=${EMPTY}    ${i_addr}=${EMPTY}    ${i_mobile}=${EMPTY}    ${i_email_addr}=${EMPTY}
    GoTo View/Update/Delete Client Form    ${i_row}
    Form Client Verify Fields    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
    Click Element    ${Form.Common.BackToList.Btn}    
    	
Update Client
    [Arguments]    ${i_row}    ${i_fname}=${EMPTY}    ${i_lname}=${EMPTY}    ${i_addr}=${EMPTY}    ${i_mobile}=${EMPTY}    ${i_email_addr}=${EMPTY}
    GoTo View/Update/Delete Client Form    ${i_row}
    Form Client Populate Fields    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
	Click Element    ${Form.Common.Confirm.Btn}
	Page Should Contain Element    //h1[contains(text(),'Client List')]
    &{l_updated_row}    Create Dictionary
    ...    First Name:=${i_fname}
    ...    Last Name:=${i_lname}
    ...    Email Address:=${i_email_addr}
    View Client    ${l_updated_row}    i_fname=${i_fname}    i_lname=${i_lname}    i_addr=${i_addr}    i_mobile=${i_mobile}    i_email_addr=${i_email_addr}
	
Delete Client
    [Arguments]    ${i_row}    
    GoTo View/Update/Delete Client Form    ${i_row}    
    Click Element    ${Form.Common.Delete.Btn}    
    Click Element    ${Page.DeleteConfirmation.YesImSure.Btn}    
    Page Should Contain Element    //h1[contains(text(),'Client List')]   

# Deposit Transaction Keywords
GoTo Create Deposit Transaction Form
    Click Element    ${Sidebar.Transactions.Deposit.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.NewDeposit.Link}    
    Click Element    ${Sidebar.Transactions.NewDeposit.Link}

GoTo View Deposit Transaction Form
    Click Element    ${Sidebar.Transactions.Deposit.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.DepositTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.DepositTransactionList.Link}

Form Deposit Transaction Populate Fields                 	
    [Arguments]    ${i_client}=${EMPTY}    ${i_amt}=${EMPTY}    
    # Form Defaults
    Element Should Be Disabled    ${Form.DepositTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Currency.Txt}
    # Populate Actions
    Run Keyword If    '${i_client}'!='${EMPTY}'    Select From List By Label    ${Form.DepositTransaction.Client.Cbo}    ${i_client}
    Run Keyword If    '${i_amt}'!='${EMPTY}'    Input Text    ${Form.DepositTransaction.DepositAmount.Txt}    ${i_amt}

Form Deposit Transaction Verify Fields
    [Arguments]    ${i_client}=${EMPTY}    ${i_amt}=${EMPTY}  
    # Form Defaults
    Element Should Be Disabled    ${Form.DepositTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Currency.Txt}
    Element Should Be Disabled    ${Form.DepositTransaction.Client.Cbo}
    Element Should Be Disabled    ${Form.DepositTransaction.DepositAmount.Txt}
    # Verify Actions
    Run Keyword If    '${i_client}'!='${EMPTY}'    List Selection Should Be    ${Form.DepositTransaction.Client.Cbo}    ${i_client}
    Run Keyword If    '${i_amt}'!='${EMPTY}'    Textfield Value Should Be    ${Form.DepositTransaction.DepositAmount.Txt}    ${i_amt}

Create Deposit Transaction
    [Arguments]    ${i_client}=${EMPTY}    ${i_amt}=${EMPTY}   
    GoTo Create Deposit Transaction Form
    Form Deposit Transaction Populate Fields    ${i_client}    ${i_amt}
    ${l_trx_ref}    Get Element Attribute    ${Form.DepositTransaction.TrxRef.Txt}    value
	Click Element    ${Form.Common.Confirm.Btn}
	[Return]    ${l_trx_ref}        

View Deposit Transaction
    [Arguments]    ${i_row}    ${i_client}=${EMPTY}    ${i_amt}=${EMPTY}  
    GoTo View Deposit Transaction Form
    ${l_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${i_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a
    Form Deposit Transaction Verify Fields    ${i_client}    ${i_amt}
    Click Element    ${Form.Common.BackToList.Btn}

# Withdraw Transaction Keywords
GoTo Create Withdraw Transaction Form
    Click Element    ${Sidebar.Transactions.Withdraw.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.NewWithdraw.Link}    
    Click Element    ${Sidebar.Transactions.NewWithdraw.Link}
    
GoTo View Withdraw Transaction Form 
    Click Element    ${Sidebar.Transactions.Withdraw.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.WithdrawTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.WithdrawTransactionList.Link}

Form Withdraw Transaction Populate Fields
    [Arguments]    ${i_client}=${EMPTY}    ${i_amt}=${EMPTY}
    # Form Defaults
    Element Should Be Disabled    ${Form.WithdrawTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Currency.Txt}
    # Populate Actions
    Run Keyword If    '${i_client}'!='${EMPTY}'    Select From List By Label    ${Form.WithdrawTransaction.Client.Cbo}    ${i_client}
    Run Keyword If    '${i_amt}'!='${EMPTY}'    Input Text    ${Form.WithdrawTransaction.WithdrawAmount.Txt}    ${i_amt}    

Form Withdraw Transaction Verify Fields
    [Arguments]    ${i_client}=${EMPTY}    ${i_amt}=${EMPTY}
    # Form Defaults
    Element Should Be Disabled    ${Form.WithdrawTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Currency.Txt}
    Element Should Be Disabled    ${Form.WithdrawTransaction.Client.Cbo} 
    Element Should Be Disabled    ${Form.WithdrawTransaction.WithdrawAmount.Txt}         
    # Populate Actions
    Run Keyword If    '${i_client}'!='${EMPTY}'    List Selection Should Be    ${Form.WithdrawTransaction.Client.Cbo}    ${i_client}
    Run Keyword If    '${i_amt}'!='${EMPTY}'    Textfield Value Should Be    ${Form.WithdrawTransaction.WithdrawAmount.Txt}    ${i_amt}     
          
Create Withdraw Transaction
    [Arguments]    ${i_client}    ${i_amt} 
    GoTo Create Withdraw Transaction Form
    Form Withdraw Transaction Populate Fields    ${i_client}    ${i_amt}    
	${l_trx_ref}    Get Element Attribute    ${Form.WithdrawTransaction.TrxRef.Txt}    value
	Click Element    ${Form.Common.Confirm.Btn}
	[Return]    ${l_trx_ref}

View Withdraw Transaction
    [Arguments]    ${i_row}    ${i_client}    ${i_amt}
    GoTo View Withdraw Transaction Form
    ${l_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${i_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a
    Form Withdraw Transaction Verify Fields    ${i_client}    ${i_amt}
    Click Element    ${Form.Common.BackToList.Btn}

# Transfer Transaction Keyword
GoTo Create Transfer Transaction Form
    Click Element    ${Sidebar.Transactions.Transfer.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.NewTransfer.Link}    
    Click Element    ${Sidebar.Transactions.NewTransfer.Link}

GoTo View Transfer Transaction Form
    Click Element    ${Sidebar.Transactions.Transfer.Link}    
    Wait Until Element Is Visible    ${Sidebar.Transactions.TransferTransactionList.Link}    
    Click Element    ${Sidebar.Transactions.TransferTransactionList.Link}

Form Transfer Transaction Populate Fields
    [Arguments]    ${i_from_client}=${EMPTY}    ${i_to_client}=${EMPTY}    ${i_amt}=${EMPTY}
    # Form Defaults
    Element Should Be Disabled    ${Form.TransferTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Currency.Txt}
    # Populate Actions
    Select From List By Label    ${Form.TransferTransaction.FromClient.Cbo}    ${i_from_client}
    Select From List By Label    ${Form.TransferTransaction.ToClient.Cbo}    ${i_to_client}
    Input Text    ${Form.TransferTransaction.TransferAmount.Txt}    ${i_amt}
    
Form Transfer Transaction Verify Fields     	
    [Arguments]    ${i_from_client}=${EMPTY}    ${i_to_client}=${EMPTY}    ${i_amt}=${EMPTY}
    # Form Defaults
    Element Should Be Disabled    ${Form.TransferTransaction.TrxDate.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.TrxRef.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Status.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.Currency.Txt}
    Element Should Be Disabled    ${Form.TransferTransaction.FromClient.Cbo}
    Element Should Be Disabled    ${Form.TransferTransaction.ToClient.Cbo}
    Element Should Be Disabled    ${Form.TransferTransaction.TransferAmount.Txt}    
    # Verify Actions
    List Selection Should Be    ${Form.TransferTransaction.FromClient.Cbo}    ${i_from_client}
    List Selection Should Be    ${Form.TransferTransaction.ToClient.Cbo}    ${i_to_client}
    Textfield Value Should Be    ${Form.TransferTransaction.TransferAmount.Txt}    ${i_amt}

Create Transfer Transaction
    [Arguments]    ${i_from_client}    ${i_to_client}    ${i_amt} 
    GoTo Create Transfer Transaction Form   
    Form Transfer Transaction Populate Fields    ${i_from_client}    ${i_to_client}    ${i_amt} 
	${l_trx_ref}    Get Element Attribute    ${Form.TransferTransaction.TrxRef.Txt}    value
	Click Element    ${Form.Common.Confirm.Btn}
	[Return]    ${l_trx_ref}

View Transfer Transaction
    [Arguments]    ${i_row}    ${i_from_client}    ${i_to_client}    ${i_amt}
    GoTo View Transfer Transaction Form
    ${l_index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${i_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a
    Form Transfer Transaction Verify Fields    ${i_from_client}    ${i_to_client}    ${i_amt}
    Click Element    ${Form.Common.BackToList.Btn}  
    	
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