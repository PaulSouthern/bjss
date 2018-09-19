class ReviewOrders

  def initialize(driver)
    @driver = driver
  end

  def select_order(order)
    @driver.find_element(class: order)
  end

  def select_item(item)
    @driver.find_element(name: 'id_product').find_element(css: "option[value='#{item}']")
  end

  def add_message(message_text)
    @driver.find_element(name: 'msgText').send_keys(message_text)
  end

  def send_message
    @driver.find_element(css: 'button[name="submitMessage"]')
  end
end
