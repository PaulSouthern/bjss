require 'selenium-webdriver'
require 'pry'
require 'rspec'

require_relative '../helpers/helpers'
require_relative '../page_objects/login'
require_relative '../page_objects/navigation'
require_relative '../page_objects/review_orders'


describe 'Test 2: Review Previous Orders' do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @login = Login.new(@driver)
    @navigation = Navigation.new(@driver)
    @review_orders = ReviewOrders.new(@driver)
  end

  after(:each) do
    @driver.quit
  end

  it 'Add Message to Previous Order' do
    # Sign In
    @login.with('pstestaccount180918@mail.com','testing')
    @navigation.orders.click

    # Add message
    @driver.find_element(class: 'color-myaccount').click
    wait(3).until { @driver.find_element(name: 'id_product').displayed? }
    @review_orders.select_item('1').click
    @review_orders.add_message('message_text')
    @review_orders.send_message.click
    wait(3).until { @driver.find_element(class: 'alert-success').displayed? }

    # Expectations
    expect(@driver.find_element(class: 'alert-success').displayed?).to be_truthy

    # Logout
    @navigation.logout.click
  end
end
