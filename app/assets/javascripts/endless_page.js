var currentPage = 1;
function checkScroll() {
  //console.log("checkScroll"+(Date.now()/1000));
  var feedSourceId = $("#feed_source_id").val();
  if (nearBottomOfPage()) {
    currentPage++;
    var search = $("#search").val();
    $('#loading_pagination').show();
    //we have to include in this request the search parameters
    $.ajax({url: "/feed_sources/" + feedSourceId + "?page=" + currentPage
    		+ "&search=" + search + "&utf8=✓&submit=pagination",
    		async: true, 
    		type:"get"})
     .done(function(){$('#loading_pagination').hide()});
  } else {
    setTimeout(checkScroll, 1000);
  }
}

function nearBottomOfPage() {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom(argument) {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight() {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

