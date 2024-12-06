class BookingsController < ApplicationController
  before_action :set_booking, only: [:accept, :reject]

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
       redirect_to apartment_path(@apartment), alert: 'Unable to create booking. The apartment is not available for these dates.'
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

  def accept
    if @booking.apartment.user == current_user
      @booking.update(status: 'accepted')
      redirect_to profile_path, notice: 'Booking accepted!'
    else
      redirect_to profile_path, alert: 'You are not the host of this apartment.'
    end
  end

  def reject
    if @booking.apartment.user == current_user
      @booking.update(status: 'rejected')
      redirect_to profile_path, notice: 'Booking rejected!'
    else
      redirect_to profile_path, alert: 'You are not the host of this apartment.'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end
