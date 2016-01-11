# == Schema Information
#
# Table name: trips
#
#  id                 :integer          not null, primary key
#  destination        :string
#  reason             :text
#  annotation         :text
#  user_id            :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  status             :integer          default(0)
#  signature          :boolean
#  person_in_power_id :integer
#

class Trip < ActiveRecord::Base
  belongs_to :user
  has_many :trip_datespans
  accepts_nested_attributes_for :trip_datespans, reject_if: lambda {|attributes| attributes['days_abroad'].blank?}
  validates :destination, presence: true
  validates :user, presence: true
  has_many :expenses
  belongs_to :person_in_power, class_name: 'User'
  enum status: [ :saved, :applied, :accepted, :declined ]

  def name
    self.user.name
  end

  def accept(accepter)
    self.update(person_in_power_id: accepter.id, status: :accepted)
    ActiveSupport::Notifications.instrument("event", {trigger: self.id, target: self.user.id, seclevel: :wimi, type: "EventTravelRequestAccepted"})
  end

  def decline(declined_by)
    self.update(person_in_power_id: declined_by.id, status: :declined)
    ActiveSupport::Notifications.instrument("event", {trigger: self.id, target: self.user.id, seclevel: :wimi, type: "EventTravelRequestDeclined"})
  end
end
