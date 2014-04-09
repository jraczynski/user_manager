require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "new user page" do
    before { visit new_user_path }

    it { should have_content('Nowy') }
    it { should have_title(full_title('Nowy')) }
  end

  describe "all users page" do
    before { visit users_path }

    it { should have_content('Lista') }
    it { should have_title(full_title('Lista')) }
  end
end