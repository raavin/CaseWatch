class ExpendituresController < ApplicationController

  in_place_edit_for :expenditure, :amount
  before_filter :authenticate_user!
  #before_filter :get_client 
  layout "expenditure"
  cattr_reader :per_page
  @@per_page = 50
  filter_access_to :all
  
  # GET /expenditures
  # GET /expenditures.xml
  
  def all
    @consumers = Consumer.all
    @services   = Service.all
    @expenditures = Expenditure.paginate :page => params[:page], :per_page => 30, :order => "created_at DESC"
    @consumer_total = Expenditure.calculate(:sum, :amount, :conditions => ['consumer_id = ?', params[:consumer_id]])
    @total = Expenditure.calculate(:sum, :amount)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @expenditures }
    end
  end

  # GET /expenditures
  # GET /expenditures.json
  def index
    @consumers = Consumer.find(params[:consumer_id])
    @services   = Service.all
    @expenditures = @consumer.expenditures.paginate :page => params[:page], :per_page => 10, :order => "created_at DESC"
    @consumer_total = Expenditure.calculate(:sum, :amount, :conditions => ['consumer_id = ?', params[:consumer_id]])
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenditures }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.json
  def show
    @consumers = Consumer.find(params[:consumer_id])
    @services = Service.all
    @expenditure = @consumer.expenditures.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/new
  # GET /expenditures/new.json
  def new
    @consumer = Consumer.find(params[:consumer_id])
    @services = Service.all

    @expenditure = @consumer.expenditures.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expenditure }
    end
  end

  # GET /expenditures/1/edit
  def edit
    @consumer = Consumer.find(params[:consumer_id])
    @services = Service.all
    @expenditure = @consumer.expenditures.find(params[:id])
  end

  # POST /expenditures
  # POST /expenditures.xml
  def create
    @consumer = Consumer.find(params[:consumer_id])
    @services = Service.find(:all)
    @expenditure = @consumer.expenditures.build(params[:expenditure])
    @expenditure.user_id = current_user.id
    @expenditure.service_id = params[:category][:service_id]
    
    respond_to do |format|
      if @expenditure.save
        format.html { redirect_to(consumer_expenditure_path(@consumer, @expenditure), :notice => 'Expenditure was successfully created.') }
        format.xml  { render :xml => @expenditure, :status => :created, :location => @expenditure }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @expenditure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.xml
  def update
    @consumer = Consumer.find(params[:consumer_id])
  
    @expenditure = Expenditure.find(params[:id])
    @expenditure.user_id = current_user.id
    @expenditure.service_id = params[:category][:service_id]
    
    respond_to do |format|
      if @expenditure.update_attributes(params[:expenditure])
        format.html { redirect_to(consumer_expenditures_path, :notice => 'Expenditure was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @expenditure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.xml
  def destroy
    @consumer = Consumer.find(params[:consumer_id])
      
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy

    respond_to do |format|
      format.html { redirect_to client_expenditures_url }
      format.json  { head :no_content }
    end
  end
  
  private
    
    def get_consumer
       @consumer = Consumer.find(params[:consumer_id])
    end 

  end
end