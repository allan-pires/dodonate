require 'rails_helper'

describe ItemsController do
  before do 
    allow_any_instance_of(ItemsController).to receive(:check_ownership).and_return(true)
    allow_any_instance_of(ItemsController).to receive(:current_user).and_return(user)
  end

  let (:user) { create(:valid_user) }
  let (:another_user) { create(:another_valid_user) }
  let (:item) { create(:valid_item) }
  let (:item_category) { create(:valid_item_category) }

  describe "#new" do
    context "GET render new item template" do
      before { get :new }

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end

    context "POST creates item and redirects to home" do
      before do 
        post :create, params: 
          { item: { name: "Masterball", description: "Very rare", quantity: 1, item_category_id: item_category.id } } 
      end
      
      it { expect(response.status).to eq(302) }
      it { expect(flash[:success]).to be_present }
      it { expect(flash[:success]).to eq("Item added to donation!") }
      it { expect(response).to redirect_to('/home') }
      it { expect(Item.last.name).to eq("Masterball")}
      it { expect(Item.last.user_id).to eq(user.id)}
    end

    context "POST fail when params is incomplete" do
      before do 
        post :create, params: 
          { item: { name: "Masterball", description: "Very rare", quantity: 1 } } 
      end
      
      it { expect(response).to render_template('new') }
    end
  end

end
