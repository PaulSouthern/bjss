class Login

  LOGIN_BUTTON = { class: 'login' }
  EMAIL_INPUT = { id: 'email' }
  PASSWORD_INPUT = { id: 'passwd' }
  SUBMIT_BUTTON = { id: 'SubmitLogin' }

  def initialize(driver)
    @driver = driver
    @driver.get 'http://automationpractice.com'
  end

  def with(username, password)
    # Sign In
    @driver.find_element(LOGIN_BUTTON).click
    @driver.find_element(EMAIL_INPUT).send_keys(username)
    @driver.find_element(PASSWORD_INPUT).send_keys(password)
    @driver.find_element(SUBMIT_BUTTON).click
  end
end
