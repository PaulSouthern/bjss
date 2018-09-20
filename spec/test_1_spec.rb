describe 'Test 1: Happy Path' do
  it 'Purchases 2 items' do
    # Sign In
    @driver.manage.window.maximize
    @login.with('pstestaccount180918@mail.com','BJSSTest')
    @navigation.home

    # Add item one
    @add_item.view_item('first-item-of-mobile-line')
    item_one_size = 'L'
    @add_item.select_size(item_one_size).click
    item_one_price = @add_item.price
    @add_item.add_to_cart.click

    # Wait until cart is displayed
    @cart.wait_for_cart

    # Continue Shopping
    @cart.continue_shopping.click

    # Navigate to Home Move to top of page
    @navigation.scroll_to_top
    @navigation.home

    # Add item two
    @add_item.view_item('last-item-of-mobile-line')
    item_two_size = @add_item.default_size.text
    item_two_price = @add_item.price
    @add_item.add_to_cart.click

    # Wait until cart is displayed
    @cart.wait_for_cart

    # Proceed to Checkout
    @cart.proceed_to_checkout.click

    # Store values to test
    checkout_item_one_price = @checkout.price('product_1_5_0_99608').text.split('$')
    checkout_item_one_size = @checkout.size('product_1_5_0_99608').text
    checkout_item_two_price = @checkout.price('product_2_7_0_99608').text.split('$')
    checkout_item_two_size = @checkout.size('product_2_7_0_99608').text
    shipping_cost = @checkout.shipping_cost.text.split('$')
    total_products = @checkout.total_product.text.split('$')
    total = @checkout.total_price.text.split('$')

    # Expectations
    # Item Sizes
    expect(checkout_item_one_size).to include "Size : #{item_one_size}"
    expect(checkout_item_two_size).to include "Size : #{item_two_size}"
    # Item Prices
    expect(checkout_item_one_price[1].to_i).to eql (item_one_price[1].to_i)
    expect(checkout_item_two_price[1].to_i).to eql (item_two_price[1].to_i)
    # Total Products
    expect(total_products[1].to_i).to eql (item_one_price[1].to_i + item_two_price[1].to_i)
    # Total
    expect(total[1].to_i).to eql (item_one_price[1].to_i + item_two_price[1].to_i + shipping_cost[1].to_i)

    # Checkout
    @checkout.proceed_checkout_button.click
    @checkout.address_continue_button.click
    @checkout.terms_and_conditions.click
    @checkout.proceed_checkout_button.click
    @checkout.bankwire_payment.click
    @checkout.confirm_order.click

    # Logout
    @navigation.logout.click
  end
end

# TODO

# Get Product ID
# item_one_product_id = (css: 'input[type="checkbox"]').text
