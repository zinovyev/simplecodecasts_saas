class ProfilesController < ApplicationController
	def new
		# form where each user can fill out their own profile
		raise 'Access Denied' unless current_user.id == params[:user_id].to_i
			@user = User.find(params[:user_id])
			@profile = @user.build_profile
	end
	
	def create
		@user = User.find(params[:user_id])
		@profile = @user.build_profile(profile_params)
		if @profile.save
			flash[:success] = 'Profile sucessfully created!'
			redirect_to user_path(params[:user_id])
		else
			render action: :new
		end
	end
	
	private
		def profile_params
			params.require(:params).permit(:first_name, :last_name, :job_title, :phone_number, :contact_email, :description)
		end
end