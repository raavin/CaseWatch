class CaseNotesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_client
  before_filter :load_services, :except => :destroy
  layout "case_note"
  cattr_reader :per_page
  @@per_page = 50
  filter_access_to :all

  # GET /case_notes
  # GET /case_notes.json
  def index
    @case_notes = @client.case_notes.paginate :page => params[:page], :per_page => 10, :order => "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @case_notes }
    end
  end

  # GET /case_notes/1
  # GET /case_notes/1.json
  def show
    @case_note = CaseNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @case_note }
    end
  end

  # GET /case_notes/new
  # GET /case_notes/new.json
  def new
    @case_note = CaseNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @case_note }
    end
  end

  # GET /case_notes/1/edit
  def edit
    @case_note = CaseNote.find(params[:id])
  end

  # POST /case_notes
  # POST /case_notes.json
  def create
    @case_note = CaseNote.new(params[:case_note])

    respond_to do |format|
      if @case_note.save
        format.html { redirect_to @case_note, notice: 'Case note was successfully created.' }
        format.json { render json: @case_note, status: :created, location: @case_note }
      else
        format.html { render action: "new" }
        format.json { render json: @case_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /case_notes/1
  # PUT /case_notes/1.json
  def update
    @case_note = CaseNote.find(params[:id])

    respond_to do |format|
      if @case_note.update_attributes(params[:case_note])
        format.html { redirect_to @case_note, notice: 'Case note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @case_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /case_notes/1
  # DELETE /case_notes/1.json
  def destroy
    @case_note = CaseNote.find(params[:id])
    @case_note.destroy

    respond_to do |format|
      format.html { redirect_to case_notes_url }
      format.json { head :no_content }
    end
  end

private
  
  def get_client
    @client = Client.find(params[:client_id])
  end 

  def load_services
    @services   = Service.all
  end
end
end
