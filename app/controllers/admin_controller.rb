require "digest/sha1"
class AdminController < ApplicationController
  layout "default"

  before_filter :check_auth, :except => [:login]
  # 管理后台首页
  def index
    redirect_to :action => :post
    @nav_class = 'cms'
  end

  # 管理后台登陆页面
  def login
    if request.post?
      if Digest::SHA1.hexdigest(params[:password]) == 'c3b084fed8a38a56385fb29d24feb0c76d79eef8'
        session[:auth] = 'asdf'
        redirect_to :action => :post
      else
        flash.now[:error] = "密码错误，请重新输入"
      end
    end
  end

  # 山水及美景图片管理页面
  def image
    @title = "后台编辑——娱乐及美景"
    params[:page] ||= 1
    params[:per_page] ||= 20
    offset = ((params[:page].to_i) - 1 ) * (params[:per_page].to_i)
    @pictures = Picture.all(nil,params[:per_page],offset)
    total_count = Picture.pictures_count
    @total_page = (total_count.to_f / params[:per_page]).ceil
    @nav_class = 'cms'
  end

  # 山水及美景图片编辑页面
  def image_edit
    @nav_class = 'cms'
    @title = "后台编辑——娱乐及美景"

    if !params[:id].blank?
      @picture = Picture.find(params[:id])
    else
      @picture = Picture.new
    end
    if request.post?
      flash[:errors] = []
      @picture.name = params[:picture][:name] if !params[:picture][:name].blank?
      @picture.category = params[:picture][:category] if !params[:picture][:category].blank?
      @picture.picture = params[:picture][:picture] if !params[:picture][:picture].blank?

      if @picture.save
        redirect_to :action => 'image'
      else
        # 报错
        @picture.errors.each do |attr_name,msg|
          flash.now[:errors] << msg
        end unless @picture.errors.blank?     
      end
    end
  end

  # 删除图片
  def image_delete
    @picture = Picture.find(params[:id])
    @picture.status = Picture::STATUS_DELETED
    @picture.save(false)
    render :update do |page|
      page.redirect_to :action => :image
    end

  end

  # 最新动态管理页面
  def post
    @nav_class = 'cms'
    @title = "后台编辑——农家乐资讯"
    params[:category] = 0
    total_count = Post.posts_count(params[:category])
    limit, offset = process_paginate(total_count)
    @posts = Post.all(params[:category],limit,offset)
  end

  def post_buy
    if @post = Post.buy_info
      redirect_to :controller => 'admin', :action => "post_edit", :id => @post.id
    else
      redirect_to :controller => "admin", :action => "post_edit", :category => Const::BUY_POST_CATEGORY
    end
  end

  def post_fun
    @nav_class = 'cms'
    @title = "后台编辑——风景娱乐"
    params[:category] = Const::FUN_POST_CATEGORY
    total_count = Post.posts_count(params[:category])
    limit, offset = process_paginate(total_count)
    @posts = Post.all(params[:category],limit,offset)
    render :action => 'post'
  end

  def post_news
    @nav_class = 'cms'
    @title = "后台编辑——最新动态"
    params[:category] = Const::NEWS_POST_CATEGORY
    total_count = Post.posts_count(params[:category])
    limit, offset = process_paginate(total_count)
    @posts = Post.all(params[:category],limit,offset)
    render :action => 'post'
  end

  def post_edit
    @nav_class = 'cms'
    @title = "后台编辑——最新动态"
    if !params[:id].blank?
      @post = Post.find(params[:id])
    else
      @post = Post.new
    end
    @post.category = params[:category] if !params[:category].blank?
    if request.post?
      flash[:errors] = []
      @post.title = params[:post][:title] if !params[:post][:title].blank?
      @post.category = params[:post][:category] if !params[:post][:category].blank?
      @post.author = params[:post][:author] if !params[:post][:author].blank?
      @post.html_content = params[:post][:html_content] if !params[:post][:html_content].blank?
      if !params[:post]['publish_date(1i)'].blank?
        @post.publish_date = Date.new("#{params[:post]['publish_date(1i)']}".to_i,"#{params[:post]['publish_date(2i)']}".to_i,"#{params[:post]['publish_date(3i)']}".to_i)
      end
      @post.is_top = params[:post][:is_top].to_i
      @post.is_new = params[:post][:is_new].to_i

      if @post.save
        case @post.category.to_i
        when Const::NEWS_POST_CATEGORY.to_i
          redirect_to :action => 'post_news'
        when Const::BUY_POST_CATEGORY.to_i
          redirect_to :action => 'post_buy'
        when Const::FUN_POST_CATEGORY.to_i
          redirect_to :action => 'post_fun'
        else
          redirect_to :action => 'post'
        end
      else
        # 报错
        @post.errors.each do |attr_name,msg|
          flash.now[:errors] << msg
        end unless @post.errors.blank?     
      end
    end

  end

  def post_delete
    @post = Post.find(params[:id])
    @post.status = Post::STATUS_DELETED
    @post.save(false)
    render :update do |page|
      page.redirect_to :action => :post
    end
  end

  def feedback
    @nav_class = 'cms'
    @feedbacks = Feedback.find(:all, :conditions=>["status>0"], :order=>'id desc')
  end

  def feedback_delete
    @feedback = Feedback.find(params[:id])
    @feedback.status = Post::STATUS_DELETED
    @feedback.save(false)
    render :update do |page|
      page.redirect_to :action => :feedback
    end
  end

  # 首页内容编辑
  def cms_index
    @buy = IndexContent.get_content(:buy)
    @food = IndexContent.get_content(:food)
    @house = IndexContent.get_content(:house)
    @scene = IndexContent.get_content(:scene)
    @fun = IndexContent.get_content(:fun)
    @cs = IndexContent.get_content(:cs)
    
    @nav_class = "cms"
  end

  def cms_ask
    @ask = IndexContent.get_content(:ask)
    @nav_class = "cms"
  end

  def cms_food_info
    @food_info = IndexContent.get_content(:food_info)
    @nav_class = "cms"
  end

  def cms_house_info
    @house_info = IndexContent.get_content(:house_info)
    @nav_class = "cms"
  end
  
  def cms_cs_info
    @cs_info = IndexContent.get_content(:cs_info)
    @nav_class = "cms"
  end

  def update_buy
    @buy = IndexContent.get_content(:buy)
    if @buy.new_record?
      @buy = IndexContent.new(params[:index_content])
      @buy.category = Const::IC_CATEGORY[:buy]
      @buy.save
    else
      @buy.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_index", :anchor => "#i1"
  end

  def update_food
    @food = IndexContent.get_content(:food)
    if @food.new_record?
      @food = IndexContent.new(params[:index_content])
      @food.category = Const::IC_CATEGORY[:food]
      @food.save
    else
      @food.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_index", :anchor => "#i2"    
  end

  def update_house
    @house = IndexContent.get_content(:house)
    if @house.new_record?
      @house = IndexContent.new(params[:index_content])
      @house.category = Const::IC_CATEGORY[:house]
      @house.save
    else
      @house.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_index", :anchor => "#i3"    
  end

  def update_scene
    @scene = IndexContent.get_content(:scene)
    if @scene.new_record?
      @scene = IndexContent.new(params[:index_content])
      @scene.category = Const::IC_CATEGORY[:scene]
      @scene.save
    else
      @scene.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_index", :anchor => "#i4"    
  end

  def update_fun
    @fun = IndexContent.get_content(:fun)
    if @fun.new_record?
      @fun = IndexContent.new(params[:index_content])
      @fun.category = Const::IC_CATEGORY[:fun]
      @fun.save
    else
      @fun.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_index", :anchor => "#i5"    
  end

    def update_ask
    @ask = IndexContent.get_content(:ask)
    if @ask.new_record?
      @ask = IndexContent.new(params[:index_content])
      @ask.category = Const::IC_CATEGORY[:ask]
      @ask.save
    else
      @ask.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_ask"    
  end

  def update_house_info
    @house_info = IndexContent.get_content(:house_info)
    if @house_info.new_record?
      @house_info = IndexContent.new(params[:index_content])
      @house_info.category = Const::IC_CATEGORY[:house_info]
      @house_info.save
    else
      @house_info.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_house_info"    
  end

  def update_food_info
    @food_info = IndexContent.get_content(:food_info)
    if @food_info.new_record?
      @food_info = IndexContent.new(params[:index_content])
      @food_info.category = Const::IC_CATEGORY[:food_info]
      @food_info.save
    else
      @food_info.update_attributes(params[:index_content])
    end
    redirect_to :controller => "admin", :action => "cms_food_info"    
  end

  private
  def check_auth
    if session[:auth] == 'asdf'
      return true
    else
      redirect_to :action => 'login'
    end
  end

end
