class BookingsController < ApplicationController
  def new
    @apartment = Apartment.find(params[:apartment_id])
    @booking = @apartment.bookings.new
  end

  def create
    @apartment = Apartment.find(params[:apartment_id])
    @booking = @apartment.bookings.new(booking_params)
    @booking.user = current_user

    if @booking.save
      redirect_to apartment_path(@apartment), notice: "Booking done."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
