require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    it "should have the content 'WHY RUBY ON SAILS'" do
      visit "/home"
      expect(page).to have_content('WHY RUBY ON SAILS')
    end
  end

  describe "About page" do
    it "should have the content 'About Ruby On Sails'" do
      visit "/about"
      expect(page).to have_content('About Ruby On Sails')
    end
  end
end
