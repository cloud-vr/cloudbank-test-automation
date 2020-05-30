*** Settings ***
Resource    ../../templates/01 Login/template_Login.robot
Suite Setup    GoTo Cloud Bank Page          
Suite Teardown    Logout
Test Template    Login Template    

*** Test Cases ***
01 - Negative Scenario - Login - All Fields Are Empty
    ${CURDIR}\\data\\01.json

02 - Negative Scenario - Login - Username Field Empty
    ${CURDIR}\\data\\02.json

03 - Negative Scenario - Login - Password Field Empty
    ${CURDIR}\\data\\03.json

04 - Negative Scenario - Login - Invalid User
    ${CURDIR}\\data\\04.json   
            
05 - Negative Scenario - Login - Valid User And Wrong Password
    ${CURDIR}\\data\\05.json 
        
06 - Positive Scenario - Login - Valid User And Correct Password
    ${CURDIR}\\data\\06.json 