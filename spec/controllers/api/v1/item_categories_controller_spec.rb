require 'rails_helper'

describe Api::V1::ItemCategoriesController do
  
  before do
    @request.env["CONTENT_TYPE"] = "application/json"
    @request.env['HTTP_AUTHORIZATION'] = 
        ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
    
    allow_any_instance_of(Api::V1::ItemCategoriesController).to receive(:item_category_exists?).and_call_original
    allow_any_instance_of(Api::V1::ItemCategoriesController).to receive(:current_user).and_return(user)   
  end
  
  let(:item_category) { ItemCategory.create(description: 'STUFF') }
  let(:user) { User.create(name: 'Ash Ketchum', email: 'ash@pallet.com', password: 'gottacatchthemall') }
  let (:item_category_params) do   
    {
      id: item_category.id,
      description: item_category.description
    }
  end

  describe "#index" do 
    context "GET list all categories" do
      before do 
        ItemCategory.create(description: 'STUFF')
        ItemCategory.create(description: 'ANOTHER STUFF')

        get :index
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json.size).to eq(2) }
    end
  end

  describe "#show" do 
    context "GET returns an category" do
      before do 
        get :show, params: { id: item_category.id }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(item_category.id) }
    end

    context "GET returns an error when category dont exists" do
      before do 
        get :show, params: { id: 0 }
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end
  end

  describe "#create" do 
    context "CREATE adds an item category" do
      before do 
        post :create, params: { item_category: { description: "NEW CATEGORY" } } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["description"]).to eq("NEW CATEGORY") }
    end

    context "CREATE returns an error when creation fails" do
      before do 
        allow_any_instance_of(ItemCategory).to receive(:save).and_return(false)

        post :create, params: { item_category: { description: "NEW CATEGORY" } } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Failed to create item category") }
    end
  end

  describe "#update" do 
    context "PATCH updates an category" do
      before do 
        patch :update, params: { id: item_category.id, item_category: { description: "HEY, UPDATE ME!" } } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["id"]).to eq(item_category.id) }
      it { expect(@json["description"]).to eq("HEY, UPDATE ME!") }
    end

    context "PATCH returns an error when category dont exists" do
      before do 
        patch :update, params: { id: 0, item_category: { description: "HEY, UPDATE ME!" } } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end

    context "PATCH returns an error when update fails" do
      before do 
        allow_any_instance_of(ItemCategory).to receive(:update_attributes).and_return(false)

        patch :update, params: { id: item_category.id, item_category: { description: "HEY, UPDATE ME!" } } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Failed to update item category") }
    end
  end

  describe "#destroy" do 
    context "DELETE destroys an item category" do
      before do 
        delete :destroy, params: { id: item_category.id, item: item_category_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["message"]).to eq("Item category deleted!") }
    end

    context "DELETE returns an error when item category dont exists" do
      before do 
        delete :destroy, params: { id: 0, item: item_category_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Resource not found") }
    end

    context "DELETE returns an error when destroy fails" do
      before do 
        allow_any_instance_of(ItemCategory).to receive(:destroy).and_return(false)

        delete :destroy, params: { id: item_category.id, item: item_category_params } 
        @json = JSON.parse(response.body)
      end

      it { expect(response.status).to eq(200) }
      it { expect(@json["errors"]).to eq("Failed to delete item category") }
    end
  end

end
