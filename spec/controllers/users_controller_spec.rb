require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET show' do
    let(:user_one) { create(:user_one) }

    context 'when user is signed in' do

      before { sign_in(user_one) }

      context 'when user is viewing their own profile' do
        it 'renders the show template' do
          get :show, params: { user_id: user_one.id }
          assert_template 'show'
        end
  
        it 'has a 200 status code' do
          get :show, params: { user_id: user_one.id }
          expect(response.status).to eq(200)
        end
  
        it 'assigns @duels' do
          duel = double(Duel)
          allow(Duel).to receive(:my_completed).with(kind_of(User)).and_return(duel)
          get :show, params: { user_id: user_one.id }
          expect(assigns[:duels]).to eq(duel)
        end
      end

      context 'when user is not viewing their own profile' do
        let(:user_two) { create(:user_two) }

        it 'renders the 401 template' do
          get :show, params: { user_id: user_two.id }
          assert_template(file: '401.html')
        end

        it 'has a 401 status code' do
          get :show, params: { user_id: user_two.id }
          expect(response.status).to eq(401)
        end
      end
    end

    context 'when user is not signed in' do
      it 'redirects to sign in' do
        get :show, params: { user_id: user_one.id }
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'has a 302 status code' do
        get :show, params: { user_id: user_one.id }
        expect(response.status).to eq(302)
      end
    end
  end
end
