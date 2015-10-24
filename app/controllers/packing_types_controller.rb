class PackingTypesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_packing_type, only: [:show, :edit, :update, :destroy]

  # GET /packing_types
  # GET /packing_types.json
  def index
    @packing_types = PackingType.all
  end

  # GET /packing_types/1
  # GET /packing_types/1.json
  def show
  end

  # GET /packing_types/new
  def new
    @packing_type = PackingType.new
  end

  # GET /packing_types/1/edit
  def edit
  end

  # POST /packing_types
  # POST /packing_types.json
  def create
    @packing_type = PackingType.new(packing_type_params)

    respond_to do |format|
      if @packing_type.save
        format.html { redirect_to @packing_type, notice: 'Packing type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @packing_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @packing_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packing_types/1
  # PATCH/PUT /packing_types/1.json
  def update
    respond_to do |format|
      if @packing_type.update(packing_type_params)
        format.html { redirect_to @packing_type, notice: 'Packing type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @packing_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packing_types/1
  # DELETE /packing_types/1.json
  def destroy
    @packing_type.destroy
    respond_to do |format|
      format.html { redirect_to packing_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_packing_type
      @packing_type = PackingType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def packing_type_params
      params.require(:packing_type).permit(:amount, :measure, :code, :gross_weight)
    end
end
