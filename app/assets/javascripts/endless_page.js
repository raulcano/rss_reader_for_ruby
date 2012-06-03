var currentPage = 1;
var feedSourceId = 2; // Temporal value until I figure out the best way to pass the value
function checkScroll() {
  if (nearBottomOfPage()) {
    currentPage++;
    $.ajax({url: "/feed_sources/" + feedSourceId + "?page=" + currentPage,
    		async: true, 
    		type:"get"})
  } else {
  	
    setTimeout("checkScroll()", 2000);
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

