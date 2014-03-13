class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :set_locale
  before_filter :authorize
  delegate :allow?, to: :current_permission
  helper_method :allow?

  private

  def set_locale
    
    I18n.locale = params[:locale]  || I18n.default_locale
    # current_user.locale
    # request.subdomain
    # request.env["HTTP_ACCEPT_LANGUAGE"]
    # request.remote_ip
  end

  def default_url_options(options = {})
    {locale: I18n.locale}
  end


  def current_permission
    user = current_user || User.new
    @current_permission ||= Permission.new(user)
  end

  def authorize
    
    if !current_permission.allow?(params[:controller], params[:action])
      redirect_to root_url, alert: "Not authorized."
    end
  end

  def add_terms(taxonomy_array,object)
    #TODO Check if exist instead of deleting when everything is properly working ;-)
        object.terms.destroy_all
        taxonomy_array.each do |terms_ids|
          terms_ids = terms_ids[1].split(",")
          terms_ids.uniq!
          terms_ids.reject! {|x| x=="undefined"}
          terms_ids.reject! {|x| x==""}
          terms_ids.each do |term_id|
          
          instance_variable_set("@taxonomizable_#{term_id}", object.taxonomizables.build )
          eval("@taxonomizable_#{term_id}.term_id = term_id")
        end
    end
  end

end
