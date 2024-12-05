class ApartmentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_apartment, only: [:destroy]

  def index
    @apartments = Apartment.all
    if params[:query].present?
      @apartments = Apartment.where("address ILIKE ?", "%#{params[:query]}%")
    end

    @markers = @apartments.geocoded.map do |apartment|
      {
        lat: apartment.latitude,
        lng: apartment.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {apartment: apartment})
      }
    end
  end

  def show
    @apartment = Apartment.find(params[:id])
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params)

    @apartment.user = current_user

    if @apartment.save
      redirect_to @apartment, notice: 'Apartment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end

  end

  def destroy
    @apartment = Apartment.find(params[:id])
    @apartment.destroy
    redirect_to apartments_path, status: :see_other

  end

  private

  def apartment_params
    params.require(:apartment).permit(:address, :availability, :price_per_night, :user_id, :description, :title, photos: [])
  end
end
