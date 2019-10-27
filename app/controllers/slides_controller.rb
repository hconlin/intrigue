class SlidesController < ApplicationController

  def new
    @slide = Slide.new
  end

  def create
    @slide = Slide.new(slide_params)
    if @slide.save
      flash[:success] = "Slide successfully set."
      redirect_to admin_panel_path
    end
  end

  def destroy
    @slide = Slide.find(params[:id])
    if @slide.destroy!
      flash[:success] = "Slide successfully removed from slide show."
      redirect_to admin_panel_path
    else
      flash[:danger] = "Something went wrong. Slide not removed. Try again."
      redirect_to admin_panel_path
    end
  end

  private

  def slide_params
    params.permit(:image_id)
  end

end
