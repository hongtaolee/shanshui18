ActionController::Routing::Routes.draw do |map|
  map.connect "lxwm", :controller => "public", :action => "lxwm"
  map.connect "/food/:id", :controller => "picture", :action => "index"
  map.connect "/house/:id", :controller => "picture", :action => "index"
  map.connect "/cs/:id", :controller => "picture", :action => "index"  
  map.connect "lxwm", :controller => "public", :action => "lxwm"
  map.root :controller => "index"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
