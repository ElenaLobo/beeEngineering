*** Settings ***
Library  SeleniumLibrary
#Library     String



*** Keywords ***
search product
    #Searches for a term accessing the search from the main menu (on the top of the page)
    #Input: search term
    #Output: price of the item
    [Arguments]    ${theSearchTerm}     ${thePageSearchState}       ${theCardElement}
    #click link   xpath://header/div[1]/div[1]/div[1]/div[2]/div[1]/ul[1]/li[2]/a[1]
    #wait until page contains element    id:search_product
    input text    id:search_product     ${theSearchTerm}
    click button    id:submit_search
    wait for condition    return document.readyState == "complete"
    page should contain    ${thePageSearchState}
    page should contain    ${theCardElement}
    mouse down    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
    wait until element is visible    xpath://html/body/section[2]/div/div/div[2]/div/div[2]/div/div[1]/div[2]/div/h2
    ${thePrice}=    get element attribute    xpath://body[1]/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/h2[1]    innerText

    #In case it is necessary to extract the value later, use the following sentence
    #It is also necessary to uncomment the Library String reference in the Settings section
    #${thePrice}=    remove string    ${thePrice}    ,   Rs.

    mouse up    xpath://body/section[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]
    RETURN    ${thePrice}

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