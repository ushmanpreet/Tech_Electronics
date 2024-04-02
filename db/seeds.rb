require 'csv'

# Delete existing records to avoid duplication
ProductCategory.destroy_all
Product.destroy_all
Category.destroy_all

categories = ['Furniture', 'Home Decor', 'Storage and Organization', 'Lighting and Accessories']

categories.each do |category_name|
  Category.create!(category_name: category_name)
end

csv_file = Rails.root.join('db', 'data.csv')

CSV.foreach(csv_file, headers: true) do |row|
  product = Product.create!(
    product_name: row['product_name'],
    description: row['description'],
    price: row['price'].to_f,
    stock_quantity: row['stock_quantity'].to_i
  )

  # Randomly selects a category and associate it with the product
  category = Category.offset(rand(Category.count)).first
  product.categories << category
end

puts "Seeding completed!"
