require "rails_helper"

describe Book, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:author)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:year)}
    it {should validate_presence_of(:cover_url)}
  end
end
