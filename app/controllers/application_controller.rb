class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
  	case resource
  	  when Admin
  	     admins_top_admin_index_path
      when User
         styles_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
  	   root_path
    else
       root_path
    end
  end

end
