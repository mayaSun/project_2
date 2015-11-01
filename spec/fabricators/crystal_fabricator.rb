Fabricator(:crystal) do 
  name { Faker::Lorem.words(2).join(" ") }
  english_name { Faker::Lorem.words(2).join(" ") }
  price { (100..500).to_a.sample }
  hardness { (1..10).to_a.sample }
  chemical_formula { Faker::Lorem.words(2).join(" ") }
  qualities { Faker::Lorem.paragraph(1) }
  use_instructions { Faker::Lorem.paragraph(2) }
  warnings { Faker::Lorem.paragraph(2) }
  chemical_formula { Faker::Lorem.words(2).join(" ") }
  image_link { Faker::Internet.url }
  image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/product.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/product.jpg")))
    )
  }

end