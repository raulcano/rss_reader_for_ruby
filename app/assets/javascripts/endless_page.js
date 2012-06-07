var currentPage = 1;
function checkScroll() {
  var feedSourceId = $("#feed_source_id").val();
  if (nearBottomOfPage()) {
    currentPage++;
    $.ajax({url: "/feed_sources/" + feedSourceId + "?page=" + currentPage,
    		async: true, 
    		type:"get"})
  } else {
    setTimeout(checkScroll);
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

