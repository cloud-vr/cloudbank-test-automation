*** Settings ***
Resource    ../../resources/keywords.robot

*** Variables ***
${s_transfer_trx_ref}

*** Keywords ***
Transfer Transaction Create With Field Error Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    GoTo Create Transfer Transaction Form   
    Form Transfer Transaction Populate Fields    ${l_data['fromClient']['input']}    ${l_data['toClient']['input']}    ${l_data['transAmount']['input']} 
	${l_trx_ref}    Get Element Attribute    ${Form.TransferTransaction.TrxRef.Txt}    value
	Click Element    ${Form.Common.Confirm.Btn}    

    VERIFY FIELD VALIDATION    ${Form.TransferTransaction.FromClient.Cbo}    ${l_data['fromClient']['validationMessage']}

    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}

Transfer Transaction Create Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    # Dashboard Initial Values
    GoTo Dashboard
    ${l_initial_trans_amt}    Get Dashboard Aggregate Transfer Value  
    ${l_initial_number_of_trx}    Get Dashboard Number Of Transactions Value            

    # Client Initial Values
    GoTo Client List Page
    # from client
    &{l_from_client_dict}    Create Dictionary    First Name:=${l_data['fromClientFname']['input']}    Last Name:=${l_data['fromClientLname']['input']}
    ${l_from_client_initial_balance}    Get Client Balance    ${l_from_client_dict}
    # to client
    &{l_to_client_dict}    Create Dictionary    First Name:=${l_data['toClientFname']['input']}    Last Name:=${l_data['toClientLname']['input']}
    ${l_to_client_initial_balance}    Get Client Balance    ${l_to_client_dict}

    # Transfer Transaction
    ${l_trx_ref}    Create Transfer Transaction    ${l_data['fromClient']['input']}    ${l_data['toClient']['input']}    ${l_data['transAmount']['input']}
    Set Suite Variable    ${s_transfer_trx_ref}    ${l_trx_ref}

    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}  
    
    # Dashboard Post Values
    GoTo Dashboard
    ${l_post_trans_amt}    Get Dashboard Aggregate Transfer Value  
    ${l_post_number_of_trx}    Get Dashboard Number Of Transactions Value    
  
    @{args}    Create List    ${l_initial_trans_amt+${l_data['transAmount']['input']}}    ${l_post_trans_amt}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Aggregate Transfer Amount updated correctly.
    ...    i_fail_message=Dashboard Aggregate Transfer Amount not updated correctly.       
        
    @{args}    Create List    ${l_initial_number_of_trx+1}    ${l_post_number_of_trx}    
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Dashboard Number Of Transactions updated correctly.
    ...    i_fail_message=Dashboard Number Of Transactions not updated correctly.       

    # Client Post Values
    GoTo Client List Page
    # from client
    ${l_from_client_post_balance}    Get Client Balance    ${l_from_client_dict}
    
    @{args}    Create List    ${l_from_client_initial_balance-${l_data['transAmount']['input']}}    ${l_from_client_post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly. 
    # to client
    ${l_to_client_post_balance}    Get Client Balance    ${l_to_client_dict}

    @{args}    Create List    ${l_to_client_initial_balance+${l_data['transAmount']['input']}}    ${l_to_client_post_balance}
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Client balance updated correctly.
    ...    i_fail_message=Client balance not updated correctly.

Transfer Transaction View Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    &{l_row}    Create Dictionary    Trx ref:=${s_transfer_trx_ref}
    GoTo View Transfer Transaction Form
    ${l_index}    Find Searched Row In The Table    ${Page.Common.ObjectListTable.Tbl}    ${l_row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${l_index}]/td[1]/a
    Form Transfer Transaction Verify Fields    ${l_data['fromClient']['verify']}    ${l_data['toClient']['verify']}    ${l_data['transAmount']['verify']}
    Click Element    ${Form.Common.BackToList.Btn}
    
    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}     
      