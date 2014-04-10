# encoding: UTF-8
require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      visit users_path
    end

    it { should have_title('Lista') }
    it { should have_content('Lista użytkowników') }

    describe "pagination" do

      before(:all) { 50.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.first_name)
          expect(page).to have_selector('li', text: user.last_name)
        end
      end
    end

    describe "delete links" do
      before(:all) { 5.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Usuń', href: user_path(User.first)) }
      it "should be able to delete user" do
        expect do
          click_link('Usuń', match: :first)
        end.to change(User, :count).by(-1)
      end  
    end

    describe "edit links" do
      before(:all) { 5.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_link('Edytuj', href: edit_user_path(User.first)) }
    end
  end

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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }

    describe "page" do
      it { should have_content("Aktualizacja danych") }
      it { should have_title("Edytuj") }
    end

    describe "with invalid information" do
      before { click_button "Zapisz zmiany" }

      it { should have_content('błędy') }
    end

    describe "with valid information" do
      let(:new_first_name)  { "Adam" }
      let(:new_last_name)  { "Nowak" }
      let(:new_email) { "adam.nowak@poczta.com" }
      let(:new_name)  { "adamek999" }
      
      before do
        fill_in "Imię",                 with: new_first_name
        fill_in "Nazwisko",             with: new_last_name
        fill_in "Adres",                with: new_email
        fill_in "Nazwa użytkownika",    with: new_name
        fill_in "Hasło",                with: user.password
        fill_in "Potwierdzenie hasła",  with: user.password
        click_button "Zapisz zmiany"
      end

      it { should have_title("adamek999") }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(user.reload.first_name).to  eq new_first_name }
      specify { expect(user.reload.last_name).to  eq new_last_name }
      specify { expect(user.reload.email).to eq new_email }
      specify { expect(user.reload.name).to  eq new_name }
    end
  end
end