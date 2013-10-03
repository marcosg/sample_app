require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end


  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }
    
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user)}
      before do
        31.times {  FactoryGirl.create(:micropost, user: user,
                      content: "Lorem ipsum") }
# TODO add microposts from other_user to user.feed
        FactoryGirl.create(:micropost, user: other_user, 
          content: "Dolor sit amet")

        sign_in user
        visit root_path
      end

      it "pagination" do
        should have_selector('div.pagination') 
      end

      it "should render the user's feed with pagination" do
        user.feed.paginate(page: 1).each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "delete link" do
        it "for own microposts" do 
          should have_link('delete', href: micropost_path(user.
                                          microposts.first))
        end
        
        it "for other user's microposts" do 
          pending("add microposts from other_user to user.feed")
          should_not have_link('delete', href: micropost_path(other_user.
                                          microposts.first)) 
        end
      end

      describe "micropost pluralization" do
        it "with several microposts" do
          should have_content("#{user.microposts.count} microposts")
        end

        describe "with one micropost" do
          before do 
            user.microposts.first.destroy
            visit root_path
          end

          it { should have_content("#{user.microposts.count} micropost") }
        end

        describe "with no microposts" do
          before do 
            user.microposts.delete_all
            visit root_path
          end

          it { should have_content("#{user.microposts.count} microposts") }
        end
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }
    
    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About Us' }
    
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }
    
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end

end
