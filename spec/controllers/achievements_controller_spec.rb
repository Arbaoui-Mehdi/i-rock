require 'rails_helper'

describe AchievementsController do

  #
  #
  # Shared Examples
  shared_examples 'public access to achievements' do

    # Index
    describe 'GET index' do

      it 'render :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns only public achievements to template' do
        public_achievement = FactoryGirl.create(:public_achievement)
        private_achievement = FactoryGirl.create(:private_achievement)
        get :index
        expect(assigns(:achievements)).to match_array(public_achievement)
      end

    end

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

  end

  #
  #
  # Guest User
  describe 'guest user' do

    it_behaves_like 'public access to achievements'

    # New
    describe 'GET new' do

      it 'redirect to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end

    end

    # Create
    describe 'POST create' do
      it 'redirects to login page' do
        post :create, params: {
          achievement: FactoryGirl.attributes_for(:public_achievement)
        }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    # Edit
    describe 'GET edit' do
      it 'redirects to login page' do
        get :edit, params: {
          id: FactoryGirl.create(:public_achievement)
        }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    # Update
    describe 'PUT update' do
      it 'redirects to login page' do
        put :update, params: {
          id: FactoryGirl.create(:public_achievement),
          achievement: FactoryGirl.attributes_for(:public_achievement, title: 'New Article')
        }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    # Delete
    describe 'DELETE destroy' do
      it 'redirects to login page' do
        delete :destroy, params: {
          id: FactoryGirl.create(:public_achievement)
        }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

  end

  #
  #
  # Authenticated User
  describe 'authenticated user' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    it_behaves_like 'public access to achievements'

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

    #
    #
    # Not The Owner
    context 'is not the owner of the achievement' do

      # Edit
      describe 'GET edit' do
        it 'redirects to achievements page' do
          get :edit, params: {
            id: FactoryGirl.create(:public_achievement)
          }
          expect(response).to redirect_to(achievements_path)
        end
      end

      # Update
      describe 'PUT update' do
        it 'redirects to achievements page' do
          put :update, params: {
            id: FactoryGirl.create(:public_achievement),
            achievement: FactoryGirl.attributes_for(:public_achievement, title: 'New Article')
          }
          expect(response).to redirect_to(achievements_path)
        end
      end

      # Delete
      describe 'DELETE destroy' do
        it 'redirects to achievements page' do
          delete :destroy, params: {
            id: FactoryGirl.create(:public_achievement)
          }
          expect(response).to redirect_to(achievements_path)
        end
      end

    end

    #
    #
    # The Owner
    context 'is the owner of the achievement' do

      let(:achievement) { FactoryGirl.create(
        :public_achievement,
        user: user
      )}

      # Edit
      describe 'GET edit' do

        it 'render :edit template' do
          get :edit, params: {
            id: achievement
          }
          expect(response).to render_template(:edit)
        end

        it 'assigns the requested achievement to template' do
          get :edit, params: {
            id: achievement
          }
          expect(assigns(:achievement)).to eq(achievement)
        end

      end

      # Put
      describe 'PUT update' do

        #
        # Valid data
        context 'valid data' do

          let(:valid_data) { FactoryGirl.attributes_for(
            :public_achievement,
            title: 'New Title')
          }

          it 'redirects to achievements#show' do
            put :update, params: {
              id: achievement,
              achievement: valid_data
            }
            expect(response).to redirect_to(achievement)
          end

          it 'updates achievement in the database' do
            put :update, params: {
              id: achievement,
              achievement: valid_data
            }
            achievement.reload
            expect(achievement.title).to eq 'New Title'

          end
        end

        #
        # Invalid data
        context 'invalid data' do

          let(:invalid_data) { FactoryGirl.attributes_for(
            :public_achievement,
            title: '',
            description: 'new')
          }

          it 'render :edit template' do
            put :update, params: {
              id: achievement,
              achievement: invalid_data
            }
            expect(response).to render_template(:edit)
          end

          it 'doesn\'t update achievement in the database' do
            put :update, params: {
              id: achievement,
              achievement: invalid_data
            }
            achievement.reload
            expect(achievement.description).to_not eq 'new'
          end

        end

      end

      # Destroy
      describe 'DELETE destroy' do

        it 'redirects to achievements#index' do
          delete :destroy, params: {
            id: achievement
          }
          expect(response).to redirect_to(achievements_path)
        end

        it 'deletes achievements from database' do
          delete :destroy, params: {
            id: achievement
          }
          expect(Achievement.exists?(achievement.id)).to be_falsy
        end

      end

    end

  end

end