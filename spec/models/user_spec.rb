require "spec_helper"

describe User do
  let (:user) { create(:valid_user) }

  describe ".valid?" do
  	
    context "with valid information" do
      it { expect(user.valid?).to be_truthy }
    end

    context "without name" do
      before { user.name = nil }      

      it { expect(user.valid?).to be_falsey }
    end

    context "without email" do
      before { user.email = nil }
      
      it { expect(user.valid?).to be_falsey }
    end

    context "without password" do
      before { user.password = nil }      
      
      it { expect(user.valid?).to be_falsey }
    end

    context "with short password" do
      before { user.password = "abc" }
      
      it { expect(user.valid?).to be_falsey }
    end

    context "with email starting with symbol" do
      before { user.email = "$hue@gmail.com" }
      
      it { expect(user.valid?).to be_falsey }
    end

    context "with email without @" do
      before { user.email = "huegmail.com" }

      it { expect(user.valid?).to be_falsey }
    end

    context "with email without .com or .anything" do
      before { user.email = "hue@@gmail" }

      it { expect(user.valid?).to be_falsey }
    end
  end  
  
end