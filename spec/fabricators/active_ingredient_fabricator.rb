Fabricator(:active_ingredient) do 
  name { Faker::Lorem.words(5).join(" ") }
  english_name { Faker::Lorem.words(5).join(" ") }
  description { Faker::Lorem.paragraph(2) }
end