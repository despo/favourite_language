# Manages requests related to searching and displaying a user's favourite programming language
class SearchController < ApplicationController
  # Use GET to search and render Favourite Language search page
  def show
    build_user if searched?
  end

  private

  # Mark the username parameter as safe for usage by the user model
  def user_params
    user_params = params[:user] || ActionController::Parameters.new
    user_params.permit(:username)
  end

  # Build and check the validity of the User model using the specified parameters
  #  # This way appropriate validation errors are rendered on the relevant fields
  def build_user
    @user = User.new(user_params)
    @user.valid?
  end

  # Check if the user has fired a search event by submitting the form
  def searched?
    params[:commit].present?
  end
end
