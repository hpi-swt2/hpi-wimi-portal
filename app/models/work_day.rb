class WorkDay < ActiveRecord::Base
	belongs_to :user
	belongs_to :project

	validates :user_id, presence: true, numericality: true
	validates :project_id, presence:true, numericality: true
	validates :date, presence: true
	validates :start_time, presence: true
	validates :break, presence: true, numericality: true
	validates :end_time, presence: true
	validate :project_id_exists

	def duration
    return (end_time - start_time).to_i / 60 - self.break
  end

	def project_id_exists
		return false if Project.find_by_id(self.project_id).nil?
	end

	def self.all_for(year, month, project, user)
		date = Date.new(year, month)
		month_start = date.beginning_of_month
		month_end = date.end_of_month
		if project.nil?
			return WorkDay.where(date: month_start..month_end, user_id: user)
		else
			return WorkDay.where(date: month_start..month_end, user_id: user, project_id: project)
		end
	end
end
