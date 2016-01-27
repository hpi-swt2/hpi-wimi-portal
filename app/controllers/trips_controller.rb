class TripsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: :index

  before_action :set_trip, only: [:show, :edit, :update, :destroy, :download, :apply, :hand_in]
  rescue_from CanCan::AccessDenied do |_exception|
    flash[:error] = I18n.t('not_authorized')
    redirect_to trips_path
  end

  def index
    @trips = Trip.where(user: current_user)
  end

  def show
    unless (@trip.user == current_user) || ((can? :see_trips, @trip.user) && (can? :edit_trip, @trip))
      redirect_to root_path
      flash[:error] = I18n.t('trip.not_authorized')
    end
  end

  def new
    @trip = Trip.new
    2.times { @trip.trip_datespans.build }
  end

  def edit
    if @trip.status == 'applied'
      redirect_to @trip
      flash[:error] = I18n.t('trip.applied')
    else
      fill_blank_items
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      redirect_to @trip
      flash[:success] = I18n.t('trip.save')
    else
      fill_blank_items
      render :new
    end
  end

  def update
    @trip.update(status: 'saved')
    if @trip.update(trip_params)
      redirect_to @trip
      flash[:success] = I18n.t('trip.update')
    else
      fill_blank_items
      render :edit
    end
  end

  def hand_in
    if @trip.status == 'saved'
      if @trip.update(status: 'applied')
        ActiveSupport::Notifications.instrument('event', {trigger: current_user.id, target: @trip.id, chair: current_user.chair, type: 'EventRequest', seclevel: :representative, status: 'trip'})
      end
    end
    redirect_to trips_path
  end

  def destroy
    if @trip.status == 'applied'
      redirect_to @trip
      flash[:error] = I18n.t('trip.applied')
    else
      @trip.destroy
      redirect_to trips_url
      flash[:sucess] = I18n.t('trip.destroyed')
    end
  end

  def download
  end

  def reject
    if (can? :read, @trip) && @trip.status == 'applied'
      @trip.update_attributes(status: 'declined', last_modified: Date.today)
      redirect_to @trip.user
    else
      redirect_to root_path
      flash[:error] = t('trip.not_authorized')
    end
  end

  def accept
    if(can? :read, @trip) && @trip.status == 'applied'
      @trip.update_attributes(status: 'accepted', last_modified: Date.today)
      redirect_to @trip.user
    else
      redirect_to root_path
      flash[:error] = t('trip.not_authorized')
    end
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(Trip.column_names.map(&:to_sym), trip_datespans_attributes: [:id, :start_date, :end_date, :days_abroad])
  end

  def fill_blank_items
    (2 - @trip.trip_datespans.size).times { @trip.trip_datespans.build }
  end
end
