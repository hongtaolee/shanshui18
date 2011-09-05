class IndexController < ApplicationController
  layout "default"

  def index
    @posts = Post.recent(4)
    @buy = IndexContent.get_content(:buy)
    @food = IndexContent.get_content(:food)
    @house = IndexContent.get_content(:house)
    @scene = IndexContent.get_content(:scene)
    @fun = IndexContent.get_content(:fun)
  end
end
