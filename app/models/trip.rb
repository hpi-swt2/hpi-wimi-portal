# == Schema Information
#
# Table name: trips
#
#  id            :integer          not null, primary key
#  destination   :string
#  reason        :text
#  annotation    :text
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :integer          default(0)
#  signature     :boolean
#  last_modified :date
#

class Trip < ActiveRecord::Base
  belongs_to :user
  has_one :expense
  validates_presence_of :destination, :user,:date_start,:date_end, :days_abroad
  validates :days_abroad, numericality: {greater_than_or_equal_to: 0}
  validate :start_before_end_date, :days_abroad_leq_to_total_days

  enum status: %w[saved applied accepted declined]

  before_validation(on: :create) do
    self.status = 'saved'
  end

  def name
    user.name
  end

  def has_expense?
    return !self.expense.nil?
  end

  def total_days
    (date_end - date_start).to_i
  end

  private

  def days_abroad_leq_to_total_days
    #TODO: Geht das besser?
    if date_end && date_start && days_abroad && days_abroad > total_days
      errors.add(:days_abroad, "can't be larger than total days")
    end
  end

  def start_before_end_date
    if date_start && date_end && date_end < date_start
      errors.add(:date_start, "can't be before date_end")
    end
  end

end
