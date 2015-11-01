Fabricator(:essential_oil) do 
  name { Faker::Lorem.words(5).join(" ") }
  english_name { Faker::Lorem.words(5).join(" ") }
  use_instructions { Faker::Lorem.paragraph(1) }
  warnings { Faker::Lorem.paragraph(2) }
  price_5ml { (100..500).to_a.sample }
  price_10ml { (100..500).to_a.sample }
  price_50ml { (100..500).to_a.sample }
  image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/product.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/product.jpg")))
    )
  }

end