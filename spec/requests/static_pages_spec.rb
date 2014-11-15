require 'rails_helper'

describe "StaticPages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    page.should have_selector 'h1', text: 'About Us'
  end
  describe "GET /static_pages" do
    before { visit root_path }
    subject { page } # remove page from page.should
    it { should have_content 'Sample App' }
    #page.should have_selector('title', text: '|', visible: false)
    it { should have_title(full_title('Home')) }
  end
  describe "About Page" do
    it "should have the content 'About Us'" do
      visit about_path
      page.should have_selector('h1', text: 'About Us')
    end
  end
  describe "Contact Page" do
    it "should have the content 'Contact'" do
      visit contact_path
      page.should have_title("#{base_title} | Contact")
    end
  end
  describe "Home page" do
    describe "for signed-in users" do
      let(:user) {FactoryGirl.create(:user)}
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        #it { should have_link("0 following", href: following_user_path(user)) }
        #it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end
end
