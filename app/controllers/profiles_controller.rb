class ProfilesController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in

  def show
    @user = current_user  # Fetch the current logged-in user
    @upcoming_bookings = current_user.bookings.where('start_date > ?', Time.now).order(:start_date)
    @previous_bookings = current_user.bookings.where('end_date < ?', Time.now).order(end_date: :desc)
    @listed_apartments = current_user.apartments.reverse
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
