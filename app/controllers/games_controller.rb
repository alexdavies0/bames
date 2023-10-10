class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      @games = Game.where('title LIKE ?', "%#{params[:query]}%")
    else
      @games = Game.all
    end
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
  @game = Game.new(game_params)
  @game.save
  redirect_to game_path(@game)
  end

  def edit

  end

  def update

  @game.update(game_params)

  redirect_to game_path(@game)
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :description, :image)
  end

end
