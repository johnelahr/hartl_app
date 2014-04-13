require 'spec_helper'


describe "Static Pages" do

	subject { page }
	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

	describe "Home Page" do

		before { visit root_path }

		it { should have_content('Sample App') }
		it { should have_title(full_title(''))}
		it { should_not have_title(full_title('Home')) }
	end

	describe "Help Page" do

		before { visit help_path }

		it { should have_content('Help Page')}
		it { should have_title(full_title('Help'))}
	end

	describe "About Page" do

		before { visit about_path }

		it { should have_content("About John")}
		it { should have_title(full_title('About John'))}
	end

	describe "Contact Page" do

		before { visit contact_path }

		it { should have_content("Contact John")}
		it { should have_title(full_title('Contact John'))}
	end
end