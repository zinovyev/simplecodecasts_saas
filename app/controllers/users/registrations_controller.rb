class Users::RegistrationsController < Devise::RegistrationsController
	
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
	
end