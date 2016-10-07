class Users::RegistrationsController < Devise::RegistrationsController
	
	before_filter :select_plan, only: :new
	
	def create
		super do |resource|
			if resource.plan_id = params[:plan]
				if 2 == resource.plan_id
					resource.save_with_payment
				else
					resource.save
				end
			end
		end
	end
	
	private
		def select_plan
			unless params[:plan] && ['1', '2'].include?(params[:plan])
				flash.notice = 'Please select a membership plan to sign up'
				redirect_to root_url
			end
		end
end