class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets_search = Pet.where(name: params[:search])
    end
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
      #consider changing to render :new per what was learned in class
    end
  end

  def application_params
    params.permit(:name, :address, :description, :desired_pets, :city, :state, :zip, :search)
  end
end
