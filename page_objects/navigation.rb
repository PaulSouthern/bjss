class Navigation

  def initialize(driver)
    @driver = driver
  end

  def home
    @driver.find_element(class: 'home').click
    wait(3).until { @driver.find_element(class: 'columns-container').displayed? }
  end

  def scroll_to_top
    @driver.execute_script('window.scrollTo(0,0)')
  end

  def logout
    @driver.find_element(class: 'logout')
  end

  def orders
    @driver.find_element(css: 'a[title="Orders"]')
  end
end
