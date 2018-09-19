class AddItem

  def initialize(driver)
    @driver = driver
  end

  def item(item)
    @driver.find_element(class: item)
  end

  def select_size(size)
    @driver.find_element(id: 'group_1').find_element(css: "option[title=#{size}]")
  end

  def default_size
    @driver.find_element(id: 'group_1').find_element(css: "option[selected]")
  end

  def price
    @driver.find_element(id: 'our_price_display').text.split('$')
  end

  def add_to_cart
    @driver.find_element(id: 'add_to_cart')
  end
end
