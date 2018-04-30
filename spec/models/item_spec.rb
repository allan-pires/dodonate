require "spec_helper"

describe Item do
  let (:item) { create(:valid_item) }

  describe ".valid?" do
    
    context "with valid information" do
      it { expect(item.valid?).to be_truthy }
    end

    context "without name" do
      before { item.name = nil }

      it { expect(item.valid?).to be_falsey }
    end

    context "without description" do
      before { item.description = nil }

      it { expect(item.valid?).to be_truthy }
    end

    context "without quantity" do
      before { item.quantity = nil }

      it { expect(item.valid?).to be_falsey }
    end

    context "without category" do
      before { item.item_category = nil }

      it { expect(item.valid?).to be_falsey }
    end

    context "without owner (user)" do
      before { item.user = nil }

      it { expect(item.valid?).to be_falsey }
    end

  end
end