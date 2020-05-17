*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    Launch Cloud Bank and Login    tester    password@1234         
Suite Teardown    Logout
Test Setup    Click Element    ${Sidebar.CloudBank.Logo.Link}    

*** Variables ***
${errors}    xpath=//*[@class='errorlist']/li

*** Test Cases ***
Negative Scenario - Blank Fields
    Create Client    \    \    \    \    \
    ${element}    Get WebElement    ${Form.Client.FirstName.Txt}
    ${validationMessage}    Get Element Attribute    ${element}    validationMessage
    Run Keyword And Continue On Failure    Should Be Equal    ${validationMessage}    Please fill out this field.
    Run Keyword And Continue On Failure    Page Should Contain Element    //h1[contains(text(),'Create Client')]       

Positive Scenario - All Field Populated    
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    Page Should Contain Element    //h1[contains(text(),'Client List')]
    
Negative Scenario - Existing Client
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com
    ${elements}    Get WebElements    ${errors}
    ${is_expected_error_found}    Set Variable    ${True}
    FOR    ${element}    IN    @{elements}
        ${is_expected_error_found}    Run Keyword And Return Status    Element Should Contain    ${element}    Client with this Email Address already exists.
        Exit For Loop If    ${is_expected_error_found}==True 
    END 
    
View
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com 
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}  
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Element Attribute Value Should Be    ${Form.Client.EmailAddress.Txt}    value    yuffie@kisaragi.com  
    Click Element    ${Form.Common.BackToList.Btn}
                 
Update
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com                
    Update Client    ${row}    i_mobile=69 
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Element Attribute Value Should Be    ${Form.Client.MobileNumber.Txt}    value    69  
    Click Element    ${Form.Common.BackToList.Btn}

    
Delete
    &{row}    Create Dictionary
    ...    First Name:=Yuffie
    ...    Last Name:=Kisaragi
    ...    Email Address:=yuffie@kisaragi.com  
    Click Element    ${Sidebar.StaticData.Clients.Link}
    Wait Until Element Is Visible    ${Sidebar.StaticData.ClientList.Link}    
    Click Element    ${Sidebar.StaticData.ClientList.Link}                 
    ${index}    Table Keyword    ${Page.Common.ObjectListTable.Tbl}    ${row}
    Click Element    ${Page.Common.ObjectListTable.Tbl}/tbody/tr[${index}]/td[1]/a 
    Click Element    ${Form.Common.Delete.Btn}    
    Click Element    ${Page.DeleteConfirmation.YesImSure.Btn}    
    Page Should Contain Element    //h1[contains(text(),'Client List')]
    # create client again because it is needed for the transactions
    Create Client    Yuffie    Kisaragi    Wutai    4    yuffie@kisaragi.com