require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TravelExpenseReportsController, type: :controller do

  before(:each) do
    login_with create (:user)
  end

  # This should return the minimal set of attributes required to create a valid
  # TravelExpenseReport. As you add validations to TravelExpenseReport, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {:inland => true,
     :country => "Germany",
     :location_from => "Potsdam",
     :location_via => "London",
     :location_to => "NYC",
     :reason => "Hana Things",
     :date_start => 8.days.ago,
     :date_end=>  DateTime.now,
     :car => true,
     :public_transport=>  true,
     :vehicle_advance=>  false,
     :hotel => true,
     :general_advance =>  2000,
     :signature => true,
     :user => User.first}
  }
  
  let(:advance_blank_attributes) {
    {:inland => true,
     :country => "Germany",
     :location_from => "Potsdam",
     :location_via => "London",
     :location_to => "NYC",
     :reason => "Hana Things",
     :date_start => 8.days.ago,
     :date_end=>  DateTime.now,
     :car => true,
     :public_transport=>  true,
     :vehicle_advance=>  false,
     :hotel => true,
     :general_advance => "",
     :signature => true,
     :user => User.first}
  }

  let(:invalid_attributes) {
    {:inland => true,
     :country => "Germany",
     :location_from => "Potsdam",
     :location_via => "London",
     :location_to => "NYC",
     :reason => "Hana Things",
     :date_start => DateTime.now,
     :date_end=>  8.days.ago,
     :car => true,
     :public_transport=>  true,
     :vehicle_advance=>  false,
     :hotel => true,
     :general_advance => -100,
     :signature => true,
     :user => User.first}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TravelExpenseReportsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all travel_expense_reports as @travel_expense_reports" do
      travel_expense_report = TravelExpenseReport.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:travel_expense_reports)).to eq([travel_expense_report])
    end
  end

  describe "GET #show" do
    it "assigns the requested travel_expense_report as @travel_expense_report" do
      travel_expense_report = TravelExpenseReport.create! valid_attributes
      get :show, {:id => travel_expense_report.to_param}, valid_session
      expect(assigns(:travel_expense_report)).to eq(travel_expense_report)
    end
  end

  describe "GET #new" do
    it "assigns a new travel_expense_report as @travel_expense_report" do
      get :new, {}, valid_session
      expect(assigns(:travel_expense_report)).to be_a_new(TravelExpenseReport)
    end
  end

  describe "GET #edit" do
    it "assigns the requested travel_expense_report as @travel_expense_report" do
      travel_expense_report = TravelExpenseReport.create! valid_attributes
      get :edit, {:id => travel_expense_report.to_param}, valid_session
      expect(assigns(:travel_expense_report)).to eq(travel_expense_report)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new TravelExpenseReport" do
        expect {
          post :create, {:travel_expense_report => valid_attributes}, valid_session
        }.to change(TravelExpenseReport, :count).by(1)
      end

      it "assigns a newly created travel_expense_report as @travel_expense_report" do
        post :create, {:travel_expense_report => valid_attributes}, valid_session
        expect(assigns(:travel_expense_report)).to be_a(TravelExpenseReport)
        expect(assigns(:travel_expense_report)).to be_persisted
      end

      it "redirects to the created travel_expense_report" do
        post :create, {:travel_expense_report => valid_attributes}, valid_session
        expect(response).to redirect_to(TravelExpenseReport.last)
      end

      
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved travel_expense_report as @travel_expense_report" do
        post :create, {:travel_expense_report => invalid_attributes}, valid_session
        expect(assigns(:travel_expense_report)).to be_a_new(TravelExpenseReport)
      end

      it "re-renders the 'new' template" do
        post :create, {:travel_expense_report => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
      it 'rejects blank values for advance' do
        post :create, {:travel_expense_report => advance_blank_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        valid_attributes[:first_name] = "Tobias"
        valid_attributes
      }

      it "updates the requested travel_expense_report" do
        travel_expense_report = TravelExpenseReport.create! valid_attributes
        put :update, {:id => travel_expense_report.to_param, :travel_expense_report => new_attributes}, valid_session
        travel_expense_report.reload
        expect(assigns(:travel_expense_report)).to eq(travel_expense_report)
      end

      it "assigns the requested travel_expense_report as @travel_expense_report" do
        travel_expense_report = TravelExpenseReport.create! valid_attributes
        put :update, {:id => travel_expense_report.to_param, :travel_expense_report => valid_attributes}, valid_session
        expect(assigns(:travel_expense_report)).to eq(travel_expense_report)
      end

      it "redirects to the travel_expense_report" do
        travel_expense_report = TravelExpenseReport.create! valid_attributes
        put :update, {:id => travel_expense_report.to_param, :travel_expense_report => valid_attributes}, valid_session
        expect(response).to redirect_to(travel_expense_report)
      end
    end

    context "with invalid params" do
      it "assigns the travel_expense_report as @travel_expense_report" do
        travel_expense_report = TravelExpenseReport.create! valid_attributes
        put :update, {:id => travel_expense_report.to_param, :travel_expense_report => invalid_attributes}, valid_session
        expect(assigns(:travel_expense_report)).to eq(travel_expense_report)
      end

      it "re-renders the 'edit' template" do
        travel_expense_report = TravelExpenseReport.create! valid_attributes
        put :update, {:id => travel_expense_report.to_param, :travel_expense_report => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested travel_expense_report" do
      travel_expense_report = TravelExpenseReport.create! valid_attributes
      expect {
        delete :destroy, {:id => travel_expense_report.to_param}, valid_session
      }.to change(TravelExpenseReport, :count).by(-1)
    end

    it "redirects to the travel_expense_reports list" do
      travel_expense_report = TravelExpenseReport.create! valid_attributes
      delete :destroy, {:id => travel_expense_report.to_param}, valid_session
      expect(response).to redirect_to(travel_expense_reports_url)
    end
  end

end
