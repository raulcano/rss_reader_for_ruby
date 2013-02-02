# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery.ajaxSetup beforeSend: (xhr) ->
   xhr.setRequestHeader "Accept", "text/javascript"

  
jQuery(document).ready ->
  # The following checks if there is any input field that passes the 
  # feed_source_id, as it is defined in the "show" view for feed_sources
  # In that case, the "checkScroll" function is loaded
  feedSourceId = jQuery("#feed_source_id").val()
  checkScroll()  if typeof feedSourceId isnt "undefined"
  
  # We enable the search box to be submitted by AJAX on every key stroke
  $("#feed_entries_search input").keyup ->
    $.get $("#feed_entries_search").attr("action"), $("#feed_entries_search").serialize(), null, "script"
    false
  
  # This has to do with the action of updating entries, so the ajax loader is shown/hidden
  fadeInLoading = ->
    $("#loading").fadeIn()
  fadeOutLoading = ->
    $("#loading").fadeOut()
  fadeInOutNewEntriesNotification= ->
    $("#new_items_notification").fadeIn "slow", ->
      $("#new_items_notification").fadeOut 5000
    
  $("#feed_source_refresh").bind("ajax:beforeSend", fadeInLoading).bind "ajax:complete", fadeOutLoading
  $("#feed_source_refresh").bind "ajax:complete", fadeInOutNewEntriesNotification