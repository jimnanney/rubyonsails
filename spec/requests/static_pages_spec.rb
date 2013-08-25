require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    it "should have the content 'WHY RUBY ON SAILS'" do
      visit "/static_pages/home"
      expect(page).to have_content('WHY RUBY ON SAILS')
    end
  end
end
