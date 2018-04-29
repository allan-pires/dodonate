require "spec_helper"

describe User do
  let (:user) { User.new(name: "Adalberto", email: "adalberto@gmail.com", password: "minhasenha") }

  describe ".valid?" do
  	context "with valid information" do
      it { expect(user.valid?).to be_truthy }
    end

    context "with empty email" do
      before do
        user.email = ""
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