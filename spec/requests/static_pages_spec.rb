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
end
