Fabricator(:medicinal_herb) do 
  name { Faker::Lorem.words(5).join(" ") }
  english_name { Faker::Lorem.words(5).join(" ") }
  latin_name { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(3) }
  medicinal_properties { Faker::Lorem.paragraph(2) }
  use_instructions { Faker::Lorem.paragraph(2) }
  warnings { Faker::Lorem.paragraph(2) }
  image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/product.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/product.jpg")))
    )
  }
  sprout_image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/product.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/product.jpg")))
    )
  }
  
end


