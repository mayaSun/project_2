require 'spec_helper'

feature 'Admin Add Medical Activity' do

  given(:admin) {Fabricate(:admin)}
  background do
    page.set_rack_session(user_id: admin.id)
  end

  scenario "admin add update and delete medical activities" do
       
    set_categories
        
    rosmary = Fabricate(:medicinal_herb)
    mint = Fabricate(:medicinal_herb)

    visit home_path
    # Add Medical Activities
    disinfects_wounds = add_new_medical_activity([rosmary.id])
    check_medical_activity_pages(disinfects_wounds, [rosmary.id])
    diarrheic = add_new_medical_activity([rosmary.id, mint.id])
    check_medical_activity_pages(diarrheic, [rosmary.id, mint.id])
    anti_viraly = add_new_medical_activity([])
    check_medical_activity_pages(anti_viraly,[])
    # Updates
    update_medical_activity_attribute(disinfects_wounds, 'name', 'new name')
    check_medical_activity_attribute_and_return_old_value(disinfects_wounds, 'name', 'new name')
 
    update_medical_activity_attribute(disinfects_wounds, 'english_name', 'tahini')
    check_medical_activity_attribute_and_return_old_value(disinfects_wounds, 'english_name', 'Tahini')

    update_medical_activity_attribute(disinfects_wounds, 'description', 'bla bla bla bla')
    check_medical_activity_attribute_and_return_old_value(disinfects_wounds, 'description', 'bla bla bla bla')

    test_medical_activity_medicinal_herb_update(disinfects_wounds, [mint.id])

    # Delete
    expect(MedicalActivity.count).to eq(3)
    delete_medical_activity(disinfects_wounds)
    expect(MedicalActivity.count).to eq(2)
  end

  def add_new_medical_activity(medicinal_herb_ids)
    medical_activity_attr = Fabricate.attributes_for(:medical_activity, medicinal_herb_ids: medicinal_herb_ids)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "בעיות רפואיות"
    click_link 'הוסף בעיה רפואית לאתר'
    fill_in 'medical_activity_name', with: medical_activity_attr[:name]
    fill_in 'medical_activity_english_name', with: medical_activity_attr[:english_name]
    fill_in 'medical_activity_description', with: medical_activity_attr[:description]
    medicinal_herb_ids.each do |id|
      check "medical_activity_medicinal_herb_ids_#{id}" 
    end
    page.find('#medical_activity-form-submit').click
    return MedicalActivity.last
  end

  def check_medical_activity_pages(medical_activity, medicinal_herb_ids)
    #Check Category Page
    main_menu = page.find('.info-main-menu')
    main_menu.click_link 'לפי התאמה לבעייה רפואית'
    click_link medical_activity.name
    expect(page).to have_content medical_activity.name
    expect(page).to have_content (medical_activity.description)
    medicinal_herb_ids.each do |id|
      medicinal_herb =  MedicinalHerb.find(id)
      expect(page).to have_content medicinal_herb.name
      expect(page).to have_css ("img[src$='#{medicinal_herb.image}']")
    end
  end

  def update_medical_activity_attribute(medical_activity, attribute, value)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "בעיות רפואיות"
    find("a[href='/admin/medical_activities/#{medical_activity.slug}/edit']").click
    fill_in "medical_activity_#{attribute}", with: value
    page.find('#medical_activity-form-submit').click
  end

  def check_medical_activity_attribute_and_return_old_value(medical_activity, attribute, value)
    medical_activity_from_db = MedicalActivity.find(medical_activity.id)
    expect(medical_activity_from_db.name).to eq(medical_activity.name) unless attribute == 'name'
    expect(medical_activity_from_db.english_name).to eq(medical_activity.english_name) unless attribute == 'english_name'
    expect(medical_activity_from_db.description).to eq(medical_activity.description) unless attribute == 'description'
    expect(medical_activity_from_db.medicinal_herb_ids).to eq(medical_activity.medicinal_herb_ids) unless attribute == 'medicinal_herb_ids'        
    if attribute
      expect(medical_activity_from_db[attribute.to_sym]).to eq(value)
      medical_activity_from_db.update_attribute(attribute.to_sym, medical_activity[attribute.to_sym])
    end
  end

    def test_medical_activity_medicinal_herb_update(medical_activity, medicinal_herb_ids)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "בעיות רפואיות"
    find("a[href='/admin/medical_activities/#{medical_activity.slug}/edit']").click
    medical_activity.medicinal_herb_ids.each do |id|
      uncheck "medical_activity_medicinal_herb_ids_#{id}" 
    end 
    medicinal_herb_ids.each do |id|
      check "medical_activity_medicinal_herb_ids_#{id}" 
    end 
    page.find('#medical_activity-form-submit').click
    expect(MedicalActivity.find(medical_activity.id).medicinal_herb_ids).to eq(medicinal_herb_ids)
    medical_activity.update(medicinal_herb_ids: medical_activity.medicinal_herb_ids)
  end
  
  def delete_medical_activity(medical_activity)
    click_link "Administration"
    menu = find('.admin-menu').find('.hidden-xs').find('.list-group')
    menu.click_link "בעיות רפואיות"
    find("a[href='/admin/medical_activities/#{medical_activity.slug}']").click
  end

end