class MembershipsController < ApplicationController
  

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.page(params[:page])
    @membership  = Membership.new
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new


  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create

    @membership = Membership.new membership_params



    respond_to do |format|
      if @membership.save
        format.html { redirect_to :back , notice: ("memberships.member_added_%s".t % @membership.email ) }
        format.json { render action: 'show', status: :created, location: @membership }
      else

        format.html { redirect_to :back , warning: @membership.errors.to_s }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    @membership = Membership.find params[:id]
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to :back , warning: ("memberships.member_deleted_%s".t % @membership.email )}
      format.json { head :no_content }
    end
  end

  def massive_update

    
    @membership = Membership.new
    
    @membership.parse_csv params[:the_file].read if params[:the_file].respond_to? :read
    redirect_to memberships_path

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def standard_a
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:email, :membership_code)
    end
end
