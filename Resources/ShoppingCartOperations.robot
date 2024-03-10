*** Settings ***
Library  SeleniumLibrary
Resource   PageObjects/HeaderPage.robot

*** Keywords ***
validate shopping cart
    [Arguments]    ${theProductCart1}    ${theProductCart2}   ${theItemPrice1}   ${theItemPrice2}
    page should contain    ${theProductCart1}
    page should contain    ${theProductCart2}
    page should contain    ${theItemPrice1}
    page should contain    ${theItemPrice2}