module IsAdmin
 extend ActiveSupport::Concern

 private
   def is_admin?
     if !current_user
       redirect_to new_user_session_path
     else
       user = User.find(current_user.id)
       user.admin
     end
   end
end
