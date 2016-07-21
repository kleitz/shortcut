class CargoOwnersController < ApplicationController

	def index
		
	end

	def show
		
	end

	def new
		username = params[:username]
		password = params[:password]
		second_password = params[:repeat_password]
		first_name = params[:first_name]
		last_name = params[:last_name]
		email = params[:email_address]
		phone_number = params[:phone_number]
		country = params[:country]
		@user = CargoOwner.where("username = ?", username)
		
		if @user.empty? != true
			if @user[0].username == username
				flash[:alert] = "User already exists"
				render 'index'
			end
		elsif username.empty?
			flash[:alert] = "Username cannot be empty"
			render 'index'
		elsif password != second_password
			flash[:alert] = "Passwords are not the same"
			render 'index'
		else
			CargoOwner.create(username: username, password_digest: password, first_name: first_name,
			last_name: last_name, email_address: email, phone_number: phone_number, country: country)
			flash[:alert] = "Account successfully created. Please login to your account"
			render 'show'
		end
	end

	def profile
		user_id = params[:id]
		user = CargoOwner.where("id = ?", user_id)

		if user != nil
			@user = user[0]
			@cargo = Cargo.where("cargo_owner_id = ?", user_id)
			render 'profile'
		end
	end
end
