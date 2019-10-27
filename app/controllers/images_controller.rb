class ImagesController < ApplicationController
  before_action :require_login

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      flash[:success] = "Image successfully uploaded."
      redirect_to admin_panel_path
    end
  end

  def destroy
    @image = Image.find(params[:id])
    if @image.destroy!
      flash[:success] = "Image successfully removed."
      redirect_to admin_panel_path
    else
      flash[:danger] = "Something went wrong. Image not deleted. Try again."
      redirect_to admin_panel_path
    end
  end

  private

  def image_params
    params.require(:image).permit(:url)
  end
end
