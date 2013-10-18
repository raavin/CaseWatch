class ConsumersController < ApplicationController
    before_filter :authenticate_user!
    layout "application"
    cattr_reader :per_page
    @@per_page = 50
    #filter_access_to :all
  
  # GET /consumers
  # GET /consumers.json

  def index
    @services = Service.find(:all, :order => "service_name")
    @countries  = params[:consumer]
    @categories = Category.find(:all,:order => "service_id, name") 
    if params[:searchconsumers]
      
      @consumer = Consumer.paginate :per_page => 100, :page => params[:page], 
        :order => 'first_name, last_name', 
        :joins => :services, 
        :conditions => ['first_name LIKE ? OR last_name LIKE ? AND consumers_services.service_id IN (?)',
          "%#{params[:searchconsumers]}%","%#{params[:searchconsumers]}%", current_user.service_id]#TODO need to make this work
        
      @case_notes  = CaseNote.find(:first, :conditions => ['consumer_id = ?',@consumer])
    else
    
     @consumers = Consumer.paginate :per_page => 10, :page => params[:page], :order => 'last_name, first_name', 
               :include => :services, :conditions => { "consumers_services.service_id" => current_user.service_id}
   
    end
    @services = Service.find(:all, :order => "service_name")
    @waiting_lists = WaitingList.find(:all)
    @messages = Message.find(:all,:order => "created_at DESC")  

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @consumers }
    end
  end

  # GET /consumers/1
  # GET /consumers/1.json
  def show
    @consumer = Consumer.find(params[:id])
    @services = Service.find(:all, :order => "service_name")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @consumer }
    end
  end

  # GET /consumers/new
  # GET /consumers/new.json
  def new
    @consumer = Consumer.new
    @services = Service.find(:all, :order => "service_name")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @consumer }
    end
  end

  # GET /consumers/1/edit
  def edit
    @consumer = Consumer.find(params[:id])
    @services = Service.find(:all, :order => "service_name")
  end

  # POST /consumers
  # POST /consumers.json
  def create
    @consumer = Consumer.new(params[:consumer])

    respond_to do |format|
      if @consumer.save
        format.html { redirect_to @consumer, notice: 'Consumer was successfully created.' }
        format.json { render json: @consumer, status: :created, location: @consumer }
      else
        format.html { render action: "new" }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /consumers/1
  # PUT /consumers/1.json
  def update
    params[:client][:service_ids] ||=[]
    @consumer = Consumer.find(params[:id])

    respond_to do |format|
      if @consumer.update_attributes(params[:consumer])
        format.html { redirect_to @consumer, notice: 'Consumer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @consumer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /consumers/1
  # DELETE /consumers/1.json
  def destroy
    @consumer = Consumer.find(params[:id])
    @consumer.destroy

    respond_to do |format|
      format.html { redirect_to consumers_url }
      format.json { head :no_content }
    end
  end
  
def waiting
    @services = Service.paginate :page => params[:page]
    @waiting_lists = WaitingList.paginate :page => params[:page], :per_page => 50
    if request.post?
      
      for service in @services
        if params[service.service_name + "dd"]
          @waiting_list = WaitingList.create(
          :consumer_id  => params[:radio],
          :service_id => service.id,
          :category_id => params[service.service_name][:id],
          :referral_date => Time.now
          )
          
          # TODO Need to do the verification Flash notice properly
            
          flash[:notice] = 'Consumer was successfully added to waiting list.'
          
        else
          flash[:notice] = 'Consumer was not successfully added to waiting list.'
          @waiting_list = 0
        end
      end
        if @waiting_list
          redirect_to consumers_path
        else
          render consumers_path
        end
    end
end


end
