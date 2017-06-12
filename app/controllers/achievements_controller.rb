class AchievementsController < ApplicationController

  before_action :authenticate_user!, only: [
    :new,
    :create,
    :edit,
    :update,
    :destroy
  ]

  before_action :owner_only, only: [
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
  end

  #
  #
  # Update
  def update
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
    @achievement.destroy
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

  def owner_only
    @achievement = Achievement.find(params[:id])
    if current_user != @achievement.user
      redirect_to achievements_path
    end
  end

end