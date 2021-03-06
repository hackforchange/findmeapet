class PeopleController < ApplicationController
  # GET /people
  # GET /people.xml
   
  helper_method :person

  def person
    @person ||= Person.find(session[:person_id])
  end

  def registration
    rg = RestGraph.new(:app_id => APP_ID, :secret => APP_SECRET)
    parsed_request = rg.parse_signed_request!(params["signed_request"])
    city,state = parsed_request["registration"]["location"]["name"].split(/,/)

    person = Person.create!(:name => parsed_request["registration"]["name"],
                            :city => city.strip,
                            :facebook_id => parsed_request["user_id"],
                            :state => state.strip,
                            :phone => parsed_request["registration"]["phone"].scan(/\d/).join,
                            :email => parsed_request["registration"]["email"])

    session[:person_id] = person.id

    redirect_to person_path(person.id)
  end

  def thank_you
  end

  def index
    @people = Person.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    #rg = RestGraph.new( :app_id => APP_ID, :secret => APP_SECRET)
    #parsed_request = rg.parse_signed_request!(params["signed_request"])
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end
end
