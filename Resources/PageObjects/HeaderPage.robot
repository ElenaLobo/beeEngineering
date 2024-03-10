*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
click on the products option
    click link   xpath://header/div[1]/div[1]/div[1]/div[2]/div[1]/ul[1]/li[2]/a[1]
    wait until page contains element    id:search_product

click on the cart option
    click link   xpath://*[@id="header"]/div/div/div/div[2]/div/ul/li[3]/a
    wait until page contains element    id:cart_info_table