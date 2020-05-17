*** Variables ***
# Login Page
${Page.Login.Username.Txt}    xpath=//input[contains(@id,'Username')]
${Page.Login.Password.Txt}    xpath=//input[contains(@id,'Password')]
${Page.Login.Login.Btn}    xpath=//*[contains(@value,'Log in')]

# Common Page Objects
${Form.Common.Confirm.Btn}    xpath=//button/descendant::span[text()='Confirm']
${Form.Common.Delete.Btn}    xpath=//a/descendant::span[text()='Delete']
${Form.Common.BackToList.Btn}    xpath=//a[contains(text(),'Back to list')]
${Page.DeleteConfirmation.YesImSure.Btn}    xpath=//button/descendant::span[contains(text(),'Yes')]
${Page.Common.ObjectListTable.Tbl}    xpath=//table[@class='table table-bordered']
${Page.Common.SearchFor.Txt}    xpath=//input[@aria-label='Search']
${Page.Common.SearchFor.Btn}    xpath=//i[@class='fas fa-search fa-fw']/..

# Top Bar Profile
${Topbar.Profile.ProfileIcon.Link}    xpath=//img[@class='img-profile rounded-circle']
${Topbar.Profile.ProfileLink.Link}    xpath=//a[@id='profile']
${Topbar.Profile.Logout.Link}    xpath=//a[@data-target='#logoutModal']

# Popup - Ready To Leave
${Popup.ReadyToLeave.Logout.Btn}    xpath=//a[text()='Logout']

# Side Bar Cloud Bank
${Sidebar.CloudBank.Logo.Link}    xpath=//a[contains(@class,'sidebar-brand')]/descendant::div[contains(text(),'Cloud Bank')]
${Sidebar.CloudBank.Dashboard.Link}    xpath=//a[contains(@class,'nav-link')]/descendant::span[contains(text(),'Dashboard')]

# Side Bar Static Data - System Users
${Sidebar.StaticData.SystemUsers.Link}    xpath=//a[contains(@aria-controls,'collapseUsers') and @class='nav-link collapsed']
${Sidebar.StaticData.NewSystemUser.Link}    xpath=//a[contains(text(),'New System User')]
${Sidebar.StaticData.SystemUserList.Link}    xpath=//a[contains(text(),'System User List')]

# Side Bar Static Data - Clients
${Sidebar.StaticData.Clients.Link}    xpath=//a[contains(@aria-controls,'collapseClients') and @class='nav-link collapsed']
${Sidebar.StaticData.NewClient.Link}    xpath=//a[contains(text(),'New Client')]
${Sidebar.StaticData.ClientList.Link}    xpath=//a[contains(text(),'Client List')]

# Side Bar Transactions - Deposit
${Sidebar.Transactions.Deposit.Link}    xpath=//a[contains(@aria-controls,'collapseDeposit') and @class='nav-link collapsed']
${Sidebar.Transactions.NewDeposit.Link}    xpath=//a[contains(text(),'New Deposit')]
${Sidebar.Transactions.DepositTransactionList.Link}    xpath=//a[contains(text(),'Deposit Transaction List')]

# Side Bar Transactions - Withdraw
${Sidebar.Transactions.Withdraw.Link}    xpath=//a[contains(@aria-controls,'collapseWithdraw') and @class='nav-link collapsed']
${Sidebar.Transactions.NewWithdraw.Link}    xpath=//a[contains(text(),'New Withdraw')]
${Sidebar.Transactions.WithdrawTransactionList.Link}    xpath=//a[contains(text(),'Withdraw Transaction List')]

# Side Bar Transactions - Transfer
${Sidebar.Transactions.Transfer.Link}    xpath=//a[contains(@aria-controls,'collapseTransfer') and @class='nav-link collapsed']
${Sidebar.Transactions.NewTransfer.Link}    xpath=//a[contains(text(),'New Transfer')]
${Sidebar.Transactions.TransferTransactionList.Link}    xpath=//a[contains(text(),'Transfer Transaction List')]

