$(document).on("change","#ml_essential_oil",function(){
  var essentialOilId = $(this).children(":selected").data('essential-oil-id');
  var price = $(this).children(":selected").data('essential-oil-price');
  var priceNew = '#essential_oil_' + essentialOilId + '_price';
  $(priceNew).text(price + 'ש"ח');  
  $('#package_type' + essentialOilId).val($(this).val());
})