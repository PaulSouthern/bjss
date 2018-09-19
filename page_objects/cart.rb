class Cart

  def initialize(driver)
    @driver = driver
  end

  def item(item)
    @driver.find_element(class: item)
  end

  def wait_for_cart
    wait(3).until { @driver.find_element(id: 'layer_cart').displayed? }
  end

  def continue_shopping
    @driver.find_element(class: 'continue')
  end

  def proceed_to_checkout
    @driver.find_element(css: 'a[title="Proceed to checkout"]')
  end
end
