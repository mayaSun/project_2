Fabricator(:order) do
  delivery_method { 'Israel Post' }
  shipping_address_id { Fabricate(:address).id}
  billing_address_id  { Fabricate(:address).id}
 end