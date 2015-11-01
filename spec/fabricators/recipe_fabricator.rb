Fabricator(:recipe) do 
  title { Faker::Lorem.words(5).join(" ") }
  text { Faker::Lorem.paragraph(5) }
  image {
    ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new(Rails.root.join("spec/support/uploads/product.jpg")),
      :type => 'image/jpg',
      :filename => File.basename(File.new(Rails.root.join("spec/support/uploads/product.jpg")))
    )
  }
end