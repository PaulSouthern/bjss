require 'selenium-webdriver'
require 'pry'
require 'rspec'
require_relative '../helpers/helpers'

describe 'Test 1: Happy Path' do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
  end

  after(:each) do
    @driver.quit
  end

  it 'Purchases 2 items' do
    # Navigate to site
    @driver.get 'http://automationpractice.com'

    # Sign In
    @driver.find_element(class: 'login').click
    @driver.find_element(id: 'email').send_keys('pstestaccount180918@mail.com')
    @driver.find_element(id: 'passwd').send_keys('testing')
    @driver.find_element(id: 'SubmitLogin').click

    # Add item one
    @driver.find_element(class: 'home').click
    @driver.find_element(class: 'first-item-of-mobile-line').click
    # Open Quick View
    # @driver.action.move_to(@driver.find_element(class: 'first-item-of-mobile-line')).perform
    # @driver.find_element(class: 'quick-view').click
    # wait(3).until { @driver.find_element(id: 'group_1').displayed? }
    # Get Product ID
    # item_one_product_id = (css: 'input[type="checkbox"]').text

    # Change Size: Note 'title' attribute used instead of 'value' to guard against changes to index
    item_one_size = 'L'
    @driver.find_element(id: 'group_1').find_element(css: "option[title=#{item_one_size}]").click
    item_one_price = @driver.find_element(id: 'our_price_display').text.split('$')
    @driver.find_element(id: 'add_to_cart').click
    # Wait until cart is displayed
    wait(3).until { @driver.find_element(id: 'layer_cart').displayed? }

    # Continue Shopping
    @driver.find_element(class: 'continue').click

   # Navigate to Home Move to top of page
    @driver.execute_script('window.scrollTo(0,0)')
    @driver.find_element(class: 'home').click

    # Add second item
    @driver.find_element(class: 'last-item-of-mobile-line').click
    # item_two_product_id =
    item_two_size = @driver.find_element(id: 'group_1').find_element(css: "option[selected]").text
    item_two_price = @driver.find_element(id: 'our_price_display').text.split('$')
    @driver.find_element(id: 'add_to_cart').click
    wait(3).until { @driver.find_element(id: 'layer_cart').displayed? }

    # Proceed to Checkout
    @driver.find_element(css: 'a[title="Proceed to checkout"]').click
    
    # Store values to test
    checkout_item_one_price = @driver.find_element(id: 'product_1_5_0_99608').find_element(class: 'cart_total') \
    .find_element(class: 'price').text.split('$')
    checkout_item_one_size = @driver.find_element(id: 'product_1_5_0_99608').find_element(class: 'cart_description').text
    checkout_item_two_price = @driver.find_element(id: 'product_2_7_0_99608').find_element(class: 'cart_total') \
    .find_element(class: 'price').text.split('$')
    checkout_item_two_size = @driver.find_element(id: 'product_2_7_0_99608').find_element(class: 'cart_description').text
    shipping_cost = @driver.find_element(id: 'total_shipping').text.split('$')
    total_products = @driver.find_element(id: 'total_product').text.split('$')
    total = @driver.find_element(id: 'total_price_without_tax').text.split('$')

    # Expectations
    # Item Sizes
    expect(checkout_item_one_size).to include "Size : #{item_one_size}"
    expect(checkout_item_two_size).to include "Size : #{item_two_size}"
    # Item Prices
    expect(checkout_item_one_price[1].to_i).to eql (item_one_price[1].to_i)
    expect(checkout_item_two_price[1].to_i).to eql (item_two_price[1].to_i)
    # Total Products
    expect(total_products[1].to_i).to eql (item_one_price[1].to_i + item_two_price[1].to_i)
    # Total
    expect(total[1].to_i).to eql (item_one_price[1].to_i + item_two_price[1].to_i + shipping_cost[1].to_i)

    # Checkout
    @driver.find_element(class: 'standard-checkout').click
    @driver.find_element(name: 'processAddress').click
    @driver.find_element(css: 'input[type="checkbox"]').click
    @driver.find_element(class: 'standard-checkout').click
    @driver.find_element(class: 'bankwire').click
    @driver.find_element(css: 'button[type="submit"]').click

    # Logout
    @driver.find_element(class: 'logout').click
  end
end

