(function($){
  var settings;
  
  $.bottomlessPagination = function(callerSettings) {
    settings = $.extend({
      ajaxLoaderPath:'../assets/ajax-loader.gif',
      results:'.feed_entries',
      objName:'entries',
      callback:null
    },callerSettings||{});
    
    settings.imgLoader = new Image();
    settings.imgLoader.src = settings.ajaxLoaderPath;
    settings.href = $(".next_page a").attr("href");
    
    // Get the total number of pages from the last numbered pagination link
    //last_pagination_link = $(".pagination a").not(".next_page, .previous_page").last();
   	// The previous is not working with the current version of will_paginate
   	// since there are no .next_page or .previous_page attributes anymore
   	console.log($('div.pagination').size());
   	console.log($('div'));
   	
    last_pagination_link = $(".pagination a")[$(".pagination a").size()-2];
    //settings.total_pages = getPageNumber(last_pagination_link.attr('href'));
	settings.total_pages = 3;
  	
  	// If pagination exists, hide existing and append the bottomless pagination html
    if ($('div.pagination').size() > 0){
      $('div.pagination').wrap("<div class='pagination_links'></div>").hide();
      
      $('.pagination_links').append(
        "<div class='clearfix live_pagination'><div>" +
          "<a class='more_links'>More " + settings.objName + "<span class='icon'></span></a>" +
        "</div></div>"
      );
      
      // Setup the loader. If no image provided use a text message. Loader is initially hidden.
      if ((settings.ajaxLoaderPath == '') || (settings.ajaxLoaderPath == null)) {
        $(".more_links").after("<div class='now_loading'>Loading...</div>");
      } else {
        $(".more_links").after("<div class='now_loading'><img src='"+settings.imgLoader.src+"' /></div>");
      }
      
      $(".now_loading").hide();
    }
    
    $(".more_links").click(function(e){
      e.preventDefault();
      $(".more_links").hide();
      $(".now_loading").show();
      
      // Get the data & update links
      $.get(settings.href,function(data){
          $(settings.results).addrows(data);
          $(".now_loading").hide();
          $(".more_links").show();
        }
      );
      return false;
    });
    
    $.fn.addrows = function(data) {
    	
      curr_page = getPageNumber(settings.href);
      $(settings.results).append(data);
      
      // Replace live pagination if there are no more results, else update the href for the next page
      if (curr_page == settings.total_pages) {
        $('.live_pagination').remove();
        $('.pagination_links').append('<div class="live_pagination back_to_top"><a href="#" class="top">Back to top &uarr;</a></div>');
        return false;
      } else {
        next_page = curr_page + 1;
        settings.href = settings.href.replace('page=' + curr_page, 'page=' + next_page.toString());
      }
      
      if (settings.callback) settings.callback();
    };
    
    function getPageNumber(url) {
      pageRE = /page=(\d+)/;
      pageMatch = url.match(pageRE);
      return parseInt(pageMatch[1]);
    };
    
  };
})(jQuery);