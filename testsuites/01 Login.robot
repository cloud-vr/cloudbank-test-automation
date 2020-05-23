*** Settings ***
Resource    ../resources/keywords.robot
Suite Setup    GoTo Cloud Bank Page          
Suite Teardown    Logout

*** Test Cases ***
[Negative Scenario] Login - All Fields Are Empty
    Form Login Populate Fields    ${EMPTY}    ${EMPTY}
    Click Button    ${Page.Login.Login.Btn}
    
    ${l_validation_message}    Get Validation Message    ${Page.Login.Username.Txt}
    
    @{args}    Create List    ${l_validation_message}    Please fill out this field.
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 

[Negative Scenario] Login - Username Field Empty
    Form Login Populate Fields    ${EMPTY}    password
    Click Button    ${Page.Login.Login.Btn}

    ${l_validation_message}    Get Validation Message    ${Page.Login.Username.Txt}
    
    @{args}    Create List    ${l_validation_message}    Please fill out this field.
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed.

[Negative Scenario] Login - Password Field Empty
    Form Login Populate Fields    username    ${EMPTY}
    Click Button    ${Page.Login.Login.Btn}

    ${l_validation_message}    Get Validation Message    ${Page.Login.Password.Txt}
    
    @{args}    Create List    ${l_validation_message}    Please fill out this field.
    VERIFY    Should Be Equal    ${args}
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed.

[Negative Scenario] Login - Invalid User
    Form Login Populate Fields    does_not_exist    password@xxxx
    Click Button    ${Page.Login.Login.Btn}

    @{args}    Create List    Please enter a correct username and password. Note that both fields may be case-sensitive.        
    VERIFY    Page Should Contain    ${args}    
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed.    
            
[Negative Scenario] Login - Valid User And Wrong Password
    Form Login Populate Fields    tester    password@xxxx
    Click Button    ${Page.Login.Login.Btn}

    @{args}    Create List    Please enter a correct username and password. Note that both fields may be case-sensitive.        
    VERIFY    Page Should Contain    ${args}    
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
        
[Positive Scenario] Login - Valid User And Correct Password
    Form Login Populate Fields    ${DEFAULT_USERNAME}    ${DEFAULT_PASSWORD}
    Click Button    ${Page.Login.Login.Btn}

    @{args}    Create List    About the App        
    VERIFY    Page Should Contain    ${args}    
    ...    i_pass_message=Expected error message was displayed.
    ...    i_fail_message=Expected error message not displayed. 
