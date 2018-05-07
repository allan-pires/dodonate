require 'rails_helper'

describe ItemCategory do

  let(:category) { create(:valid_item_category)}
  let(:another_category) { create(:another_valid_item_category) }

  describe ".get_all" do
    context "when there are no categories registered" do
      it {expect(ItemCategory.get_all.size).to eq(0)}
    end
  end

  describe ".get_all" do
    context "when there are one category registered" do
      before do
        category.save
      end

      it {expect(ItemCategory.get_all.size).to eq(1)}
      it {expect(ItemCategory.get_all).to include(["Stuff", category.id])}
    end
  end

  describe ".get_all" do
    context "when there are three categories registered" do
      before do
        category.save
        another_category.save
      end

      it {expect(ItemCategory.get_all.size).to eq(2)}
      it {expect(ItemCategory.get_all).to include(["Stuff", category.id])}
      it {expect(ItemCategory.get_all).to include(["Another Stuff", another_category.id])}
    end
  end

end
