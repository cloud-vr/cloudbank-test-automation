*** Settings ***
Resource    ../../resources/keywords.robot            

*** Variables ***
${errors}    /..//*[@class='errorlist']/li

*** Keywords ***
System User Create With Field Error Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}

    GoTo Create System User Form
    Form System User Populate Fields    ${l_data['username']['input']}    ${l_data['password']['input']}    ${l_data['passwordConfirmation']['input']}
    Click Element    ${Form.Common.Confirm.Btn}        

    Run Keyword If    '${l_data['username']['validationMessage']}'!='${EMPTY}'
    ...    VERIFY FIELD VALIDATION    ${Form.SystemUser.Username.Txt}    ${l_data['username']['validationMessage']}    

    Run Keyword If    '${l_data['passwordConfirmation']['validationMessage']}'!='${EMPTY}'
    ...    VERIFY FIELD VALIDATION    ${Form.SystemUser.PasswordConfirmation.Txt}    ${l_data['passwordConfirmation']['validationMessage']}    

    @{args}    Run Keyword If    '${l_data['username']['fieldError']}'!='${EMPTY}'
    ...    Create List    ${Form.SystemUser.Username.Txt}${errors}    ${l_data['username']['fieldError']}
    Run Keyword If    '${l_data['username']['fieldError']}'!='${EMPTY}'    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 

    @{args}    Run Keyword If    '${l_data['passwordConfirmation']['fieldError']}'!='${EMPTY}'
    ...    Create List    ${Form.SystemUser.PasswordConfirmation.Txt}${errors}    ${l_data['passwordConfirmation']['fieldError']}
    Run Keyword If    '${l_data['passwordConfirmation']['fieldError']}'!='${EMPTY}'    VERIFY    Element Should Contain    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
   
    @{args}    Create List    //h1[contains(text(),'Create System User')]        
    VERIFY    Page Should Contain Element    ${args}
    ...    i_pass_message=User remained in the Create System User page.
    ...    i_fail_message=User was transitioned to a different page.  
  
System User Create Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}

    GoTo Create System User Form
    Form System User Populate Fields    ${l_data['username']['input']}    ${l_data['password']['input']}    ${l_data['passwordConfirmation']['input']}
    Click Element    ${Form.Common.Confirm.Btn}
                
    @{args}    Create List   //h1[contains(text(),'System User List')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User was transitioned to System User List page.
    ...    i_fail_message=User was not transitioned to System User List page.
    
    Click Element    ${Sidebar.CloudBank.Logo.Link}
    
System User View Template  
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    
    &{i_row}    Create Dictionary    Username:=${l_data['username']['verify']}
    
    GoTo View/Update/Delete System User Form    ${i_row}
    Form System User Verify Fields    ${l_data['username']['verify']}
    Click Element    ${Form.Common.BackToList.Btn}
    Click Element    ${Sidebar.CloudBank.Logo.Link}
    
System User Update Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    &{i_row}    Create Dictionary    Username:=${l_data['username']['input']} 
    GoTo View/Update/Delete System User Form    ${i_row}
    Form System User Populate Fields    ${l_data['username']['verify']}    ${l_data['password']['input']}    ${l_data['passwordConfirmation']['input']}
    Click Element    ${Form.Common.Confirm.Btn}
    Page Should Contain Element    //h1[contains(text(),'System User List')]
    &{i_updated_row}    Create Dictionary    Username:=${l_data['username']['verify']}
    GoTo View/Update/Delete System User Form    ${i_updated_row}
    Form System User Verify Fields    ${l_data['username']['verify']}
    Click Element    ${Form.Common.BackToList.Btn}
    Click Element    ${Sidebar.CloudBank.Logo.Link}
               
System User Delete Template
    [Arguments]    ${i_data}
    ${l_data}    Load Json Data Into Dictionary    ${i_data}
    &{i_row}    Create Dictionary
    ...    Username:=${l_data['username']['input']}

    GoTo View/Update/Delete System User Form    ${i_row}
    Click Element    ${Form.Common.Delete.Btn}    
    Click Element    ${Page.DeleteConfirmation.YesImSure.Btn}       

    @{args}    Create List   //h1[contains(text(),'System User List')]
    VERIFY    Page Should Contain Element    ${args}     
    ...    i_pass_message=User was transitioned to System User List page.
    ...    i_fail_message=User was not transitioned to System User List page.
