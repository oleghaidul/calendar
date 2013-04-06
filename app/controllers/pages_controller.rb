class PagesController < ApplicationController
  load_and_authorize_resource

  def create
    @page.save
    respond_with @page
  end

  def update
    @page.update_attributes(params[:page])
    respond_with @page
  end

  def destroy
    @page.destroy
    redirect_to pages_url
  end

end
