require 'spec_helper'


describe "Static Pages" do

	subject { page }
	
	shared_examples_for "Static Pages" do
		it { should have_selector('h1', text: heading) }
		it { should have_title(full_title(page_title))}
	end

	describe "Home Page" do

		before { visit root_path }
		let(:heading) { 'Sample App'}
		let(:page_title) { '' }

		it_should_behave_like "Static Pages"
		it { should_not have_title ('| Home')} 
	end

	describe "Help Page" do

		before { visit help_path }
		let(:heading) { 'Help Page'}
		let(:page_title) { 'Help' }

		it_should_behave_like "Static Pages"
	end

	describe "About Page" do

		before { visit about_path }
		let(:heading) { 'About John' }
		let(:page_title) { 'About John' }

		it_should_behave_like "Static Pages"
	end

	describe "Contact Page" do

		before { visit contact_path }
		let(:heading) { 'Contact John' }
		let(:page_title) { 'Contact John' }

		it_should_behave_like "Static Pages"
	end

	it "should have the right links on the layout" do
		visit root_path
		click_link "About"
		expect(page).to have_title(full_title('About John'))
		click_link "Help"
		expect(page).to have_title(full_title('Help'))
		click_link "Contact"
		expect(page).to have_title(full_title('Contact John'))
		click_link "Home"
		click_link "Sign Up Now!"
		expect(page).to have_title(full_title('Sign up'))
		click_link "sample app"
		expect(page).to have_title(full_title(''))
	end
end