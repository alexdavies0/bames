class BookingsController < ApplicationController
  before_action :set_booking, only: [ :show, :destroy ]
  before_action :set_user
  before_action :set_game, only: [ :create ]
  before_action :authenticate_admin!, only: [ :admin_index ]

  def index
      @bookings = current_user.bookings
      @today = Date.today
  end

  def admin_index
    @bookings = Booking.all
    @users = User.all
    @today = Date.today
  end

  def show
    @booking = Booking.find(params[:id])
    @today = Date.today
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @game = Game.find(params[:game_id])
    @booking.user = current_user
    @booking.game = @game
    @booking.save
    if @booking.save!
      redirect_to bookings_path
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    @bookings = current_user.bookings
    render "/bookings/index"
  end

  private

  def set_game
    @game = Game.where((params[:game_id]) == :id)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :game_id, :user_id)
  end

  def set_user
    if user_signed_in?
      @user = current_user
    end
  end

end
