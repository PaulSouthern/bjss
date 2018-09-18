# used to make element wait for certain amount of time
# @example
#   wait(3).until { @driver.find_element(id: 'layer_cart').displayed? }
def wait(seconds)
  Selenium::WebDriver::Wait.new(timeout: seconds)
end

# used to mouse over a certain element
# @example
#   mouse_over_element(@driver.find_element(class: 'first-item-of-mobile-line'))
def mouse_over_element(element)
  @driver.action.move_to(element).perform
end
