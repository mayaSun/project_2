def set_current_user(user=nil)  
  session[:user_id] = user ? user.id : Fabricate(:user).id 
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end  

def sign_in(a_user=nil, password=nil) 
  user = a_user || Fabricate(:user)
  visit home_path 
  click_link("התחבר")
  fill_in "אי מייל", with: user.email
  fill_in "סיסמה", with: password ? password : user.password
  click_button "התחבר"
  sleep 1
end

def sign_out
  visit sign_out_path
end

def display_price(amount_in_cents)
  amount_in_cents/100
end

def set_categories
  Fabricate(:category, name: 'שמני בסיס') 
  Fabricate(:category, name: 'מזון רפואי') 
  Fabricate(:category, name: 'מוצרים מיוחדים')   
  Fabricate(:category, name: 'טיפוח קוסמטי') 
end