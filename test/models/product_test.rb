require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'should have a positive price' do
    product = products(:one)
    product.price = -1
    assert_not product.valid?
  end

  test 'should filte product by name' do
    assert_equal 2, Product.filter_by_title('tv').count
  end

  test 'should filter products by name and sort them' do
    assert_equal [products(:three), products(:two)], Product.filter_by_title('tv').sort
  end

  test 'should filter products by price above and sort them' do
    assert_equal [products(:three), products(:two)], Product.above_or_equal_to_price(9).sort
  end

  test 'should filter products by price below and sort them' do
    assert_equal [products(:two), products(:one)], Product.below_or_equal_to_price(10).sort
  end

  test 'should sort product by most recent' do
    products(:two).touch
    assert_equal [products(:three), products(:one), products(:two)], Product.recent.to_a
  end
end
