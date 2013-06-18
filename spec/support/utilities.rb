include ApplicationHelper

def valid_login(user)
  fill_in "Username",    with: user.username
  fill_in "Password", with: user.password
  click_button "Log in"
end