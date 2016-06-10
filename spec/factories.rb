FactoryGirl.define do
  sequence(:name) { |n| Faker::Name.name[0..20] }
  sequence(:email) { |n| Faker::Internet.email }
  sequence(:title) { |n| Faker::Book.title }
  sequence(:body) { |n| Faker::Lorem.paragraph(2) }
  sequence(:phone_number) { |n| Faker::PhoneNumber.phone_number[0..19] }
  sequence(:description) { |n| Faker::Lorem.paragraph(8)[50..150] }
  sequence(:tag_list) { |n| Faker::Hipster.words(Faker::Number.between(1, 5), true, true) }
  sequence(:view_count) { rand(1000) }

  factory :user, class: Integral::User do
    name
    email
    password               "password"
    password_confirmation  "password"

    factory :settings_manager do
      role_ids { [ Integral::Role.find_by_name('SettingsManager').id ] }
    end

    factory :page_manager do
      role_ids { [ Integral::Role.find_by_name('PageManager').id ] }
    end

    factory :user_manager do
      role_ids { [ Integral::Role.find_by_name('UserManager').id ] }
    end

    factory :image_manager do
      role_ids { [ Integral::Role.find_by_name('ImageManager').id ] }
    end

    factory :gallery_manager do
      role_ids { [ Integral::Role.find_by_name('GalleryManager').id ] }
    end

    factory :messenger do
      role_ids { [ Integral::Role.find_by_name('Messenger').id ] }
    end
  end

  factory :role, class: Integral::Role do
    name 'some_role'
  end

  factory :image, class: Integral::Image do
    title
    description
    width 1
    height 2
    file { Rack::Test::UploadedFile.new(File.join(Integral::Engine.root, 'spec', 'support', 'image.jpg')) }
  end

  factory :integral_page, class: 'Integral::Page' do
    title
    path { "/#{Faker::Lorem.words(2).join('/')}" }
    description
    body
  end

  factory :integral_post, class: 'Integral::Post' do
    title
    description
    tag_list
    user
    image { Rack::Test::UploadedFile.new(File.join(Integral::Engine.root, 'spec', 'support', 'image.jpg')) }
    body
    view_count
  end
end

