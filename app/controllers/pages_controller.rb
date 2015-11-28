class PagesController <ApplicationController

  def home
    @best_sellers = Product.all.first(10)
    @new_products = Product.all.last(10)
    @categories = [Category.find_by(name: 'מזון רפואי'), Category.find_by(name: 'טיפוח קוסמטי'), Category.find_by(name: 'מוצרים מיוחדים'),Category.find_by(name: 'שמני בסיס')]
  end

  def search
    @products = Product.search_by_name(params[:search_term]) 
    @crystals = Crystal.search_by_name(params[:search_term]) 
    @medicinal_herbs = MedicinalHerb.search_by_name(params[:search_term]) 
    @medical_activities = MedicalActivity.search_by_name(params[:search_term]) 
    @active_ingredients = ActiveIngredient.search_by_name(params[:search_term]) 
  end

  def seed_bank
    @medicinal_herbs_1 = MedicinalHerb.order(:name).in_groups(4,false)[0]
    @medicinal_herbs_2 = MedicinalHerb.order(:name).in_groups(4,false)[1]
    @medicinal_herbs_3 = MedicinalHerb.order(:name).in_groups(4,false)[2]
    @medicinal_herbs_4 = MedicinalHerb.order(:name).in_groups(4,false)[3]    
  end

  def tincture
    @medicinal_herbs_1 = MedicinalHerb.order(:name).in_groups(4,false)[0]
    @medicinal_herbs_2 = MedicinalHerb.order(:name).in_groups(4,false)[1]
    @medicinal_herbs_3 = MedicinalHerb.order(:name).in_groups(4,false)[2]
    @medicinal_herbs_4 = MedicinalHerb.order(:name).in_groups(4,false)[3]    
  end

  def hydrosol
    @medicinal_herbs_1 = MedicinalHerb.order(:name).in_groups(4,false)[0]
    @medicinal_herbs_2 = MedicinalHerb.order(:name).in_groups(4,false)[1]
    @medicinal_herbs_3 = MedicinalHerb.order(:name).in_groups(4,false)[2]
    @medicinal_herbs_4 = MedicinalHerb.order(:name).in_groups(4,false)[3]    
  end

  def on_development

  end

  def thank_you
  end

end