# Dashboard Page
${Page.Dashboard.AggregateDeposit.Lbl}    xpath=//div[contains(text(),'Aggregate Deposit')]/../div[2]
${Page.Dashboard.AggregateWithdraw.Lbl}    xpath=//div[contains(text(),'Aggregate Withdraw')]/../div[2]
${Page.Dashboard.AggregateTransfer.Lbl}    xpath=//div[contains(text(),'Aggregate Transfer')]/../div[2]
${Page.Dashboard.NumberOfTransactions.Lbl}    xpath=//div[contains(text(),'Number of Transactions')]/../div[2]

# System User Form
${Form.SystemUser.Username.Txt}    xpath=//input[contains(@id,'id_username')]
${Form.SystemUser.Password.Txt}    xpath=//input[contains(@id,'id_password1')]
${Form.SystemUser.PasswordConfirmation.Txt}    xpath=//input[contains(@id,'id_password2')]

# Client Form
${Form.Client.FirstName.Txt}    xpath=//input[contains(@id,'id_fname')]
${Form.Client.LastName.Txt}    xpath=//input[contains(@id,'id_lname')]
${Form.Client.Address.Txt}    xpath=//input[contains(@id,'id_addr')]
${Form.Client.AccountNum.Txt}    xpath=//input[contains(@id,'id_acct_num')]
${Form.Client.MobileNumber.Txt}    xpath=//input[contains(@id,'id_mobile_num')]
${Form.Client.EmailAddress.Txt}    xpath=//input[contains(@id,'id_email_addr')]
${Form.Client.Balance.Txt}    xpath=//input[contains(@id,'id_balance')]

# Deposit Transaction Form
${Form.DepositTransaction.TrxDate.Txt}    xpath=//input[contains(@id,'id_trx_date')]
${Form.DepositTransaction.TrxRef.Txt}    xpath=//input[contains(@id,'id_trx_ref')]
${Form.DepositTransaction.Status.Txt}    xpath=//input[contains(@id,'id_status')]
${Form.DepositTransaction.Client.Cbo}    xpath=//select[contains(@id,'id_client')]
${Form.DepositTransaction.DepositAmount.Txt}    xpath=//input[contains(@id,'id_deposit_amt')]
${Form.DepositTransaction.Currency.Txt}    xpath=//input[contains(@id,'id_curr')]

# Withdraw Transacion Form
${Form.WithdrawTransaction.TrxDate.Txt}    xpath=//input[contains(@id,'id_trx_date')]
${Form.WithdrawTransaction.TrxRef.Txt}    xpath=//input[contains(@id,'id_trx_ref')]
${Form.WithdrawTransaction.Status.Txt}    xpath=//input[contains(@id,'id_status')]
${Form.WithdrawTransaction.Client.Cbo}    xpath=//select[contains(@id,'id_client')]
${Form.WithdrawTransaction.WithdrawAmount.Txt}    xpath=//input[contains(@id,'id_withdraw_amt')]
${Form.WithdrawTransaction.Currency.Txt}    xpath=//input[contains(@id,'id_curr')]

# Transfer Transaction Form
${Form.TransferTransaction.TrxDate.Txt}    xpath=//input[contains(@id,'id_trx_date')]
${Form.TransferTransaction.TrxRef.Txt}    xpath=//input[contains(@id,'id_trx_ref')]
${Form.TransferTransaction.Status.Txt}    xpath=//input[contains(@id,'id_status')]
${Form.TransferTransaction.FromClient.Cbo}    xpath=//select[contains(@id,'id_from_client')]
${Form.TransferTransaction.ToClient.Cbo}    xpath=//select[contains(@id,'id_to_client')]
${Form.TransferTransaction.TransferAmount.Txt}    xpath=//input[contains(@id,'id_transfer_amt')]
${Form.TransferTransaction.Currency.Txt}    xpath=//input[contains(@id,'id_curr')]
