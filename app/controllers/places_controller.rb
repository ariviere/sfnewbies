class PlacesController < ApplicationController
  # GET /places
  # GET /places.json  
  before_filter :authenticate_admin, only: [:new, :create, :edit, :update, :destroy]
  
  def authenticate_admin
    if !user_signed_in? 
      redirect_to new_user_session_path, flash: { error: "Vous devez vous connecter" }
      return
    end
    
    if !current_user.try(:admin?)
      redirect_to places_path, flash: { error: "Vous n'avez pas les droits suffisants" }
      return
    end
  end
  
  def filter
    @filtered_cat = params[:filter][:cat]
    if(@filtered_cat.empty?)
      @places = Place.all
    else
      @places = Place.where(category_id: @filtered_cat)
    end
    @json = define_json(@places)
    render :index
    
  end
  
  def index
    @places = Place.all
    #@json = @places.to_gmaps4rails
    @json = define_json(@places)
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.find(params[:id])
    @comment = Comment.new(place_id: @place.id)
    @json = Place.find(params[:id]).to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/new
  # GET /places/new.json
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.json
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to places_url }
      format.json { head :no_content }
    end
  end
  
  private
  
  def define_json(places)
    places.to_gmaps4rails do |place, marker|
      marker.infowindow render_to_string(:partial => "infowindow", :locals => { :place => place})
      marker.picture({
                      :picture  => "/assets/map_icons/#{place.category.identity}.png",
                      :width    => 32,
                      :height   => 37
                     })
      marker.title   place.name
      marker.json({ :id => place.id })
    end
  end
end
