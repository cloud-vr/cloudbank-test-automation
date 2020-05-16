*** Settings ***
Library    SeleniumLibrary
Library    String      
Library    Collections          
Resource    pageobjects.robot

*** Keywords ***
Launch Cloud Bank
    Open Browser    http://localhost:8000/bank/login    chrome
    Maximize Browser Window

Input Username and Password Then Click Login
    [Arguments]    ${i_username}    ${i_password}
    Input Text    ${username}    ${i_username}
    Input Text    ${password}    ${i_password}
    Click Button    ${login_btn}
    
Launch Cloud Bank and Login
    [Arguments]    ${i_username}    ${i_password}
    Launch Cloud Bank
    Input Username and Password Then Click Login    ${i_username}    ${i_password}
    
Create System User
    [Arguments]    ${i_username}    ${i_password}    ${i_password_confirmation}
    Click Element    ${navlink_system_users_collapsed}      
    Wait Until Element Is Visible    ${navlink_system_users_new}       
    Click Element    ${navlink_system_users_new} 
    Input Text    ${form_username}    ${i_username}
    Input Text    ${form_password}    ${i_password}
    Input Text    ${form_password_confirmation}    ${i_password_confirmation}
    Click Element    ${form_btn_confirm}
    
Update System User
    [Arguments]    ${row}    ${i_username}=${EMPTY}    ${i_password}=${EMPTY}    ${i_password_confirmation}=${EMPTY}
    Click Element    ${navlink_system_users_collapsed}      
    Wait Until Element Is Visible    ${navlink_system_users_new}       
    Click Element    ${navlink_system_users_list}
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Run Keyword If    '${i_username}'!='${EMPTY}'    Input Text    ${form_username}    ${i_username}
    Run Keyword If    '${i_password}'!='${EMPTY}'    Input Text    ${form_password}    ${i_password}
    Run Keyword If    '${i_password_confirmation}'!='${EMPTY}'    Input Text    ${form_password_confirmation}    ${i_password_confirmation}
    Click Element    ${form_btn_confirm}
        
   
Create Client
    [Arguments]    ${i_fname}    ${i_lname}    ${i_addr}    ${i_mobile}    ${i_email_addr}
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_new}    
    Click Element    ${navlink_client_new}
    Element Should Be Disabled    ${client_account_num}
    Element Should Be Disabled    ${client_balance}
    Element Attribute Value Should Be    ${client_balance}    value    0      
    # Element Text Should Be    ${client_balance}    0     
    Input Text    ${client_first_name}    ${i_fname}
    Input Text    ${client_last_name}    ${i_lname}    
    Input Text    ${client_address}    ${i_addr}    
	Input Text    ${client_mobile_number}    ${i_mobile}
	Input Text    ${client_email_addr}    ${i_email_addr}
	Click Element    ${form_btn_confirm}
	
Update Client
    [Arguments]    ${row}    ${i_fname}=${EMPTY}    ${i_lname}=${EMPTY}    ${i_addr}=${EMPTY}    ${i_mobile}=${EMPTY}    ${i_email_addr}=${EMPTY}
    Click Element    ${navlink_client_collapsed}
    Wait Until Element Is Visible    ${navlink_client_list}    
    Click Element    ${navlink_client_list}    
    ${index}    Table Keyword    ${table_in_list_page}    ${row}
    Click Element    ${table_in_list_page}/tbody/tr[${index}]/td[1]/a 
    Run Keyword If    '${i_fname}'!='${EMPTY}'    Input Text    ${client_first_name}    ${i_fname}
    Run Keyword If    '${i_lname}'!='${EMPTY}'    Input Text    ${client_last_name}    ${i_lname}    
    Run Keyword If    '${i_addr}'!='${EMPTY}'    Input Text    ${client_address}    ${i_addr}    
	Run Keyword If    '${i_mobile}'!='${EMPTY}'    Input Text    ${client_mobile_number}    ${i_mobile}
	Run Keyword If    '${i_email_addr}'!='${EMPTY}'    Input Text    ${client_email_addr}    ${i_email_addr}
	Click Element    ${form_btn_confirm}
                	
New Deposit
    [Arguments]    ${i_client}    ${i_amt}    
    Click Element    ${navlink_deposit_collapsed}    
    Wait Until Element Is Visible    ${navlink_deposit_new}    
    Click Element    ${navlink_deposit_new}
    Element Should Be Disabled    ${deposit_trx_date}
    Element Should Be Disabled    ${deposit_trx_ref}
    Element Should Be Disabled    ${deposit_trx_status}
    Element Should Be Disabled    ${deposit_trx_curr}
    Select From List By Label    ${deposit_trx_client}    ${i_client}
    Input Text    ${deposit_trx_deposit_amt}    ${i_amt}
	Click Element    ${form_btn_confirm}     
	
New Withdraw
    [Arguments]    ${i_client}    ${i_amt}    
    Click Element    ${navlink_withdraw_collapsed}    
    Wait Until Element Is Visible    ${navlink_withdraw_new}    
    Click Element    ${navlink_withdraw_new}
    Element Should Be Disabled    ${withdraw_trx_date}
    Element Should Be Disabled    ${withdraw_trx_ref}
    Element Should Be Disabled    ${withdraw_trx_status}
    Element Should Be Disabled    ${withdraw_trx_curr}
    Select From List By Label    ${withdraw_trx_client}    ${i_client}
    Input Text    ${withdraw_trx_withdraw_amt}    ${i_amt}
	Click Element    ${form_btn_confirm}  
	
New Transfer
    [Arguments]    ${i_from_client}    ${i_to_client}    ${i_amt}    
    Click Element    ${navlink_transfer_collapsed}    
    Wait Until Element Is Visible    ${navlink_transfer_new}    
    Click Element    ${navlink_transfer_new}
    Element Should Be Disabled    ${transfer_trx_date}
    Element Should Be Disabled    ${transfer_trx_ref}
    Element Should Be Disabled    ${transfer_trx_status}
    Element Should Be Disabled    ${transfer_trx_curr}
    Select From List By Label    ${transfer_trx_from_client}    ${i_from_client}
    Select From List By Label    ${transfer_trx_to_client}    ${i_to_client}
    Input Text    ${transfer_trx_transfer_amt}    ${i_amt}
	Click Element    ${form_btn_confirm}  
	
Logout
    Click Element    ${profile}    
    Wait Until Element Is Visible    ${profile_logout_btn}    
    Click Element    ${profile_logout_btn}  
    Wait Until Element Is Visible    ${logout_btn}      
    Click Element    ${logout_btn}  
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