require "spec_helper"

describe User do
  let (:user) { create(:valid_user) }

  describe ".valid?" do
  	
    context "with valid information" do
      it { expect(user.valid?).to be_truthy }
    end

    context "without name" do
      before do 
        user.name = nil 
      end
      
      it { expect(user.valid?).to be_falsey }
    end

    context "without email" do
      before do 
        user.email = nil
      end

      it { expect(user.valid?).to be_falsey }
    end

    context "without password" do
      before do 
        user.password = nil
      end
      
      it { expect(user.valid?).to be_falsey }
    end

    context "with short password" do
      before do 
        user.password = "abc" 
      end
      
      it { expect(user.valid?).to be_falsey }
    end

    context "with email starting with symbol" do
      before do
        user.email = "$hue@gmail.com"
      end

      it { expect(user.valid?).to be_falsey }
    end

    context "with email without @" do
      before do
        user.email = "huegmail.com"
      end

      it { expect(user.valid?).to be_falsey }
    end

    context "with email without .com or .anything" do
      before do
        user.email = "hue@@gmail"
      end

      it { expect(user.valid?).to be_falsey }
    end
  end  
  
end