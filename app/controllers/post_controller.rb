class PostController < ApplicationController
  layout "default"

  def index
    params[:id] ||= 0
    @category = params[:id].to_i

    total_count = Post.posts_count(@category)
    limit, offset = process_paginate(total_count, 20)
    @posts = Post.all(@category,limit, offset)

    @posts_rank =Post.ranks(10)
    @title = "农家乐研究"
    @nav_class = "new_wrap"
  end

  # 最新动态
  def news
    params[:id] = 1
    @category = params[:id].to_i

    total_count = Post.posts_count(@category)
    limit, offset = process_paginate(total_count, 10)
    @posts = Post.all(@category,limit, offset)

    @title = "最新动态"
    @nav_class = "info"
  end

  # 土特产代购
  def buy
    @post = Post.buy_info
    @title = "土特产代购"
    @nav_class = "info"
  end

  def search
    params[:id] = nil # 左侧导航用
    
    total_count = Post.search_count(params[:category], params[:keyword])
    limit, offset = process_paginate(total_count, 10)
    @posts = Post.search(params[:category], params[:keyword],limit, offset)

    @posts_rank =Post.ranks(10)
    
    @title = "搜索结果"
    @nav_class = "new_wrap"
    render :action => "index"
  end

  def show
    @post = Post.find(params[:id])
    params[:category] ||= @post.category
    @category = params[:category].to_i
    @post.update_attribute(:hits, @post.hits+1)

    @comments_count = @post.comments_count
    limit, offset = process_paginate(@comments_count, 10)
    @comments = @post.comments(limit,offset)
    
    @title = @post.title
    
    if @category == 1
      @nav_class = "info"
    elsif @category == -1
      @nav_class = "fun"
      render :action => "fun" and return
    else
      @posts_rank =Post.ranks(10)
      @nav_class = "new_wrap"
    end
  end

  def comment
    @comment = Comment.new
    @comment.post_id = params[:id]
    @comment.content = params[:comment][:content] unless params[:comment][:content].blank?
    @comment.username = params[:comment][:username] unless params[:comment][:username].blank?
    render :update do |page|
      if @comment.save
        page.redirect_to :controller => "post",  :action => 'show', :id => params[:id]
      else
        page.call "alert", @comment.errors.map{|e| e.last}.join("\n")
      end
    end
  end

  def comment_delete
    if session[:auth] == 'asdf'
      @comment = Comment.find(params[:id])
      @comment.status = Comment::STATUS_DELETED
      @comment.save(false)
      render :update do |page|
        page.remove "comment_#{params[:id]}"
      end
    else
      render :update do |page|
        flash[:error] = "您没有权限执行该操作，请登陆"
        page.redirect_to :controller => 'admin', :action => 'login'
      end
    end
  end

end
