require 'selenium-webdriver'
require 'pry'
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

    # Add item one
      # Open Quick View
      @driver.find_element(class: 'first-item-of-mobile-line').click
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
      item_two_size = @driver.find_element(id: 'group_1').find_element(css: "option[selected]").text
      item_two_price = @driver.find_element(id: 'our_price_display').text.split('$')
      @driver.find_element(id: 'add_to_cart').click
      wait(3).until { @driver.find_element(id: 'layer_cart').displayed? }

    # Proceed to Checkout
      @driver.find_element(css: 'a[title="Proceed to checkout"]').click
      shipping_cost = @driver.find_element(id: 'total_shipping').text.split('$')
      total_products = @driver.find_element(id: 'total_product').text.split('$')
      total = @driver.find_element(id: 'total_price_without_tax').text.split('$')

    # Expectations
      expect(total_products[1].to_i).to eql (item_one_price[1].to_i + item_two_price[1].to_i)
      expect(total[1].to_i).to eql (item_one_price[1].to_i + item_two_price[1].to_i + shipping_cost[1].to_i)
  end
end


# Actions
#
# def mouse_over_element(element)
#   driver.action.move_to(element).perform
# end
