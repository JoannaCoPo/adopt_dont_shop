class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @applications = Application.all
  end

  def new
  end

  def create
    new_application = Application.new(application_params)
    if new_application.save
      redirect_to "/applications/#{new_application.id}"
    else
      flash[:incomplete] = 'You are missing one or more fields; please complete all fields to submit applicaiton.'
      redirect_to '/applications/new'
    end
  end

  def application_params
    params.permit(:name, :address, :description, :desired_pets, :city, :state, :zip)
  end
end
