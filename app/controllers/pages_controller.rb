class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @apartments = Apartment.all # Fetch all apartments from the database
  end
end
