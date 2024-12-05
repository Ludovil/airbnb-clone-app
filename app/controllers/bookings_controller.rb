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
      redirect_to profile_path, notice: "Booking requested!"
    else
       redirect_to apartment_path(@apartment), alert: 'Unable to create booking. Check your dates.'
    end
  end

  def show
  end

  def destroy
  end

  def update
    @booking = Booking.find(params[:id])

    if @booking.apartment.user == current_user
      @booking.update(status: params[:status])
      redirect_to dashboard_path, notice: "Booking #{params[:status]}!"
    else
      redirect_to dashboard_path, alert: 'You are not authorized to perform this action.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end
