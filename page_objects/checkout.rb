require 'selenium-webdriver'
require 'rspec'

class Checkout

  def initialize(driver)
    @driver = driver
  end

  def price(product)
    @driver.find_element(id: product).find_element(class: 'cart_total').find_element(class: 'price')
  end

  def size(product)
    @driver.find_element(id: product).find_element(class: 'cart_description')
  end

  def shipping_cost
    @driver.find_element(id: 'total_shipping')
  end

  def total_product
    @driver.find_element(id: 'total_product')
  end

  def total_price
    @driver.find_element(id: 'total_price_without_tax')
  end

  def proceed_checkout_button
    @driver.find_element(class: 'standard-checkout')
  end

  def address_continue_button
    @driver.find_element(name: 'processAddress')
  end

  def terms_and_conditions
    @driver.find_element(css: 'input[type="checkbox"]')
  end

  def bankwire_payment
    @driver.find_element(class: 'bankwire')
  end

  def confirm_order
    @driver.find_element(id: 'cart_navigation').find_element(css: 'button[type="submit"]')
  end
end
