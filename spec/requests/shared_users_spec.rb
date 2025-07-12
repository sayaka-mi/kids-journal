require 'rails_helper'

RSpec.describe 'SharedUsers', type: :request do
  before do
    allow_any_instance_of(ApplicationController).to receive(:redirect_to_child_registration_if_none).and_return(nil)
  end
  let(:user) { create(:user) }
  let(:shared_user) { create(:user, email: 'shared@example.com') }

  before { sign_in user }

  describe 'POST /shared_users' do
    context 'when no children exist' do
      it 'redirects with an alert' do
        post shared_users_path, params: { email: shared_user.email }
        expect(response).to redirect_to(shared_users_path)
        follow_redirect!
        expect(response.body).to include('お子様の情報を登録してから共有してください')
      end
    end

    context 'when trying to share with self' do
      it 'shows error' do
        create(:child, user: user)
        post shared_users_path, params: { email: user.email }
        follow_redirect!
        expect(response.body).to include('自分自身とは共有できません')
      end
    end

    context 'when sharing with existing user' do
      it 'creates shared_user record' do
        create(:child, user: user)
        post shared_users_path, params: { email: shared_user.email }
        expect(response).to redirect_to(shared_users_path)
        follow_redirect!
        expect(response.body).to include('共有しました')
        expect(SharedUser.last.shared_user).to eq(shared_user)
      end
    end
  end
end
