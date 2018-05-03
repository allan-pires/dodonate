require 'rails_helper'

describe SessionsHelper do

  let(:user) { create(:valid_user) }
  let(:another_user) { create(:another_valid_user) }

  describe ".current_user" do
    context "there is an user logged in" do
      before do 
        session[:user_id] = user.id
      end

      it { expect(current_user.id).to eq(user.id)}
    end

    context "there is no user logged in" do
      it { expect(current_user).to eq(nil)}
    end
  end

  describe ".logged_in?" do
    context "there is an user logged in" do
      before do 
        session[:user_id] = user.id
      end

      it { expect(logged_in?).to be_truthy}
    end

    context "there is no user logged in" do
      it { expect(logged_in?).to be_falsey}
    end
  end
end