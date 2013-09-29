# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audit, class: 'AuditRails::Audit' do
    action 'home'
    controller 'welcome'
    user_name 'Fake user'
    description 'Anything'
  end
end
