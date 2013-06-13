module ApplicationHelper
  def get_username(id)
    return User.find(id).name
  end
  
end
