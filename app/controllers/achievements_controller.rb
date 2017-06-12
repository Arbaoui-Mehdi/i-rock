class AchievementsController < ApplicationController

  #
  #
  # Index
  def index
    @achievements = Achievement.public_access
  end

  #
  #
  # New
  def new
    @achievement = Achievement.new
  end

  #
  #
  # Create
  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to achievement_url(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  #
  #
  # Edit
  def edit
    @achievement = Achievement.find(params[:id])
  end

  #
  #
  # Show
  def show
    @achievement = Achievement.find(params[:id])
  end

  #
  #
  # Private
  private

  def achievement_params
    params.require(:achievement)
          .permit(
            :title,
            :description,
            :privacy,
            :cover_image,
            :featured
          )
  end

end