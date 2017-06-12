class AchievementsController < ApplicationController

  before_action :authenticate_user!, only: [
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

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
  # Update
  def update
    @achievement = Achievement.find(params[:id])
    if @achievement.update_attributes(achievement_params)
      redirect_to achievement_path(@achievement)
    else
      render :edit
    end

  end

  #
  #
  # Show
  def show
    @achievement = Achievement.find(params[:id])
  end

  #
  #
  # Destroy
  def destroy
    Achievement.destroy(params[:id])
    redirect_to achievements_path
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