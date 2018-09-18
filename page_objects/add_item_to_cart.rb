class AddItemToCart

  ITEM = { class: 'last-item-of-mobile-line' }
  SUBMIT_BUTTON = { css: 'button' }
  SUCCESS_MESSAGE = { css: '.flash.success' }

  def initialize(driver)
    @driver = driver
  end

  def with(item, size: nil)
    @driver.find_element(item).click
    @driver.find_element(id: 'group_1').find_element(css: "option[title=#{size}]").click
    return item_size = @driver.find_element(id: 'group_1').find_element(css: "option[selected]").text
    return item_price = @driver.find_element(id: 'our_price_display').text.split('$')
    @driver.find_element(id: 'add_to_cart').click
    wait(3).until { @driver.find_element(id: 'layer_cart').displayed? }
  end

  def success_message_present?
    @driver.find_element(SUCCESS_MESSAGE).displayed?
  end
end
