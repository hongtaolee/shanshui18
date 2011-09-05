class PublicController < ApplicationController
  layout "default"

  def lxwm
    @title = "联系我们"
    @nav_class = 'contact'
    @ask = IndexContent.get_content(:ask)
  end

end
