require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { User.create! }
  let(:category) { Category.create! }

  describe "validations" do
    it "must have a user and a category" do
      expect {
        Project.create!(user: user, category: category)
      }.not_to raise_error

      expect {
        Project.create!(user: user)
      }.to raise_error(ActiveRecord::RecordInvalid)

      expect {
        Project.create!(category: category)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "expiry and renewal" do
    let(:lapsed_project) {
      Project.create!(user: user, category: category, renewed_at: Date.today - 75.days)
    }

    it "is expired if the project has not been renewed" do
      expect(lapsed_project.expired?).to be true
    end

    describe "#renew!" do
      it "sets renewed_at to today's date" do
        lapsed_project.renew!
        expect(lapsed_project.renewed_at.utc.to_i).to eq DateTime.now.utc.to_i
        expect(lapsed_project.expired?).to be false
      end
    end
  end
end
