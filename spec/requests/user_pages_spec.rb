# encoding: UTF-8
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

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

  describe "add new user" do

    before { visit new_user_path }

    let(:submit) { "Dodaj użytkownika" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Imię",                 with: "Jan"
        fill_in "Nazwisko",             with: "Kowalski"
        fill_in "Adres",                with: "jan.kowalski@poczta.com"
        fill_in "Nazwa użytkownika",    with: "janek999"
        fill_in "Hasło",                with: "foobar"
        fill_in "Potwierdzenie hasła",  with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end