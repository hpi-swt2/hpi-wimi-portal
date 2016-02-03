# == Schema Information
#
# Table name: expenses
#
#  id               :integer          not null, primary key
#  inland           :boolean
#  country          :string
#  location_from    :string
#  location_via     :string
#  reason           :text
#  car              :boolean
#  public_transport :boolean
#  vehicle_advance  :boolean
#  hotel            :boolean
#  status           :integer          default(0)
#  general_advance  :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  signature        :boolean
#  trip_id          :integer
#  time_start       :string
#  time_end         :string
#

FactoryGirl.define do
  factory :expense do
    inland true
    country 'Germany'
    location_from 'Potsdam'
    location_via 'London'
    time_start '12:00'
    time_end '23:00'
    reason 'Hana Things'
    car true
    public_transport true
    vehicle_advance false
    hotel true
    general_advance 2000
    signature true
    user
    trip
    after(:create) do |report|
      report.expense_items << FactoryGirl.build(:expense_item, expense: report)
    end
  end

  factory :expense_invalid, class: Expense do
    inland true
    country 'Germany'
    location_from 'Potsdam'
    location_via 'London'
    time_start '1203102:231239asda'
    reason 'Hana Things'
    car true
    public_transport true
    vehicle_advance false
    hotel true
    general_advance -20
    signature true
    user
    trip
    to_create {|i| i.save(validate: false)}
  end

  factory :expense_changed, parent: :expense do
    location_from 'Berlin'
    general_advance 1337
    car false
    hotel false
    vehicle_advance true
  end

  factory :expense_blank_name, parent: :expense do
    first_name ''
  end

  factory :expense_negative_advance, parent: :expense do
    general_advance -10
  end
end
