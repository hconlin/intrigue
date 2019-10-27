class HomeController < ApplicationController
  before_action :require_login, only:[:admin, :cover]

  def index
    @slides = Slide.all
    @cover = Image.where(is_cover: true).first
  end

  def admin
    @images = Image.all.order('created_at DESC')
    @slides = Slide.all
    @image = Image.new
  end

  def cover
    @cover = Image.find(params[:id])
    @cover.make_cover
    flash[:success] = "Image successfully set as cover."
    redirect_to admin_panel_path
  end

  def delete_cover
    @cover = Image.find(params[:id])
    @cover.remove_cover
    flash[:success] = "Image successfully removed as cover."
    redirect_to admin_panel_path
  end

  def gallery
    @images = Image.all.order('created_at DESC')
  end
end
