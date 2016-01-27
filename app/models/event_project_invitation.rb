# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  trigger_id :integer
#  target_id  :integer
#  chair_id   :integer
#  seclevel   :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :string
#

class EventProjectInvitation < Event
  before_save :set_defaults
  belongs_to :target, class_name: 'User'
  belongs_to :trigger, class_name: 'Invitation'

  def set_defaults
    self.seclevel = :hiwi
    self.type = "EventProjectInvitation"
  end
end
