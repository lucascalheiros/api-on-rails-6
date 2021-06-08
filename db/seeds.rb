Product.delete_all
User.delete_all

5.times do
  user = User.create! email: Faker::Internet.email, password: '000'
  puts "Created user: #{user.email}"

  3.times do
    product = Product.create!(
      title: Faker::Commerce.product_name,
      price: rand(1.0..100.0),
      published: true,
      user_id: user.id
    )
    puts "Creating a product: #{product.title}"
  end
end
