require "spec_helper"

describe Item do
  let (:item) { create(:valid_item) }

  describe ".valid?" do
    
    context "with valid information" do
      it { expect(item.valid?).to be_truthy }
    end

    context "without name" do
      before do 
        item.name = nil 
      end
      it { expect(item.valid?).to be_falsey }
    end

    context "without description" do
      before do 
        item.description = nil 
      end
      it { expect(item.valid?).to be_truthy }
    end

    context "without quantity" do
      before do 
        item.name = nil 
      end
      it { expect(item.valid?).to be_falsey }
    end

    context "without category" do
      before do 
        item.item_category = nil 
      end
      it { expect(item.valid?).to be_falsey }
    end

    context "without owner (user)" do
      before do 
        item.user = nil 
      end
      it { expect(item.valid?).to be_falsey }
    end

  end
end