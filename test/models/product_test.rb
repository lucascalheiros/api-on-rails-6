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

  test 'should search and find nothing' do
    search_hash = { keyword: 'tssss', min_price: '100' }  
    assert Product.search(search_hash).empty?
  end

  test 'should find a tv with price less than 10' do
    search_hash = { keyword: 'tv', min_price: '10' }  
    assert_equal 1, Product.search(search_hash).length
  end


  test 'should find by id' do
    search_hash = { product_ids: products(:one).id }  
    assert_equal [products(:one)], Product.search(search_hash)
  end
end
