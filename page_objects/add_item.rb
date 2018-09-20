class AddItem

  def initialize(driver)
    @driver = driver
  end

  def view_item(item)
    @driver.find_element(class: item).click
  end

  def quick_view_item(item)
    @driver.action.move_to(view_item(item)).perform
    @driver.find_element(class: 'quick-view').click
    wait(10).until { @driver.find_element(id: 'group_1').displayed? }
  end

  def item_name
    @driver.find_element(css: "h1[itemprop=name]")
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
