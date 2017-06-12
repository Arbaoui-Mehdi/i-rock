require 'rails_helper'

describe AchievementsController do

  #
  #
  # New
  describe 'GET new' do

    it 'render :new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns new Achievement to @achievement' do
      get :new
      expect(assigns(:achievement)).to be_a_new(Achievement)
    end
  end

  #
  #
  # Show
  describe 'GET show' do
    let(:achievement) { FactoryGirl.create(:public_achievement) }

    it 'render :show template' do
      get :show, params: {
        id: achievement
      }
      expect(response).to render_template(:show)
    end

    it 'assigns requested achievement to @achievement' do
      get :show, params: {
        id: achievement
      }
      expect(assigns(:achievement)).to eq(achievement)
    end
  end

  #
  #
  # Create
  describe 'POST create' do

    #
    # Valid Data
    context 'valid data' do
      let(:valid_data) { FactoryGirl.attributes_for(:public_achievement) }

      it 'redirects to achievements#show' do
        post :create, params: {
          achievement: valid_data
        }
        expect(response).to redirect_to(achievement_path(assigns[:achievement]))
      end

      it 'create new achievement in database' do
        expect {
          post :create, params: {
            achievement: valid_data
          }
        }.to change(Achievement, :count).by(1)
      end
    end

    #
    # Invalid Data
    context 'invalid data' do
      let(:invalid_data) {FactoryGirl.attributes_for(:public_achievement, title: '')}

      it 'renders :new template' do
        post :create, params: {
          achievement: invalid_data
        }
        expect(response).to render_template(:new)
      end

      it 'doesn\'t create new achievement' do
        expect {
          post :create, params: {
            achievement: invalid_data
          }
        }.not_to change(Achievement, :count)
      end
    end

  end

end