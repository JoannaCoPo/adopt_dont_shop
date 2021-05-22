class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @applications = Application.all
  end

  def new
  end

  def create
    application = Application.create(application_params)
    application.save
    redirect_to "/applications/#{application.id}"
  end

  def application_params
    params.permit(:name)
    params.permit(:address)
    params.permit(:description)
    params.permit(:desired_pets)
    params.permit(:created_at)
    params.permit(:updated_at)
    params.permit(:city)
    params.permit(:state)
    params.permit(:zip_code)
  end
end
