*** Settings ***
Resource    ../../resources/keywords.robot 

*** Variables ***
${s_deposit_trx_ref}

*** Keywords ***
Deposit Transaction Create With Field Error Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
        
    GoTo Create Deposit Transaction Form
    Form Deposit Transaction Populate Fields    ${l_data['client']['input']}    ${l_data['depAmount']['input']}
	Click Element    ${Form.Common.Confirm.Btn}
	
    VERIFY FIELD VALIDATION    ${Form.DepositTransaction.Client.Cbo}    ${l_data['client']['validationMessage']}

    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args} 

Deposit Transaction Create Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}

    # Dashboard Initial Values
    GoTo Dashboard
    ${l_initial_dep_amt}    Get Dashboard Aggregate Deposit Value  
    ${l_initial_number_of_trx}    Get Dashboard Number Of Transactions Value    
    
    # Client Initial Values
    GoTo Client List Page
    &{l_client_dict}    Create Dictionary    First Name:=${l_data['clientFname']['input']}    Last Name:=${l_data['clientLname']['input']}
    ${initial_balance}    Get Client Balance    ${l_client_dict}
                
    # Deposit Transaction
    GoTo Create Deposit Transaction Form
    Form Deposit Transaction Populate Fields    ${l_data['client']['input']}    ${l_data['depAmount']['input']}
    ${l_trx_ref}    Get Element Attribute    ${Form.DepositTransaction.TrxRef.Txt}    value
	Click Element    ${Form.Common.Confirm.Btn}
	
    Set Suite Variable    ${s_deposit_trx_ref}    ${l_trx_ref}

    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}    
    
    # Dashboard Post Values
    GoTo Dashboard
    ${l_post_dep_amt}    Get Dashboard Aggregate Deposit Value  
    ${l_post_number_of_trx}    Get Dashboard Number Of Transactions Value
    
    @{args}    Create List    ${l_initial_dep_amt+${l_data['depAmount']['input']}}    ${l_post_dep_amt}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Aggregate Deposit Amount updated correctly.
    ...    i_fail_message=Dashboard Aggregate Deposit Amount not updated correctly.       
        
    @{args}    Create List    ${l_initial_number_of_trx+1}    ${l_post_number_of_trx}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Number Of Transactions updated correctly.
    ...    i_fail_message=Dashboard Number Of Transactions not updated correctly.       

    # Client Post Values  
    GoTo Client List Page
    ${post_balance}    Get Client Balance    ${l_client_dict}
         
    @{args}    Create List    ${initial_balance+${l_data['depAmount']['input']}}    ${post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly.
    
Deposit Transaction View Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    &{l_row}    Create Dictionary    Trx ref:=${s_deposit_trx_ref}
    
    GoTo View Deposit Transaction Form
    ${l_index}    Find Searched Row In The Table    ${Page.Common.ObjectListTable.Tbl}    ${l_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a
    Form Deposit Transaction Verify Fields    ${l_data['client']['verify']}    ${l_data['depAmount']['verify']}
    Click Element    ${Form.Common.BackToList.Btn}

    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}