class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  before_filter :authenticate_admin
  
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
  
  def index
    @categories = Category.all
    @category = Category.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])
    @category.identity = Category.normalize(@category.name)
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    #@category.places.each do |place|
    #  place.destroy
    #end
    @category.destroy

    respond_to do |format|
      format.js
    end
  end
  
end
