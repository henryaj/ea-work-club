require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:user) { User.create! }
  let(:category) { Category.create! }
  let(:job) { Job.create!(
    user: user, category: category,
    title: "Assistant to the regional manager",
    time_commitment: 1,
    expiry_date: Date.today + 2.weeks,
    description: "Truly, the best job in the world.
    
- work from home
- work from home
- work work work work work

It's really *remarkable*."
  )}

  describe "#pretty_description" do
    it "prints description HTML from Markdown" do
      job.pretty_description == "<p>Truly, the best job in the world.</p>\n\n<ul>\n  <li>work from home</li>\n  <li>work from home</li>\n  <li>work work work work work</li>\n</ul>\n\n<p>It’s really <em>remarkable</em>.</p>\n"
    end
  end

  describe "#pretty_time_commitment" do
    it { job.pretty_time_commitment == "Part time" }
  end

  describe "#preview" do
    it { job.preview == "Truly, the best job in the world.\n\n\n  work from home\n  work from home\n  work work ..." }
  end

  describe "validations" do
    it "must have a user and a category" do
      expect {
        Job.create!(user: user, category: category)
      }.not_to raise_error

      expect {
        Job.create!(user: user)
      }.to raise_error(ActiveRecord::RecordInvalid)

      expect {
        Job.create!(category: category)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe "expiry and renewal" do
    let(:expired_job) {
      Job.create!(user: user, category: category, expiry_date: Date.yesterday)
    }
    let(:lapsed_job) {
      Job.create!(user: user, category: category, renewed_at: Date.today - 75.days, expiry_date: Date.tomorrow)
    }
    let(:expiring_job) {
      Job.create!(user: user, category: category, expiry_date: Date.tomorrow)
    }

    it "is expired if the expiry date has passed" do
      expect(expired_job.expired?).to be true
    end

    it "is expired if the job has not been renewed" do
      expect(lapsed_job.expired?).to be true
    end

    describe "#renew!" do
      it "sets renewed_at to today's date" do
        lapsed_job.renew!
        expect(lapsed_job.renewed_at.utc.to_i).to eq DateTime.now.utc.to_i
        expect(lapsed_job.expired?).to be false
      end
    end

    describe "#expires_soon?" do
      it { job.expires_soon? == false }

      context "when expiring within a week" do
        it { expiring_job.expires_soon? == true }
      end
    end

    describe "#created_in_last_week?" do
      let(:old_job) { job.created_at = Date.today - 14.days; job }

      it { job.created_in_last_week? == true }
      it { old_job.created_in_last_week? == false }
    end
  end
end