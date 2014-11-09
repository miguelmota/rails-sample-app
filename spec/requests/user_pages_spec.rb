require 'rails_helper'

describe "UserPages" do
  before { visit signup_path }
  subject { page }

  describe "index" do
    let(:user) {FactoryGirl.create(:user)}

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('All users')}
    it { should have_selector('h1', 'All users')}

    describe "pagination" do
      #it { should have_selector('div.pagination')}
      it "should list each user" do
        User.paginate(page:1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end

      describe "delete links" do
        it {should_not have_link('delete')}

        describe "as an admin user" do
          let(:admin) {FactoryGirl.create(:admin)}
          before do
            sign_in admin
            visit users_path
          end

          it { should have_link('delete', href: user_path(User.first)) }
          it "should be able to delete another user" do
            expect {click_link('delete')}.to change(User, :count).by(-1)
          end
          it {should_not have_link('delete', href: user_path(admin))}
        end
      end
    end

    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
  end

  let(:submit) { "Create my account" }

  describe "profile page" do
      let(:user) { FactoryGirl.create(:user) }

      before { visit user_path(user) }

      it { should have_selector('h1', text: user.name) }
      #it { should have_selector('title', text: user.name) }
  end

  describe "signup page" do
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "with invalid information" do
    it "should not create a user" do
      expect { click_button submit }.not_to change(User, :count)
    end
  end

  describe "with valid information" do
    before do
      visit signup_path
      fill_in "Name", with: "Example User"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "foobar"
      fill_in "Password confirmation", with: "foobar"
    end

    it "should create a user" do
      expect { click_button submit }.to change(User, :count).by(1)
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: 'Update your profile')}
      it { should have_title('Edit user')}
      it { should have_link('change', href: 'http://gravatar.com/emails')}
    end

    describe "with invalid confirmation" do
        before { click_button "Save changes" }
        it { should have_content('error')}
    end

    describe "with valid Information" do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before {visit edit_user_path(user)}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Password confirmation", with: user.password
        click_button "Save changes"
      end

      it {should have_title(new_name)  }
      it {should have_selector('div.alert.alert-success')  }
      it {should have_link('Sign out', href: signout_path)  }

      # reloads attribute from server
      specify {user.reload.name.should == new_name}
      specify {user.reload.email.should == new_email}
    end
  end

end