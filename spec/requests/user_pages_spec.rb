require "rspec/helper"

describe "User Pages" do
  subject { page }

  describe "signup page" do
    before { visit signup_path }
    it { should have_content('Sign up')}
  end

  describe "profile page" do
    let(:attrs) do
      {
        :name => "Example User",
        :email => "user@example.com",
        :password_confirmation => "12345678",
        :password => "12345678"
      }
    end

    before do
      @user = User.create(attrs)
    end

    before { visit user_path(@user) }
    it { should have_content(@user.name) }
  end

  describe "signup" do
    let(:submit) { "Create my account" }
    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: => "Example User"
        fill_in "Password",     with: => "foobarbaz"
        fill_in "Confirmation", with: => "foobarbaz"
        fill_in "Email",        with: => "user@example.com"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
