Fabricator(:shopping_cart_item) do
  position {Fabricate(:user)}
  sellable {Fabricate(:product)}
  qty {(1..50).to_a.sample}
end