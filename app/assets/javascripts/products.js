$(document).on("change","#quantity_product",function(){
  var productId = $(this).children(":selected").data('product-id');
  var price = $(this).children(":selected").data('product-price');
  var priceNew = '#product_' + productId + '_price';
  $(priceNew).text(price + 'ש"ח');  
  $('#package_type' + productId).val($(this).val());
})