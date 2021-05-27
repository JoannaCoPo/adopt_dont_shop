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

  def update
    application = Application.find(params[:id])
    # application.update(status: params[:status],
    #                    status: 'Pending')
    application.update(description: params[:description],
                       status: 'Pending')
    application.save
    redirect_to "/applications/#{params[:id]}"
  end

  def add_pet_to_app
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @application.pets << @pet
    # render :show
    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :description, :desired_pets, :city, :state, :zip, :search)
  end
end
