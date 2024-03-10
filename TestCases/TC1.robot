*** Settings ***
Resource    ../Resources/CommonFunctions.robot
Resource    ../Resources/SearchAndAddToCartFunctions.robot
Resource    ../Resources/ShoppingCartOperations.robot
Resource   ../Resources/PageObjects/HeaderPage.robot
Documentation    Search Items And Shopping Cart Functionality

Test Setup   CommonFunctions.prepare execution   ${url}  ${browser}
Test Teardown    CommonFunctions.finish test case

*** Variables ***
${browser}  firefox
${url}  https://automationexercise.com/
${pageSearchState}  Searched Products
${cardElement}      View Product
${searchTerm1}    men tshirt
${productCart1}    Men Tshirt
#Initial price is negative to track issues in price
${itemPrice1}    -1
${searchTerm2}    blue top
${productCart2}    Blue Top
#Initial price is negative to track issues in price
${itemPrice2}    -1

*** Test Cases ***
Verify the shopping cart displays the correct value for two items
    [Documentation]    This test case verifies search, shopping cart addition and total value for two items
    [Tags]    Functional

    HeaderPage.click on the products option
    ${itemPrice1}=    SearchAndAddToCartFunctions.search product   ${searchTerm1}   ${pageSearchState}  ${cardElement}
    SearchAndAddToCartFunctions.add product to shopping cart
    ${itemPrice2}=    SearchAndAddToCartFunctions.search product   ${searchTerm2}   ${pageSearchState}  ${cardElement}
    SearchAndAddToCartFunctions.add product to shopping cart
    HeaderPage.click on the cart option
    ShoppingCartOperations.validate shopping cart  ${productCart1}  ${productCart2}  ${itemPrice1}   ${itemPrice2}


*** Keywords ***


