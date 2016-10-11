class ProfilesController < ApplicationController
	def new
		# form where each user can fill out their own profile
		raise 'Access Denied' unless current_user.id == params[:user_id].to_i
			@user = User.find(params[:user_id])
			@profile = @user.build_profile
	end
end