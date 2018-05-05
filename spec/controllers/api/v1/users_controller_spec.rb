require 'rails_helper'

describe Api::V1::UsersController do
  
  before do
    allow_any_instance_of(Api::V1::UsersController).to receive(:user_exists?).and_call_original
  end
  
  let(:user) { User.create(name: 'Ash Ketchum', email: 'ash@pallet.com', password: 'gottacatchthemall') }
  let (:user_params) do   
    {
      name: 'Ash Ketchum',
      email: 'ash@pallet.com',
      password: 'gottacatchthemall'
    }
  end

  describe "#index" do 
    context "GET list all users" do
      before do 
        User.create(user_params)

        get :index
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json.size).to eq(1) }
    end
  end

  describe "#show" do 
    context "GET returns an user" do
      before do 
        get :show, params: { id: user.id }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(user.id) }
    end

    context "GET returns an error when user dont exists" do
      before do 
        get :show, params: { id: 0 }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end
  end

  describe "#create" do 
    context "CREATE returns an error when creation fails" do
      before do 
        allow_any_instance_of(User).to receive(:save).and_return(false)

        post :create, params: { user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Failed to create user") }
    end
  end

  describe "#update" do 
    context "PATCH updates an user" do
      before do 
        patch :update, params: { id: user.id, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(user.id) }
    end

    context "PATCH returns an error when user dont exists" do
      before do 
        patch :update, params: { id: 0, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end

    context "PATCH returns an error when update fails" do
      before do 
        allow_any_instance_of(User).to receive(:update_attributes).and_return(false)

        patch :update, params: { id: user.id, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Failed to update user") }
    end
  end

  describe "#destroy" do 
    context "DELETE destroys an user" do
      before do 
        delete :destroy, params: { id: user.id, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["message"]).to eq("User deleted!") }
    end

    context "DELETE returns an error when user dont exists" do
      before do 
        delete :destroy, params: { id: 0, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end

    context "DELETE returns an error when destroy fails" do
      before do 
        allow_any_instance_of(User).to receive(:destroy).and_return(false)

        delete :destroy, params: { id: user.id, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Failed to delete user") }
    end
  end

end
