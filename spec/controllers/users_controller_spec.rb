require 'rails_helper'

describe UsersController do

  before do 
    allow_any_instance_of(UsersController).to receive(:current_user).and_return(user)
  end
  
  let (:user) { create(:valid_user) }

  describe "#new" do
    context "GET render the new user template" do
      before { get :new }

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end

    context "GET render the new user template when not logged in" do
      before do
        allow_any_instance_of(UsersController).to receive(:current_user).and_return(User.new)
        get :new
      end

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end

    context "POST creates user and redirects to login" do
      before do 
        post :create, params: 
          { user: { name: "Batmobile", email: "batmobile@rocketleague.com", password: "greatpass!" } } 
      end
      
      it { expect(response.status).to eq(302) }
      it { expect(flash[:success]).to be_present }
      it { expect(flash[:success]).to eq("Account created! Please log in") }
      it { expect(response).to redirect_to('/login') }
      it { expect(User.last.name).to eq("Batmobile")}
      it { expect(User.last.email).to eq("batmobile@rocketleague.com")}
    end

    context "POST fails to create user with invalid email and redirect to new" do
      before do 
        post :create, params: 
          { user: { name: "Batmobile", email: "batmobile@@@rocketleague.com", password: "greatpass!" } } 
      end
      
      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('new') }
    end
  end

  describe "#edit" do
    context "GET render the edit user template" do
      before { get :edit }

      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('edit') }
    end

    context "GET redirect to login page if not logged in" do
      before do
        allow_any_instance_of(UsersController).to receive(:current_user).and_return(nil)
        get :edit
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to('/login') }
    end
  end

  describe "#update" do
    context "POST redirects to login if not logged in" do
      before do
        allow_any_instance_of(UsersController).to receive(:current_user).and_return(nil) 
        post :update, params: { id: user.id, user: { name: "Dominus" } } 
      end

      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to('/login') }
    end

    context "PATCH updates user and redirects to profile" do
      before { post :update, params: { id: user.id, user: { email: "dominus@rocketleague.com" } } }

      it { expect(response.status).to eq(302) }
      it { expect(flash[:success]).to be_present }
      it { expect(flash[:success]).to eq("Profile updated!") }
      it { expect(response).to redirect_to('/profile') }
    end

    context "PATCH fails to update user with invalid password" do
      before { post :update, params: { id: user.id, user: { password: "small"} } }
      
      it { expect(response.status).to eq(200) }
      it { expect(response).to render_template('edit') }
    end
  end

end
