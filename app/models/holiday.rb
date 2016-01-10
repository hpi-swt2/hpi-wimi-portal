# == Schema Information
#
# Table name: holidays
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  start               :date
#  end                 :date
#  status              :integer          default(0), not null
#  reason              :string
#  annotation          :string
#  replacement_user_id :integer
#  length              :integer
#

class Holiday < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :start, :end, :length
  validates_date :start
  validates_date :end
  validates_date :start, on_or_after: :today
  validates_date :end, on_or_after: :start
  validate :too_far_in_the_future?
  validate :sufficient_leave_left?
  enum status: [ :saved, :applied, :accepted, :declined ]

  def duration
    start.business_days_until(self.end+1)
  end

  private

  def too_far_in_the_future?
    unless self.end.year < Date.today.year + 2
      errors.add(:Holiday, 'is too far in the future')
    end
  end

  def sufficient_leave_left?
    #need to assert that user is existent for tests
    if self.user
      unless self.user.remaining_leave >= (length.nil? ? duration : length)
        errors.add(:not_enough_leave_left!, "" )
      end
  	end
  end
end
