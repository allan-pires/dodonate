require 'rails_helper'

describe ItemsController do
  before do 
    allow_any_instance_of(ItemsController).to receive(:current_user).and_return(User.find(item.user_id))
  end

  let (:item) { create(:valid_item) }
  let (:another_user) { build(:another_valid_user) }
  let (:item_params) do   
    {
      id: item.id,
      name: "Pokeball",
      description: "Very basic pokeball, fails most of the time",
      quantity: 10,
      user_id: item.user_id,
      item_category_id: item.item_category_id
    }
  end

  describe "#new" do
    context "GET render new item template" do
      before { get :new }

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new')}
    end
  end

  describe "#create" do
    context "POST creates item and redirects to items#index" do
      before do 
        post :create, params: 
          { item: { name: "Masterball", description: "Very rare", quantity: 1, item_category_id: item.item_category.id, user_id: item.user_id } } 
      end
      
      it { expect(response.status).to eq(302) }
      it { expect(flash[:success]).to be_present }
      it { expect(flash[:success]).to eq("Item added to donation!") }
      it { expect(response).to redirect_to(items_path) }
      it { expect(Item.last.name).to eq("Masterball")}
      it { expect(Item.last.user_id).to eq(item.user_id)}
    end

    context "POST fail when params are incomplete" do
      before do 
        post :create, params: 
          { item: { name: "Masterball", description: "Very rare", quantity: 1 } } 
      end
      
      it { expect(response.status).to eq(200) }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq("Failed to create item!") }
      it { expect(response).to render_template('new') }
    end
  end

  describe "#update" do
    context "PATCH updates item and redirects to items path" do
      before { patch :update, params: { id: item.id, item: { quantity: 2 } } }

      it { expect(response.status).to eq(302) }
      it { expect(flash[:success]).to be_present }
      it { expect(flash[:success]).to eq("Item updated!") }
      it { expect(response).to redirect_to(items_path) }
    end

    context "PATCH fails, shows error message and redirects to items path" do
      before { patch :update, params: { id: item.id, item: { quantity: "ABC" } } }

      it { expect(response.status).to eq(200) }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq("Failed to update item!") }
      it { expect(response).to render_template('edit') }
    end
  end

  describe "#destroy" do
    context "DELETE removes the item and redirects to items path" do
      before { delete :destroy, params: { id: item.id, item: item_params } }

      it { expect(response.status).to eq(302) }
      it { expect(flash[:success]).to be_present }
      it { expect(flash[:success]).to eq("Item deleted!") }
      it { expect(response).to redirect_to(items_path) }
    end

    context "DELETE fails when user is not the owner" do
      before do 
        allow_any_instance_of(ItemsController).to receive(:current_user).and_return(another_user)
        delete :destroy, params: { id: item.id, item: item_params } 
      end

      it { expect(response.status).to eq(302) }
      it { expect(flash[:error]).to be_present }
      it { expect(flash[:error]).to eq("Permission denied!") }
      it { expect(response).to redirect_to(items_path) }
    end
  end

end
