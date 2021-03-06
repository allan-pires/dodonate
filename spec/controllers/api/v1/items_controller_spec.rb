require 'rails_helper'

describe Api::V1::ItemsController do
  
  before do
    @request.env["CONTENT_TYPE"] = "application/json"
    @request.env['HTTP_AUTHORIZATION'] = 
        ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)

    @current_user = user
  end
  
  let(:item_category) { ItemCategory.create(description: 'STUFF') }
  let(:user) { User.create(name: 'Ash Ketchum', email: 'ash@pallet.com', password: 'gottacatchthemall') }
  let(:another_user) { User.create(name: 'Brock', email: 'brock@pewter.com', password: 'geoduderocks') }
  let(:item) { Item.create(name: 'Pokeball', description: 'Very basic pokeball, fails most of the time', quantity: 10, user_id: user.id, item_category_id: item_category.id) }
  let (:item_params) do   
    {
      name: 'Greatball',
      description: "Better than a normal pokeball",
      quantity: 5,
      item_category_id: item_category.id
    }
  end

  describe "#index" do 
    context "GET list all items" do
      before do 
        item_params[:user_id] = user.id
        Item.create(item_params)
        Item.create(item_params)

        get :index
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json.size).to eq(2) }
    end
  end

  describe "#show" do 
    context "GET returns an item" do
      before do 
        get :show, params: { id: item.id }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(item.id) }
    end

    context "GET returns an error when item dont exists" do
      before do 
        get :show, params: { id: 0 }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end
  end

  describe "#show" do 
    context "GET returns an item" do
      before do 
        get :show, params: { id: item.id }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(item.id) }
    end

    context "GET returns an error when item dont exists" do
      before do 
        get :show, params: { id: 0 }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end
  end

  describe "#show_by_user" do 
    context "GET returns all items from user" do
      before do 
        item_params[:user_id] = user.id
        5.times do
          Item.create(item_params)
        end

        get :show_by_user, params: { user_id: user.id }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json.size).to eq(5) }
    end
  end

  describe "#show_by_category" do 
    context "GET returns all items from category" do
      before do 
        item_params[:user_id] = user.id
        7.times do
          Item.create(item_params)
        end

        get :show_by_category, params: { item_category_id: item_category.id }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json.size).to eq(7) }
    end
  end

  describe "#create" do 
    context "CREATE returns an error when creation fails" do
      before do 
        allow_any_instance_of(Item).to receive(:save).and_return(false)

        post :create, params: { item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json).to have_key("errors") }
    end

    context "POST creates a new item" do
      before do 
        post :create, params: { item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["name"]).to eq("Greatball") }
    end
  end

  describe "#update" do 
    context "PATCH updates an item" do
      before do 
        patch :update, params: { id: item.id, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(item.id) }
    end

    context "PATCH returns an error when item dont exists" do
      before do 
        patch :update, params: { id: 0, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end

    context "PATCH returns an error when update fails" do
      before do 
        allow_any_instance_of(Item).to receive(:update_attributes).and_return(false)

        patch :update, params: { id: item.id, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json).to have_key("errors") }
    end

    context "PATCH fails when user is not the owner" do
      before do 
        allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(another_user)

        patch :update, params: { id: item.id, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Not authorized") }
    end
  end

  describe "#destroy" do 
    context "DELETE destroys an item" do
      before do 
        delete :destroy, params: { id: item.id, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["message"]).to eq("Successfully deleted!") }
    end

    context "DELETE returns an error when item dont exists" do
      before do 
        delete :destroy, params: { id: 0, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end

    context "DELETE returns an error when destroy fails" do
      before do 
        allow_any_instance_of(Item).to receive(:destroy).and_return(false)

        delete :destroy, params: { id: item.id, item: item_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json).to have_key("errors") }
    end
  end

end
