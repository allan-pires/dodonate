require 'rails_helper'

describe Api::V1::UsersController do
  
  before do
    @request.env["CONTENT_TYPE"] = "application/json"
    @request.env['HTTP_AUTHORIZATION'] = 
        ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
    
    allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(user)   
  end

  let(:user) { User.create(name: 'Ash Ketchum', email: 'ash@pallet.com', password: 'gottacatchthemall') }
  let(:another_user) { User.create(name: 'Brock', email: 'brock@pewter.com', password: 'geoduderocks') }
  let (:user_params) do   
    {
      name: 'Ash Ketchum',
      email: 'ashketchum@pallet.com',
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
      it { expect(@json.size).to eq(2) }
    end

    context "GET fails when not authenticated" do
      before do 
        User.create(user_params)
        @request.env['HTTP_AUTHORIZATION'] = 
          ActionController::HttpAuthentication::Basic.encode_credentials("anotheremail@mail.com", "anotherpassword")

        get :index
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Not authenticated") }
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

    context "GET fails when not authenticated" do
      before do 
        @request.env['HTTP_AUTHORIZATION'] = 
          ActionController::HttpAuthentication::Basic.encode_credentials("anotherser", "anotherpassword")

        get :show, params: { id: 0 }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Not authenticated") }
    end
  end

  describe "#create" do 
    context "POST returns an error when creation fails" do
      before do 
        allow_any_instance_of(User).to receive(:save).and_return(false)

        post :create, params: { user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json).to have_key("errors") }
    end

    context "POST creates a new user" do
      before do 
        post :create, params: { user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["email"]).to eq("ashketchum@pallet.com") }
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
      it { expect(@json).to have_key("errors") }
    end

    context "PATCH fails when not authorized" do
      before do 
        allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(another_user)   
        
        patch :update, params: { id: user.id, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Not authorized") }
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
      it { expect(@json).to have_key("errors") }
    end

    context "DELETE fails when not authorized" do
      before do 
        allow_any_instance_of(Api::V1::UsersController).to receive(:current_user).and_return(another_user)   
        
        delete :destroy, params: { id: user.id, user: user_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Not authorized") }
    end
  end

end
