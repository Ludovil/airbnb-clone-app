class ApartmentsController < ApplicationController

  def index
    @apartments = Apartment.all

  end

  def show
    @apartment = Apartment.find(params[:id])
  end

  def create
    @apartment = Apartment.new(apartment_params)

    if @apartment.save
      redirect_to @apartment, notice: 'Apartment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end

  end

  private

  def apartment_params
    params.require(:apartment).permit(:address, :availability, :photos, :user_id)
  end
end
