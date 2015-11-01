Fabricator(:product) do 
  name { Faker::Lorem.words(5).join(" ") }
  english_name { Faker::Lorem.words(5).join(" ") }
  short_description { Faker::Lorem.paragraph(1) }
  long_description { Faker::Lorem.paragraph(2) }
  use_instructions { Faker::Lorem.paragraph(2) }
  warnings { Faker::Lorem.paragraph(2) }
  ingridience { Faker::Lorem.paragraph(2) }
  price { (10..100).to_a.sample }
  stock { (0..500).to_a.sample }
  quantity { (100..1000).to_a.sample }
  quantity_unit {['גרם','מ"ל'].sample} 
  package_weight { (100..1000).to_a.sample }
  image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/product.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/product.jpg")))
    )
  }
  category { Fabricate(:category) }
end