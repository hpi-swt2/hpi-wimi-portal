class ChairWimi < ActiveRecord::Base
  belongs_to :user
  belongs_to :chair
end
