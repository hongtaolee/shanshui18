class FeedbackController < ApplicationController
  layout "default"

  # 留言
  def index
    @feedback = Feedback.new
    @feedbacks_count = Feedback.feedbacks_count
    limit, offset = process_paginate(@feedbacks_count, 5)
    @feedbacks = Feedback.feedbacks(limit, offset)

    @title = "用户反馈"
    @nav_class = 'contact'
  end

  def create
    @feedback = Feedback.new(params[:feedback])

    render :update do |page|
      if @feedback.save
        page.call "alert", "留言成功!"
        page.redirect_to :controller => "feedback", :action => "index"
      else
        page.call "alert", @feedback.errors.map{|e| e.last}.join("\n")
      end
    end
  end

  def reply
    @feedback = Feedback.find(params[:id])
    render :update do |page|
      if manager?
        if params[:reply].blank?
          page.call "alert", "回复内容不能为空"
        else
          begin
            @feedback.update_attribute(:reply, params[:reply])
            page.replace_html "feedback_item_#{params[:id]}", :partial => "item", :locals => {:f => @feedback.reload}
          rescue Exception => e
            page.call "alert", e.to_s
          end
        end
      else
        page.call "alert", "你没有权限执行该操作！"
      end
    end
  end

  def remove
    render :update do |page|
      if manager?
        @feedback = Feedback.find(params[:id])
        begin
          @feedback.remove!
          page.remove "feedback_item_#{params[:id]}"
        rescue Exception => e
          page.call "alert", e.to_s
        end
      else
        page.call "alert", "你没有权限执行该操作！"
      end
    end
  end

end
