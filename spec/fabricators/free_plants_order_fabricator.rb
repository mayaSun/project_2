Fabricator(:free_plants_order) do
  plant_1 { Faker::Name.name }
  plant_2 { Faker::Name.name }
  delivery_method { Faker::Name.name }
  address { Fabricate(:address)}
end