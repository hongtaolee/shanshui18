class PictureController < ApplicationController
  layout "default"
  
  def index
    params[:id] ||= 1
    @category = params[:id].to_i
    params[:page] ||= 1
    params[:per_page] ||= 7
    offset = ((params[:page].to_i) - 1 ) * (params[:per_page].to_i)
    @pictures = Picture.all(@category,params[:per_page],offset)
    total_count = Picture.pictures_count(@category)
    @total_page = (total_count.to_f / params[:per_page]).ceil

    if Const::HOUSE_CATEGORY.keys.include?(@category)
      @nav_class = "house"
      @content = IndexContent.get_content(:house_info)
      @title = "温馨住宿"
      render :action => "house"
    elsif Const::FOOD_CATEGORY.keys.include?(@category)
      @nav_class = "food"
      @title = "农家美食"
      @content = IndexContent.get_content(:food_info)
      render :action => "food"
    elsif Const::CS_CATEGORY.keys.include?(@category)
      @nav_class = "cs"
      @title = "真人CS"
      @content = IndexContent.get_content(:cs_info)
      render :action => "cs"
    end
  end

  def edit
    @nav_class = "cms"
  end

end
