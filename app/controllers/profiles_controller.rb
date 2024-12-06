class ProfilesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in


  def show
    @user = current_user  # Fetch the current logged-in user
    @upcoming_bookings = @user.bookings.where(status: 'accepted').where("start_date >= ?", Date.today).order(:start_date)
    @previous_bookings = @user.bookings.where(status: 'accepted').where("end_date < ?", Date.today).order(:end_date)
    @listed_apartments = current_user.apartments.reverse
    @bookings = @user.bookings
    if current_user == @user
      @booking_requests = Booking.joins(:apartment)
                                 .where(user_id: @user.id, status: 'pending')  # Réservations demandées par l'utilisateur
    else
      @booking_requests = Booking.joins(:apartment)
                                 .where(apartment: { user_id: @user.id }, status: 'pending')
    end
  end

  def edit
    @user = current_user  # Set up the user to be edited
  end

  def update
    @user = current_user  # Fetch the current logged-in user

    if @user.update(profile_params)
      redirect_to profile_path, notice: 'Profile updated successfully!'
    else
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:first_name, :last_name, :email)  # Add other fields you want to update
  end
end
