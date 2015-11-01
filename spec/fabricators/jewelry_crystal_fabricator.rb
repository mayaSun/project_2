Fabricator(:jewelry_crystal) do 
  jewelry { Fabricate(:jewelry)}
  crystal { Fabricate(:crystal)}
  price { (100..500).to_a.sample }
end
