class TravelExpenseReportsController < ApplicationController
  before_action :set_travel_expense_report, only: [:show, :edit, :update, :destroy]

  def index
    @travel_expense_reports = TravelExpenseReport.all
  end

  def show
  end

  def new
    @travel_expense_report = TravelExpenseReport.new
    @travel_expense_report.user = current_user
    8.times {@travel_expense_report.travel_expense_report_items.build}
  end

  def edit
    (8-@travel_expense_report.travel_expense_report_items.size).times {@travel_expense_report.travel_expense_report_items.build}
  end

  def create
    @travel_expense_report = TravelExpenseReport.new(travel_expense_report_params)
    @travel_expense_report.user = current_user

    if @travel_expense_report.save
      redirect_to @travel_expense_report, notice: 'Travel expense report was successfully created.'
    else
      render :new
    end
  end

  def update
    if @travel_expense_report.update(travel_expense_report_params)
      redirect_to @travel_expense_report, notice: 'Travel expense report was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @travel_expense_report.destroy
    redirect_to travel_expense_reports_url, notice: 'Travel expense report was successfully destroyed.'
  end

  private
    def set_travel_expense_report
      @travel_expense_report = TravelExpenseReport.find(params[:id])
    end

    def travel_expense_report_params
      params.require(:travel_expense_report).permit(TravelExpenseReport.column_names.map(&:to_sym), travel_expense_report_items_attributes:[:id,:date,:breakfast,:lunch,:dinner,:annotation])
    end
end
