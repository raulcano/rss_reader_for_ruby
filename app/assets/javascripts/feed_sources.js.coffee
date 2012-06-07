# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery.ajaxSetup beforeSend: (xhr) ->
  xhr.setRequestHeader "Accept", "text/javascript"

# The following checks if there is any input field that passes the 
# feed_source_id, as it is defined in the "show" view for feed_sources
# In that case, the "checkScroll" function is loaded
jQuery(document).ready ->
  feedSourceId = jQuery("#feed_source_id").val()
  checkScroll()  if typeof feedSourceId isnt "undefined"