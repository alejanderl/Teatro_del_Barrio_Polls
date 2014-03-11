class TaxonomiesController < ApplicationController
  
  def index
   
    @terms = Term.order("parent_id asc, name asc")
   # @terms = @terms.sort_by {|x| x[:parent_id]}
    @term = Term.new
    @taxonomies = Taxonomy.all
    

    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @terms}
    end
      
  end


 
  

	def new

	  @term = Term.new()
    @term.parent_id = params[:parent_id]
	      respond_to do |format|
	      format.html # index.html.erb
	      format.js
	      format.json { render json: @terms}
	    end
	  
	end
def show
end

def edit
  
  @term = Term.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @terms}
    end
  
end


  def create
    
    @term = Term.new(standard_attributes)
    
    respond_to do |format|
      if @term.save
        format.html {redirect_to(taxonomies_url, notice: t('messages.term_created'))}
      else
        format.html {redirect_to(taxonomies_url, notice: t('messages.term_not_created'))}
      end
    end
    
    
  end
  
  def update
    
    @term =  Term.find(params[:id])
    respond_to do |format|
     if @term.update_attributes(standard_attributes)
        format.html {redirect_to(taxonomies_url, notice: t('messages.term_created'))}
      else
        format.html {redirect_to(taxonomies_url, notice: t('messages.term_not_created'))}
     end
   end
    
  end
  
  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to taxonomies_url }
      format.js
      format.json { head :no_content }
    end
  end

    private

  def standard_attributes

    
    params.require(:term).permit(:name,:taxonomy_id,:parent_id)

  end


end