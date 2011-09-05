// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function addBookmark(title,url) {
  if (window.sidebar) {
    window.sidebar.addPanel(title, url,"");
  } else if( document.all ) {
    window.external.AddFavorite( url, title);
  } else if( window.opera && window.print ) {
    return true;
  }
}

function showSubnav(nav,cur){
  if(nav == cur) {
    Element.show('subnav_' + nav);
  }else{
    Element.show('subnav_' + nav);
    Element.hide('subnav_' + cur);
  }
}

function hideSubnav(nav,cur){
  if(nav == cur) {
    Element.show('subnav_' + nav);
  }else{
    Element.show('subnav_' + cur);
    Element.hide('subnav_' + nav);
  }
}
