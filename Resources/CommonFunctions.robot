*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
prepare execution
    #Opens the browser and maximizes the window
    [Arguments]    ${theUrl}    ${theBrowser}
    open browser    ${theUrl}   ${theBrowser}
    maximize browser window

finish test case
    close browser