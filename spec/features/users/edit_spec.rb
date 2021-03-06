require "rails_helper"

RSpec.describe "User show page" do
  before :each do
    @user = User.create!(name: 'Billy Joel',
      address: '123 Song St.',
      city: 'Las Vegas',
      state: 'NV',
      zip: '12345',
      email: 'billy_j@user.com',
      password: '123',
      role: 0)
  end

  it "Edit profile info link takes me to pre-populated form where I can edit/update profile info" do
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log in"

    click_link "Edit Profile Information"

    expect(current_path).to eq("/profile/edit")

    expect(find_field(:name).value).to eq(@user.name)
    expect(find_field(:address).value).to eq(@user.address)
    expect(find_field(:city).value).to eq(@user.city)
    expect(find_field(:state).value).to eq(@user.state)
    expect(find_field(:zip).value).to eq(@user.zip)
    expect(find_field(:email).value).to eq(@user.email)
    expect(page).to_not have_content('Password')

    fill_in :name, with: "Bill J"
    fill_in :city, with: "Denver"
    fill_in :state, with: "CO"

    click_button "Update Information"

    expect(current_path).to eq("/profile")

    expect(page).to have_content("Profile Information Updated")

    expect(page).to have_content("Bill J")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
  end

  it "User profile has a link to edit password" do
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log in"

    expect(page).to have_link("Edit Profile Password")

    click_link "Edit Profile Password"
    expect(current_path).to eq("/profile/edit/password")

    fill_in :password, with: "321"
    fill_in :confirm_password, with: "321"

    click_button "Update Password"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Profile Password Updated")
  end

  it "edit passwords sad path" do
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log in"

    expect(page).to have_link("Edit Profile Password")

    click_link "Edit Profile Password"
    expect(current_path).to eq("/profile/edit/password")

    fill_in :password, with: "321"
    fill_in :confirm_password, with: "322"

    click_button "Update Password"

    expect(page).to have_content("Passwords do not match")
  end

  # User Story 22, User Editing Profile Data must have unique Email address
  #
  # As a registered user
  # When I attempt to edit my profile data
  # If I try to change my email address to one that belongs to another user
  # When I submit the form
  # Then I am returned to the profile edit page
  # And I see a flash message telling me that email address is already in use

  it "User Editing Profile Data must have unique Email address" do
    user2 = User.create!(name: 'Bill J',
                        address: '123 Meledy St.',
                        city: 'Denver',
                        state: 'CO',
                        zip: '54321',
                        email: 'bill_j@user.com',
                        password: '321',
                        role: 0)
    visit "/login"

    fill_in :email, with: @user.email
    fill_in :password, with: @user.password

    click_button "Log in"

    click_link "Edit Profile Information"
    fill_in :email, with: "bill_j@user.com"
    click_button "Update Information"

    expect(page).to have_content("Email address already in use")
  end
end
