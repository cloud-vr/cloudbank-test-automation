*** Settings ***
Resource    ../../resources/keywords.robot  

*** Variables ***
${errors}    /..//*[@class='errorlist']/li

*** Keywords ***
Client Create Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}

    GoTo Create Client Form
    Form Client Populate Fields    ${l_data['fname']['input']}    ${l_data['lname']['input']}    ${l_data['addr']['input']}    ${l_data['mobile']['input']}    ${l_data['emailAddr']['input']}
	Click Element    ${Form.Common.Confirm.Btn}
	        
    Run Keyword If    '${l_data['fname']['validationMessage']}'!='${EMPTY}'
    ...    VERIFY FIELD VALIDATION    ${Form.Client.FirstName.Txt}    ${l_data['fname']['validationMessage']}

    @{args}    Run Keyword If    '${l_data['emailAddr']['fieldError']}'!='${EMPTY}'
    ...    Create List    ${Form.Client.EmailAddress.Txt}${errors}    ${l_data['emailAddr']['fieldError']}
    Run Keyword If    '${l_data['emailAddr']['fieldError']}'!='${EMPTY}'
    ...    VERIFY    Element Should Contain    ${args}
    
    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}   

Client View Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    &{l_row}    Create Dictionary
    ...    First Name:=${l_data['fname']['input']}
    ...    Last Name:=${l_data['lname']['input']}
    ...    Email Address:=${l_data['emailAddr']['input']}
    
    GoTo View/Update/Delete Client Form    ${l_row}
    Form Client Verify Fields    ${l_data['fname']['input']}    ${l_data['lname']['input']}    ${l_data['addr']['input']}    ${l_data['mobile']['input']}    ${l_data['emailAddr']['input']}
    Click Element    ${Form.Common.BackToList.Btn}

    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}              
                 
Client Update Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}

    &{l_row}    Create Dictionary
    ...    First Name:=${l_data['fname']['oldVal']}
    ...    Last Name:=${l_data['lname']['oldVal']}
    ...    Email Address:=${l_data['emailAddr']['oldVal']}              
    GoTo View/Update/Delete Client Form    ${l_row}
    Form Client Populate Fields    ${l_data['fname']['newVal']}    ${l_data['lname']['newVal']}    ${l_data['addr']['newVal']}    ${l_data['mobile']['newVal']}    ${l_data['emailAddr']['newVal']}
	Click Element    ${Form.Common.Confirm.Btn}
	Page Should Contain Element    //h1[contains(text(),'Client List')]
    &{l_updated_row}    Create Dictionary
    ...    First Name:=${l_data['fname']['newVal']}
    ...    Last Name:=${l_data['lname']['newVal']}
    ...    Email Address:=${l_data['emailAddr']['newVal']} 
    GoTo View/Update/Delete Client Form    ${l_updated_row}
    Form Client Verify Fields    ${l_data['fname']['newVal']}    ${l_data['lname']['newVal']}    ${l_data['addr']['newVal']}    ${l_data['mobile']['newVal']}    ${l_data['emailAddr']['newVal']}
    Click Element    ${Form.Common.BackToList.Btn}
    
    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args}      
    
Client Delete Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    &{l_row}    Create Dictionary
    ...    First Name:=${l_data['fname']['input']}
    ...    Last Name:=${l_data['lname']['input']}
    ...    Email Address:=${l_data['emailAddr']['input']} 
    GoTo View/Update/Delete Client Form    ${l_row}    
    Click Element    ${Form.Common.Delete.Btn}    
    Click Element    ${Page.DeleteConfirmation.YesImSure.Btn}    
    @{args}    Create List    ${l_data['afterClickConfirm']['expectedElementInPage']}
    VERIFY    Page Should Contain Element    ${args} 
    