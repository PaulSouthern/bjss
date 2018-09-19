require 'selenium-webdriver'
require 'pry'
require 'rspec'

require_relative '../helpers/helpers'
require_relative '../page_objects/login'
require_relative '../page_objects/add_item'
require_relative '../page_objects/cart'
require_relative '../page_objects/navigation'
require_relative '../page_objects/checkout'


describe 'Test 1: Happy Path' do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @login = Login.new(@driver)
    @add_item = AddItem.new(@driver)
    @cart = Cart.new(@driver)
    @navigation = Navigation.new(@driver)
    @checkout = Checkout.new(@driver)
  end

  after(:each) do
    @driver.quit
  end

  it 'Purchases 2 items' do
    # Sign In
    @driver.manage.window.maximize
    @login.with('pstestaccount180918@mail.com','testing')
    @navigation.home.click
    @driver.find_element(class: 'first_item').find_element(class: 'btn')

    # Add item one
    @add_item.item('first-item-of-mobile-line').click
    item_one_size = 'L'
    @add_item.select_size(item_one_size).click
    item_one_price = @add_item.price
    @add_item.add_to_cart.click

    # Wait until cart is displayed
    @cart.wait_for_cart

    # Continue Shopping
    @cart.continue_shopping.click

    # Navigate to Home Move to top of page
    @navigation.scroll_to_top
    @navigation.home.click

    # Add item two
    @add_item.item('last-item-of-mobile-line').click
    item_two_size = @add_item.default_size.text
    item_two_price = @add_item.price
    @add_item.add_to_cart.click

    # Wait until cart is displayed
    @cart.wait_for_cart

    # Proceed to Checkout
    @cart.proceed_to_checkout.click

    # Store values to test
    checkout_item_one_price = @checkout.price('product_1_5_0_99608').text.split('$')
    checkout_item_one_size = @checkout.size('product_1_5_0_99608').text
    checkout_item_two_price = @checkout.price('product_2_7_0_99608').text.split('$')
    checkout_item_two_size = @checkout.size('product_2_7_0_99608').text
    shipping_cost = @checkout.shipping_cost.text.split('$')
    total_products = @checkout.total_product.text.split('$')
    total = @checkout.total_price.text.split('$')

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
    @checkout.proceed_checkout_button.click
    @checkout.address_continue_button.click
    @checkout.terms_and_conditions.click
    @checkout.proceed_checkout_button.click
    @checkout.bankwire_payment.click
    @checkout.confirm_order.click

    # Logout
    @navigation.logout.click
  end
end

# TODO

# Open Quick View
# @driver.action.move_to(@driver.find_element(class: 'first-item-of-mobile-line')).perform
# @driver.find_element(class: 'quick-view').click
# wait(3).until { @driver.find_element(id: 'group_1').displayed? }
# Get Product ID
# item_one_product_id = (css: 'input[type="checkbox"]').text
