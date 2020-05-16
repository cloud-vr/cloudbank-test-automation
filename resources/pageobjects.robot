*** Variables ***
#Cloud Bank Logo
${cloudbank_logo}    xpath=//a[contains(@class,'sidebar-brand')]/descendant::div[contains(text(),'Cloud Bank')]
# Login
${username}    xpath=//input[contains(@id,'Username')]
${password}    xpath=//input[contains(@id,'Password')]  
${login_btn}    xpath=//*[contains(@value,'Log in')]

${profile}    xpath=//img[@class='img-profile rounded-circle']
${profile_logout_btn}    xpath=//a[@data-target='#logoutModal']
${profile_profile}    xpath=//a[@id='profile']
${logout_btn}    xpath=//a[text()='Logout']

# Nav Links
${navlink_dashboard}    xpath=//a[contains(@class,'nav-link')]/descendant::span[contains(text(),'Dashboard')]

${navlink_system_users_collapsed}    xpath=//a[contains(@aria-controls,'collapseUsers') and @class='nav-link collapsed']
${navlink_system_users_new}    xpath=//a[contains(text(),'New System User')]
${navlink_system_users_list}    xpath=//a[contains(text(),'System User List')]

${navlink_client_collapsed}    xpath=//a[contains(@aria-controls,'collapseClients') and @class='nav-link collapsed']
${navlink_client_new}    xpath=//a[contains(text(),'New Client')]
${navlink_client_list}    xpath=//a[contains(text(),'Client List')]

${navlink_deposit_collapsed}    xpath=//a[contains(@aria-controls,'collapseDeposit') and @class='nav-link collapsed']
${navlink_deposit_new}    xpath=//a[contains(text(),'New Deposit')]
${navlink_deposit_list}    xpath=//a[contains(text(),'Deposit Transaction List')]

${navlink_withdraw_collapsed}    xpath=//a[contains(@aria-controls,'collapseWithdraw') and @class='nav-link collapsed']
${navlink_withdraw_new}    xpath=//a[contains(text(),'New Withdraw')]
${navlink_withdraw_list}    xpath=//a[contains(text(),'Withdraw Transaction List')]

${navlink_transfer_collapsed}    xpath=//a[contains(@aria-controls,'collapseTransfer') and @class='nav-link collapsed']
${navlink_transfer_new}    xpath=//a[contains(text(),'New Transfer')]
${navlink_transfer_list}    xpath=//a[contains(text(),'Transfer Transaction List')]

# Dashboard
${dashboard_aggregate_deposit}    xpath=//div[contains(text(),'Aggregate Deposit')]/../div[2]
${dashboard_aggregate_withdraw}    xpath=//div[contains(text(),'Aggregate Withdraw')]/../div[2]
${dashboard_aggregate_transfer}    xpath=//div[contains(text(),'Aggregate Transfer')]/../div[2]
${dashboard_number_trx}    xpath=//div[contains(text(),'Number of Transactions')]/../div[2]

# System User Form
${form_username}    xpath=//input[contains(@id,'id_username')]
${form_password}    xpath=//input[contains(@id,'id_password1')]
${form_password_confirmation}    xpath=//input[contains(@id,'id_password2')]

# Client Form
${client_first_name}    xpath=//input[contains(@id,'id_fname')]
${client_last_name}    xpath=//input[contains(@id,'id_lname')]
${client_address}    xpath=//input[contains(@id,'id_addr')]
${client_account_num}    xpath=//input[contains(@id,'id_acct_num')]
${client_mobile_number}    xpath=//input[contains(@id,'id_mobile_num')]
${client_email_addr}    xpath=//input[contains(@id,'id_email_addr')]
${client_balance}    xpath=//input[contains(@id,'id_balance')]

# Deposit Form
${deposit_trx_date}    xpath=//input[contains(@id,'id_trx_date')]
${deposit_trx_ref}    xpath=//input[contains(@id,'id_trx_ref')]
${deposit_trx_status}    xpath=//input[contains(@id,'id_status')]
${deposit_trx_client}    xpath=//select[contains(@id,'id_client')]
${deposit_trx_deposit_amt}    xpath=//input[contains(@id,'id_deposit_amt')]
${deposit_trx_curr}    xpath=//input[contains(@id,'id_curr')]

# Withdraw Form
${withdraw_trx_date}    xpath=//input[contains(@id,'id_trx_date')]
${withdraw_trx_ref}    xpath=//input[contains(@id,'id_trx_ref')]
${withdraw_trx_status}    xpath=//input[contains(@id,'id_status')]
${withdraw_trx_client}    xpath=//select[contains(@id,'id_client')]
${withdraw_trx_withdraw_amt}    xpath=//input[contains(@id,'id_withdraw_amt')]
${withdraw_trx_curr}    xpath=//input[contains(@id,'id_curr')]

# Transfer Form
${transfer_trx_date}    xpath=//input[contains(@id,'id_trx_date')]
${transfer_trx_ref}    xpath=//input[contains(@id,'id_trx_ref')]
${transfer_trx_status}    xpath=//input[contains(@id,'id_status')]
${transfer_trx_from_client}    xpath=//select[contains(@id,'id_from_client')]
${transfer_trx_to_client}    xpath=//select[contains(@id,'id_to_client')]
${transfer_trx_transfer_amt}    xpath=//input[contains(@id,'id_transfer_amt')]
${transfer_trx_curr}    xpath=//input[contains(@id,'id_curr')]

# ${form_btn_confirm}    xpath=//button
${form_btn_confirm}    xpath=//button/descendant::span[text()='Confirm']
${form_btn_delete}    xpath=//a/descendant::span[text()='Delete']
${form_btn_confirm_delete_yes}    xpath=//button/descendant::span[contains(text(),'Yes')]
${form_btn_back_to_list}    xpath=//a[contains(text(),'Back to list')]
${table_in_list_page}    xpath=//table[@class='table table-bordered']
${search_bar}    xpath=//input[@aria-label='Search']
${search_btn}    xpath=//i[@class='fas fa-search fa-fw']/..