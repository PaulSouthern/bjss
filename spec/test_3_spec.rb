describe 'Test 3: Capture Images' do
  it 'Add Message to Previous Order' do
    # Sign In
    @login.with('pstestaccount180918@mail.com','BJSSTest')
    @navigation.orders.click

    # Add message
    @driver.find_element(class: 'color-myaccount').click
    wait(3).until { @driver.find_element(name: 'id_product').displayed? }
    @review_orders.select_item('1').click
    @review_orders.add_message('message_text')
    @review_orders.send_message.click
    wait(3).until { @driver.find_element(class: 'alert-success').displayed? }

    # Failed Expectations
    begin
      expect(@driver.find_element(class: 'alert-success').displayed?).to be_falsey
    rescue RSpec::Expectations::ExpectationNotMetError => error
      puts error.message
      @driver.save_screenshot "./tmp/failures/#{Time.now.strftime("failshot__%d_%m_%Y__%H_%M_%S")}.png"
    end

    # Logout
    @navigation.logout.click
  end
end
