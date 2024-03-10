*** Settings ***
Library  SeleniumLibrary
Library     String
Documentation    Search Items And Shopping Cart Functionality


*** Variables ***
${browser}  chrome
${url}  https://automationexercise.com/
${pageSearchState}  Searched Products
&{search_terms}    name=my_value1    password=my_value2
${searchTerm1}    men tshirt
${productCart1}    Men Tshirt
#Initial price is negative to track issues in price
${itemPrice1}    -1
${searchTerm2}    blue top
${productCart2}    Blue Top
#Initial price is negative to track issues in price
${itemPrice2}    -1

*** Test Cases ***
Verify the shopping cart displays the correct total value for two items
    [Documentation]    This test case verifies search, shopping cart addition and total value for two items
    [Tags]    Functional

    prepare execution
    ${itemPrice1}=    search product   ${searchTerm1}
    add product to shopping cart
    ${itemPrice2}=    search product   ${searchTerm2}
    add product to shopping cart
    validate shopping cart  ${searchTerm1}  ${searchTerm2}  ${itemPrice1}   ${itemPrice2}
    #close browser

*** Keywords ***
prepare execution
    #Opens the browser and maximizes the window
    open browser    ${url} ${browser}
    maximize browser window

search product
    #Searches for a term accessing the search from the main menu (on the top of the page)
    #Input: search term
    #Output: price of the item
    [Arguments]    ${theSearchTerm}
    click link   xpath://header/div[1]/div[1]/div[1]/div[2]/div[1]/ul[1]/li[2]/a[1]
    wait until page contains element    id:search_product
    input text    id:search_product     ${theSearchTerm}
    click button    id:submit_search
    wait for condition    return document.readyState == "complete"
    page should contain    ${pageSearchState}
    page should contain    View Product
    mouse down    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
    wait until element is visible    xpath://html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[2]/div/h2
    ${thePrice}=    get element attribute    xpath://body[1]/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/h2[1]    innerText

    #In case it is necessary to extract the value later, use the following sentence
    #${thePrice}=    remove string    ${thePrice}    ,   Rs.

    mouse up    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
    [Return]    ${thePrice}

add product to shopping cart
    mouse down    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
    mouse up    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
    wait until element is visible    xpath://html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[2]/div/h2
    set focus to element    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/a[1]
    click link    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/a[1]

    #handling the confirmation modal
    wait until element is visible    xpath://*[@id="cartModal"]/div/div/div[3]/button
    set focus to element   xpath://*[@id="cartModal"]/div/div/div[3]/button
    click element    xpath://*[@id="cartModal"]/div/div/div[3]/button

    #handles the delay between dismissing the confirmation modal and page being ready again
    wait for condition    return document.readyState == "complete"

validate shopping cart
    [Arguments]    ${theSearchTerm1}    ${theSearchTerm2}   ${theItemPrice1}   ${theItemPrice2}
    click link   xpath://*[@id="header"]/div/div/div/div[2]/div/ul/li[3]/a
    wait until page contains element    id:cart_info_table
    page should contain    ${productCart1}
    page should contain    ${productCart2}
    page should contain    ${theItemPrice1}
    page should contain    ${theItemPrice2}