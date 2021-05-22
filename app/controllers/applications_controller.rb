class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @applications = Application.all
  end

  def new
  end

  # def create
    # application = Application.create(application_params)
  #   application.save
    # redirect_to "/applications/#{application.id}"
  # end

  def create
    new_application = Application.new(application_params)
    new_application.save
    redirect_to "/applications/#{new_application.id}"
  end

  def application_params
    params.permit(:name, :address, :description, :desired_pets, :city, :state, :zip_code)
  end
end
