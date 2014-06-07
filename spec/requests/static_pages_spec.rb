require "rspec/helper"

describe "Static Pages" do
  describe "Home" do
    it "has the content 'WHY RUBY ON RAILS'" do
      visit "/home"
      expect(page).to have_content("WHY RUBY ON SAILS")
    end
  end

  describe "About" do
    it "has the content 'About Ruby On Rails'" do
      visit "/about"
      expect(page).to have_content("About Ruby On Sails")
    end
  end
end
